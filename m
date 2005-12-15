From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001636]: Adding support for SB Audigy SE
Date: Thu, 15 Dec 2005 19:27:53 +0100
Message-ID: <736792e93672f30a51c9f131539644a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 68B3F198
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2005 19:27:53 +0100 (MET)
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
Status:                     feedback
Distribution:               GNU/Linux DeMuDi 1.2.1
Kernel Version:             2.6.12-3-mm-k7
======================================================================
Date Submitted:             12-10-2005 17:53 CET
Last Modified:              12-15-2005 19:27 CET
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
 jcdutton - 12-13-05 11:58 
----------------------------------------------------------------------
Please try this patch to alsa-driver.
I also need to know the serial number or model number of the card.
It should be written on the box the card came in, otherwise, the model
number will be on the card itself.
e.g. SB0410
I can then fill in the SBxxxx bit of the patch, and I can then update the
kernel.

----------------------------------------------------------------------
 phormion - 12-15-05 19:27 
----------------------------------------------------------------------
Hello, 

I also have an Audigy SE, and had some problems with it on Linux. At least
the first time I tried it, it would only produce some feedback-like noise,
and I had to turn the speakers down. I googled a bit, found this bug and
some other discussions, so I decided that today I'd try to compile the
alsa-driver code in CVS with the provided patch. However, now the audigy
SE seems to work! 

I was thinking of trying the patch however - is it safe to backup the old
alsa module(s) and overwrite with the patched one, or do I need to update
the alsa-tools stuff? 

It is also detected as Audigy LS, the driver used is also ca0106. By the
way, jcdutton, the model number on the card is SB0570. 

My system is a Mandriva 2006.0 Official, with kernel 2.6.12(-12mdk), the
alsa version is 1.0.9b.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 17:53 chgans         New Issue                                    
12-10-05 17:53 chgans         Distribution              => GNU/Linux DeMuDi
1.2.1
12-10-05 17:53 chgans         Kernel Version            => 2.6.12-3-mm-k7  
12-11-05 21:02 chgans         Issue Monitored: chgans                      
12-12-05 11:05 chgans         Note Added: 0006983                          
12-12-05 20:05 chgans         Note Edited: 0006983                         
12-12-05 20:06 chgans         File Added: sb_audigy_se-proc.dump                
   
12-12-05 20:34 davee          Issue Monitored: davee                       
12-12-05 21:07 davee          Note Added: 0006986                          
12-13-05 11:56 jcdutton       File Added: sb-audigy-se.fix.diff                 
  
12-13-05 11:58 jcdutton       Note Added: 0006989                          
12-13-05 11:59 jcdutton       Status                   assigned => feedback
12-15-05 19:27 phormion       Note Added: 0007052                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
