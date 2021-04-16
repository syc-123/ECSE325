--
-- entity name: g25_Hash_Core
--
-- Version 1.0
-- Authors: YICHENG SONG, YINUO WANG, YUJIE QIN
-- Date: March 22, 2021

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g25_Hash_Core is
 port (	A_o, B_o, C_o, D_o, E_o, F_o, G_o, H_o : 	inout std_logic_vector (31 downto 0); 
			A_i, B_i, C_i, D_i, E_i, F_i, G_i, H_i: 	in std_logic_vector (31 downto 0);
			Kt_i, Wt_i : 										in std_logic_vector (31 downto 0);
			LD, CLK: 											in std_logic);
					
end g25_Hash_Core;

architecture implementation of g25_Hash_Core is

signal reg_a, reg_b, reg_c, reg_d, reg_e, reg_f, reg_g, reg_h : std_logic_vector(31 downto 0);
signal SIG0, SIG1, CH, MAJ : std_logic_vector(31 downto 0);
signal reg_a_0, reg_e_0 : std_logic_vector(31 downto 0);

component g25_SIG_CH_MAJ
	 port (A_o, B_o, C_o, E_o, F_o, G_o : in std_logic_vector(31 downto 0);
		SIG0, SIG1, CH, MAJ	    : out std_logic_vector(31 downto 0)
		);
end component;

begin

Gate1: g25_SIG_CH_MAJ port map(A_o=>A_o, B_o=>B_o, C_o=>C_o, E_o=>E_o, F_o=>F_o, G_o=>G_o, SIG0=>SIG0, SIG1=>SIG1, MAJ=>MAJ, CH=>CH);

reg_a_0 <= std_logic_vector(unsigned(SIG0) + unsigned(MAJ) + unsigned(SIG1) + unsigned(CH) + unsigned(H_o) + unsigned(Kt_i) + unsigned(Wt_i));
reg_e_0 <= std_logic_vector(unsigned(D_o) + unsigned(SIG1) + unsigned(CH) + unsigned(Kt_i) + unsigned(Wt_i) + unsigned(H_o));


clock_process: process(LD, CLK)
begin
	if rising_edge(CLK) then
		A_o <= reg_a;
		B_o <= reg_b;
		C_o <= reg_c;
		D_o <= reg_d;
		E_o <= reg_e;
		F_o <= reg_f;
		G_o <= reg_g;
		H_o <= reg_h;
		
		if LD = '1' then
        reg_a <= A_i;
		  reg_b <= B_i;
		  reg_c <= C_i;
		  reg_d <= D_i;
		  reg_e <= E_i;
		  reg_f <= F_i;
		  reg_g <= G_i;
		  reg_h <= H_i;		
		  
		else
			reg_h <= G_o;
			reg_g <= F_o;
			reg_f <= E_o;
			reg_e <= reg_e_0;
			reg_d <= C_o;
			reg_c <= B_o;
			reg_b <= A_o;
			reg_a <= reg_a_0;
    end if; 
		
	 
	 
	 
	end if;
end process;

end implementation;
