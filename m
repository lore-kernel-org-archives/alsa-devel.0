From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001297]: driver can't initialise card
Date: Tue, 13 Dec 2005 13:27:43 +0100
Message-ID: <8174c65a9ca106e215553d2d02d455ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CA75B1C8
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 13:27:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1297> 
======================================================================
Reported By:                hus
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1297
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 4 (mostly)
Kernel Version:             2.6.12
Resolution:                 reopened
Fixed in Version:           
======================================================================
Date Submitted:             08-01-2005 14:27 CEST
Last Modified:              12-13-2005 13:27 CET
======================================================================
Summary:                    driver can't initialise card
Description: 
My card is a somewhat older SB Live! (says "SB Live! Platinum 5.1" on the
box).
The snd-emu10k1 module refuses to work for this card; the kernel logs:

ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 17 (level, low) -> IRQ 17
ALSA sound/pci/emu10k1/emu10k1_main.c:742: vendor=0x1102, device=0x2, 
subsystem_vendor_id=0x80611102, subsystem_id=0x8061
ALSA sound/pci/emu10k1/emu10k1_main.c:760: Soundcard name=SB Live
[Unknown], 
vendor=0x1102, device=0x2, subsystem=0x80611102
ALSA sound/pci/ac97/ac97_codec.c:1888: AC'97 0 does not respond - RESET
ALSA sound/pci/ac97/ac97_codec.c:1897: AC'97 0 access is not valid [0x0],

removing mixer.
EMU10K1_Audigy: probe of 0000:02:05.0 failed with  error -5

lspci shows
02:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs SBLive! Player 5.1
        Flags: bus master, medium devsel, latency 64, IRQ 17
        I/O ports at 30c0 [size=32]
        Capabilities: [dc] Power Management version 1
(-n: Class 0401: 1102:0002 (rev 07) Subsystem: 1102:8061)


The only deviation from the ordinary I can think of is that my system is
dual CPU, a Tyan Tiger MPX (S2466), and has it's PCI slots (iirc) behind a
PCI-to-PCI bridge. That's one thing our systems might have in common, as
your message shows the card on bus 03. Perhaps this is some strange kind
of routing problem?
======================================================================

----------------------------------------------------------------------
 mchouque - 09-29-05 01:39 
----------------------------------------------------------------------
Same here, same git tag (cf dstaaf). If I put the following back in, it
works again.

Here's my card:
0 [Live           ]: EMU10K1 - SBLive! Platinum 5.1 [SB0060]
                     SBLive! Platinum 5.1 [SB0060] (rev.7,
serial:0x80611102) at 0x8400, irq 14


--- emu10k1_main.c.orig 2005-09-14 21:07:48.000000000 -0400
+++ emu10k1_main.c      2005-09-28 19:32:20.000000000 -0400
@@ -759,6 +759,7 @@
         .driver = "EMU10K1", .name = "SBLive! Platinum 5.1 [SB0060]", 
         .id = "Live",
         .emu10k1_chip = 1,
+        .ac97_chip = 1,
         .sblive51 = 1} ,
        {.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
         .driver = "EMU10K1", .name = "SBLive! Value [CT4850]",



----------------------------------------------------------------------
 jcdutton - 12-13-05 13:27 
----------------------------------------------------------------------
Both of the issues described in this bug should be fixed now in alsa-driver
1.0.10

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-01-05 14:27 hus            New Issue                                    
08-01-05 14:27 hus            Distribution              => Fedora Core 4
(mostly)
08-01-05 14:27 hus            Kernel Version            => 2.6.12          
08-01-05 14:28 hus            Issue Monitored: hus                         
08-01-05 15:24 jcdutton       Status                   new => assigned     
08-01-05 15:24 jcdutton       Assigned To               => jcdutton        
08-13-05 00:38 jcdutton       File Added: fix.diff.txt                     
08-13-05 00:39 jcdutton       Note Added: 0005795                          
08-13-05 00:40 jcdutton       Status                   assigned => feedback
08-13-05 21:18 hus            Note Added: 0005809                          
08-13-05 21:38 rlrevell       Note Added: 0005810                          
08-14-05 00:32 hus            Note Added: 0005813                          
09-10-05 13:00 jcdutton       Status                   feedback => closed  
09-10-05 13:00 jcdutton       Note Added: 0006114                          
09-13-05 00:16 jcdutton       Status                   closed => feedback  
09-13-05 00:16 jcdutton       Resolution               open => reopened    
09-13-05 00:16 jcdutton       Note Added: 0006150                          
09-19-05 20:20 selflein       Note Added: 0006299                          
09-19-05 21:08 hus            Note Added: 0006300                          
09-24-05 17:54 dstaaf         Note Added: 0006374                          
09-29-05 01:38 mchouque       Note Added: 0006412                          
09-29-05 01:39 mchouque       Note Edited: 0006412                         
09-29-05 02:06 mchouque       Issue Monitored: mchouque                    
12-13-05 13:27 jcdutton       Status                   feedback => closed  
12-13-05 13:27 jcdutton       Note Added: 0007010                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
