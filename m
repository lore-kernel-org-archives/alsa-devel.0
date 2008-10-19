From: James Courtier-Dutton <James@superbug.co.uk>
Subject: snd-xfi info
Date: Sun, 19 Oct 2008 13:12:40 +0100
Message-ID: <48FB2438.2060300@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EED7243D1
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 14:13:01 +0200 (CEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.0.10])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.67)
	id 1KrX9G-0009Pa-CF
	for alsa-devel@alsa-project.org; Sun, 19 Oct 2008 12:12:43 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Trying to answer some question raised by comments in the current code.
1) The card should be able to DMA to anywhere in a 64-bit address space.
  It is set to 32bit DMA by default. A bit has to be set to turn on 64-bit.
2) GPIOs
> GPIOs
> SB046x / SB067x / SB0760
> Bit	In/Out	Def	Use
> 0: 			Not used
> 1: 	Out	0	Reset DAC
> 2:	Out	0	Int_Drv_SpdifBypas (1 = Bypass)
> 3:			Not Used
> 4:			Not Used
> 5:	Out	0	In_Drv_DAC_SR (0=48kHz, 1=96kHz)
> 6:	Out	0	Back_Bracket_Lineouts_Mute (0=Mute)
> 7:	Out	0	Mic/Line select( 0=Line, 1=Mic)
> 8:	Out	1	Digital IO Select (0 = Digital, 1 = Analog)
> 9:	In	-	Int_Drv_Headphone_Det (1 = headphone detected)
> 10:			Not used
> 11:	In	-	FP_Headphone_Det (0 = headphone detected)
> 12:			Not used
> 13:	In	-	LineOut3 detect (1 = jack inserted)
> 14:	In	-	LineOut2 detect (1 = jack inserted)
> 15:	In	-	LineOut1 detect (1 = jack inserted)
> 
> SB073x
> Bit	In/Out	Def	Use
> 0: 			Not used
> 1: 	Out	0	Reset DAC
> 2:	Out	0	Int_Drv_SpdifBypas (1 = Bypass)
> 3:			Not Used
> 4:			Not Used
> 5:	Out	0	In_Drv_DAC_SR (0=48kHz, 1=96kHz)
> 6:	Out	0	Back_Bracket_Lineouts_Mute (0=Mute)
> 7:	Out	0	Mic/Line select( 0=Line, 1=Mic)
> 8:	In	-	Line/Mic In detect (0 = jack inserted???)
> 9:	In	-	Int_Drv_Headphone_Det (1 = headphone detected)
> 10:			Not used
> 11:	In	-	FP_Headphone_Det (0 = headphone detected)
> 12:	In	-	Digital Out detect (1 = detected)
> 13:	In	-	LineOut3 detect (1 = jack inserted)
> 14:	In	-	LineOut2 detect (1 = jack inserted)
> 15:	In	-	LineOut1 detect (1 = jack inserted)
> 
> Vista compatible
> Bit	In/Out	Def	Use
> 0: 	In	-	FP_Linein_detect (1 = jack inserted)
> 1: 	Out	0	Reset DAC
> 2:			Not Used
> 3:			Not Used
> 4:			Not Used
> 5:			Not Used
> 6:	Out	0	Back_Bracket_Lineouts_Mute (0=Mute)
> 7:	Out	0	Mic/Line select( 0=Line, 1=Mic)
> 8:	In	-	Line/Mic In detect (1 = jack inserted???)
> 9:	In	-	FP_MicIn_Detect (1 = jack inserted)
> 10:			Not used
> 11:	In	-	FP_Headphone_Det (0 = headphone detected)
> 12:	In	-	LineOut4 detect (1 = detected)
> 13:	In	-	LineOut3 detect (1 = jack inserted)
> 14:	In	-	LineOut2 detect (1 = jack inserted)
> 15:	In	-	LineOut1 detect (1 = jack inserted)
> 
> SB055x
> Bit	In/Out	Def	Use
> 0: 	In	-	FP_Mic_detect (1 = jack inserted)
> 1: 	Out	0	Mute all analog inputs(0=Mute)
> 2:	Out	0	ADC_Gain (0=boost off, 1=boost on)
> 3:	Out	1	SPDIFOut0 Unmute (0=Mute, 1=Unmute)
> 4:	Out	0	FP_Mic_select( 1=FPMic)
> 5:	Out	0	Ext_Drv_DAC_SR (0=48kHz, 1=96kHz)
> 6:	Out	0	Lineout1_Mute (1=Mute)
> 7:	Out	0	Mic power on(1=Power on)
> 8:	Out	0	Digital IO Select (0 = Analog, 1=Digital)
> 9:	Out	0	Mic_sw(0=Line/Aux, 1=FP/BP Mic)
> 10:			Not used
> 11:	In	-	FP_Headphone_Det (0 = headphone detected)
> 12:	Out	0	AuxMicLine sw(0=MicLine)
> 13:	In	-	LineOut3 detect (1 = jack inserted)
> 14:	In	-	LineOut2 detect (1 = jack inserted)
> 15:	In	-	LineOut1 detect (1 = jack inserted)
> 

> Card Family
> SB046x /
> SB067x /
> SB076x
> =
> Subsystem ID
> 0x0021
> 0x0023
> 0x0024
> 0x0025
> 0x0026
> 0x0027
> 0x0028
> 0x002A
> 0x002B
> 0x002C
> 0x002D
> 0x002E
> 0x0032
> 0x0033
> 
> Card Family
> SB073x
> =
> Subsystem ID
> 0x0029
> 0x0031
> 
> Card Family
> SB055x
> =
> Subsystem ID
> 0x0022
> 0x002F
> 
> Card Family
> Vista Compatible  Hardware
> =
> Subsystem ID
> Range from 0x6000 to 0x6FFF
> 

More later

James
