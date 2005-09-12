From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001297]: driver can't initialise card
Date: Tue, 13 Sep 2005 00:16:30 +0200
Message-ID: <eac50555dcf8f89bd79ea9fd9095e736@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E51991C8
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2005 00:16:30 +0200 (MEST)
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


The following issue has been REOPENED.
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
Status:                     feedback
Distribution:               Fedora Core 4 (mostly)
Kernel Version:             2.6.12
======================================================================
Date Submitted:             08-01-2005 14:27 CEST
Last Modified:              09-13-2005 00:16 CEST
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
 jcdutton - 09-10-05 13:00 
----------------------------------------------------------------------
Bug fix now in CVS. 10-Sept-2005

----------------------------------------------------------------------
 jcdutton - 09-13-05 00:16 
----------------------------------------------------------------------
Can you please remove your sound card from the PC and tell me what is says
on the card for the model number. It should be something like "SB0350".
We seem to have two different cards with exactly the same PCI IDs and I
would like to see what the differences are.

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
