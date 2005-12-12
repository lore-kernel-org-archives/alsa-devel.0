From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001636]: Adding support for SB Audigy SE
Date: Mon, 12 Dec 2005 11:05:50 +0100
Message-ID: <3a2d3fcfecb938907520f36453fcd168@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D5CF51AA
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2005 11:05:50 +0100 (MET)
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
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1636> 
======================================================================
Reported By:                chgans
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1636
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               GNU/Linux DeMuDi 1.2.1
Kernel Version:             2.6.12-3-mm-k7
======================================================================
Date Submitted:             12-10-2005 17:53 CET
Last Modified:              12-12-2005 11:05 CET
======================================================================
Summary:                    Adding support for SB Audigy SE
Description: 
The Audigy SE is a card with the ca0106 chipset.
It is reconized as "Creative Labs SB Audigy LS", the driver doesn't load,
here is the kernel message:
PCI: Found IRQ 10 for device 0000:00:0d.0
Model 100a Rev 00000000 Serial 100a1102
AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0x0], removing mixer.
CA0106: probe of 0000:00:0d.0 failed with error -5

here is the revelant part of output of lspci -vv:
0000:00:0d.0 Multimedia audio controller: Creative Labs SB Audigy LS
        Subsystem: Creative Labs: Unknown device 100a
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


I have see in the ca0106 driver source that the "Audigy LS" is the last
entry (the default) of the supported card list.

So i wonder if it should be easy to get support for this board.


======================================================================

----------------------------------------------------------------------
 chgans - 12-12-05 11:05 
----------------------------------------------------------------------
I just take a try with alsa 0.10.0, now the module load successfully, but i
can't get any sound when i play a file.

I get strange behaviour, when playing with "capture" volume and "SPDIFout"
mute, i get noises in my speakers plugged at "Front ouput" or i get no
sound at all.
The card is a 5.1 output, but i am using only 2.1 for the moment.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 17:53 chgans         New Issue                                    
12-10-05 17:53 chgans         Distribution              => GNU/Linux DeMuDi
1.2.1
12-10-05 17:53 chgans         Kernel Version            => 2.6.12-3-mm-k7  
12-11-05 21:02 chgans         Issue Monitored: chgans                      
12-12-05 11:05 chgans         Note Added: 0006983                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
