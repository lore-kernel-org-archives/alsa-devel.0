From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001636]: Adding support for SB Audigy SE
Date: Thu, 15 Dec 2005 21:26:26 +0100
Message-ID: <5e9010be8b2ad01f3f8b98be5ec1cdb4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 613B91C3
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2005 21:26:26 +0100 (MET)
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
Last Modified:              12-15-2005 21:26 CET
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
 davee - 12-15-05 20:14 
----------------------------------------------------------------------
phormion: I'm intrigued that the sb-audigy-se.fix.diff patch worked for
you, since it appears that (at least according to the kernel messages when
loading the driver), the card has serial 100a1102 - not the same as in the
patch which James wrote!  However, I have found that even by modifying his
patch to use that serial number, although the driver now loads cleanly, I
still have no sound.

Fuller details of my experience are contained in my alsa-user post here:
http://article.gmane.org/gmane.linux.alsa.user/21439 and elsewhere in the
same thread.

I'm glad you've got it working, phormion.  Could you post the results of
'dmesg' when loading the driver and of 'lspci -vv' for your card?  (I'm
just wondering whether it is really the same card or not, especially given
the serial number differences!)

----------------------------------------------------------------------
 phormion - 12-15-05 21:26 
----------------------------------------------------------------------
davee, you're misunderstanding, I *didn't* try the patch. Somehow, don't
ask me how, the card started working with my present alsa driver. I've
built a patched driver, I'm thinking of trying it shortly. 

dmesg doesn't say anything about the sound card or alsa, only (notice the
serial): 
PCI: Found IRQ 10 for device 0000:00:0a.0
PCI: Sharing IRQ 10 with 0000:00:10.2
PCI: Sharing IRQ 10 with 0000:00:11.5
Model 100a Rev 00000000 Serial 100a1102

lspci -vv

00:0a.0 Multimedia audio controller: Creative Labs SB Audigy LS
        Subsystem: Creative Labs: Unknown device 100a
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d000 [size=32]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

cat /proc/asound/cards: 
0 [CA0106         ]: CA0106 - CA0106
                     AudigyLS [Unknown] at 0xd000 irq 10
1 [V8235          ]: VIA8233 - VIA 8235
                     VIA 8235 with ALC650F at 0xe400, irq 10

cat /proc/asound/devices:

 19: [0- 3]: digital audio playback
 27: [0- 3]: digital audio capture
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 17: [0- 1]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
  1:       : sequencer
 33:       : timer
 49: [1- 1]: digital audio playback
 57: [1- 1]: digital audio capture
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 32: [1- 0]: ctl

I mentioned the alsa-driver version, it's 1.0.9b.

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
12-15-05 20:14 davee          Note Added: 0007053                          
12-15-05 21:26 phormion       Note Added: 0007054                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
