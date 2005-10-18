From: =?ISO-8859-15?Q?Hor=E1cio_Hiroiti_Sawame?= <horacio@lit.inpe.br>
Subject: LG Netodragon PCI modem support request for snd-intel8x0m
Date: Tue, 18 Oct 2005 17:41:15 -0200
Message-ID: <43554FDB.5060502@lit.inpe.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from net3.lit.inpe.br (net3.lit.inpe.br [150.163.13.242])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1EEAC161
	for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2005 21:41:20 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: perex@suse.cz, sashakh@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi !

I have a PCI modem LG Netodragon and I think it should be supported by 
your snd-intel8x0m driver.
This modem is supported by slmodem package but when new kernel version 
is released the binary code (slamr) sometimes breaks. So I tested the 
alsa driver in a HP Compaq nx7010 (Intel 82801DB-ICH4 Modem) and worked. 
But in my house a can not work with the Netodragon modem.

Some information:

# lspci -s 00:07.0 -n
0000:00:07.0 Class 0703: 10b9:5459

# lspci -s 00:07.0 -vvv
0000:00:07.0 Modem: ALi Corporation SmartLink SmartPCI561 56K Modem 
(prog-if 00 [Generic])
	Subsystem: Smart Link Ltd.: Unknown device 5459
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 209
	Region 0: Memory at cfffe000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at e800 [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-- 
Horacio Hiroiti Sawame (e-mail: horacio@lit.inpe.br) Tecnologista Sr.
phone: +55(12)3945 6310 / fax: +55(12)3941 1884
MCT / INPE / LIT (http://www.lit.inpe.br)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
