From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001636]: Adding support for SB Audigy SE
Date: Tue, 20 Dec 2005 23:34:52 +0100
Message-ID: <c2b9d603bcedfea9e4abfc41af402559@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 084D21B6
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 23:34:52 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               GNU/Linux DeMuDi 1.2.1
Kernel Version:             2.6.12-3-mm-k7
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-10-2005 17:53 CET
Last Modified:              12-20-2005 23:34 CET
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
 vava - 12-20-05 12:07 
----------------------------------------------------------------------
Recently buy a Shuttle SD11G5 (pentium M)

Sound card reports as :
0000:02:09.0 Multimedia audio controller: Creative Labs SB Audigy LS

0000:02:09.0 0401: 1102:0007
        Subsystem: 1297:3041
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at c000 [size=32]
        Capabilities: [dc] Power Management version 2

0 [CA0106         ]: CA0106 - CA0106
                     AudigyLS [Unknown] at 0xc000 irq 19

recompiling my kernel Linux 2.6.14.4

and I got the same behaviour discribe in this bug report.
sound card seem to works fine, xmms and others players looks like
playing sound.

but after moving every switch on alsamixer, still no sound.
Could you confirm my problem is connected to this ?

Feel free to ask any extra informations required !



----------------------------------------------------------------------
 jcdutton - 12-20-05 23:34 
----------------------------------------------------------------------
See attachment audigy-se-fix.diff for a fix to this bug.
The fix is now in alsa-driver CVS, and will be in the next release after
the current one( 1.0.11rc1 )

I received the Audigy SE from creative today, and have checked the fix
works.

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
12-15-05 22:58 jcdutton       Note Added: 0007055                          
12-16-05 08:40 phormion       Note Added: 0007056                          
12-16-05 10:31 davee          Note Added: 0007058                          
12-16-05 11:26 thorsti        Issue Monitored: thorsti                     
12-16-05 15:14 chgans         Note Added: 0007059                          
12-16-05 18:06 phormion       Note Added: 0007061                          
12-17-05 14:36 Hessophanes    Issue Monitored: Hessophanes                    
12-17-05 15:22 phormion       Note Added: 0007063                          
12-17-05 18:48 jcdutton       Note Added: 0007066                          
12-17-05 23:58 phormion       Note Added: 0007069                          
12-20-05 12:06 vava           Note Added: 0007103                          
12-20-05 12:07 vava           Note Edited: 0007103                         
12-20-05 23:32 jcdutton       File Added: audigy-se-fix.diff                    
12-20-05 23:34 jcdutton       Status                   feedback => closed  
12-20-05 23:34 jcdutton       Note Added: 0007106                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
