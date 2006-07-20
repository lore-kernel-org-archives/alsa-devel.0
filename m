From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002261]: No sound with hda-intel ALC883
Date: Thu, 20 Jul 2006 17:28:46 +0200
Message-ID: <84289a1b9dda515d60fdd1e2733767f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2A340184
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 17:28:47 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2261> 
======================================================================
Reported By:                lodp2
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2261
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Kubuntu Dapper
Kernel Version:             2.6.15-25
======================================================================
Date Submitted:             07-06-2006 22:14 CEST
Last Modified:              07-20-2006 17:28 CEST
======================================================================
Summary:                    No sound with hda-intel ALC883
Description: 
I'm getting no sound on internal speakers, headphone and line jacks on my
Acer Aspire 1652 Z, which has a HDA-Intel card (Realtek ALC883 (ALC882?)
chip). What DOES work is recording, both internal mic and external. I
tried all model options I found for ALC883 in ALSA-Configuration.txt
(3stack-dig, 6stck-dig, auto, no option).

I frequently checked the settings in alsamixer (using alsamixergui), tried
muting/unmuting IEC958, Front, Line. Always tested using aplay *.wav.

I would have tried the latest HG version, but I ran into problems getting
it installed: I did a "./hgcompile --with-cards=hda-intel" and "sudo make
install", which both went through fine -- only "cat /proc/asound/version"
still tells me I've got version 1.0.12rc1, compiled two days ago. I would
appreciate any pointers, as I'm relatively new to this whole business..
======================================================================

----------------------------------------------------------------------
 arpac - 07-10-06 15:04 
----------------------------------------------------------------------
Hi, I have the same problem on an ACER Aspire 1650Z (
http://www.acer.co.id/products.php?fl3nc=1&param=c2lkQ29udGFpbmVyPTAwMDUwMDAwMDM1Nw%3D%3D
), no sound output.

I've try alsa 1.0.11 and the last HG (of yesterday), working actually with
it.
With the v1.0.11 the microphone was working normally (tested with
audacity), with the last HG not correctly (at begining I thought that it
wasn't working, but it does in fact, at a very low level).

I've try lots of model possibility (all ALC882/883 with position 0 at 3;
and some of ALC880) but nothing more, with everyone low micrphone level
and no sound from the laptop.

Here is my actual lspci -nv for the audio: 
00:1b.0 0403: 8086:2668 (rev 04)
        Subsystem: 1025:009e
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d000c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

my actual dmesg about modules after loading: 
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1b.0 to 64

my actual modules conf:
alias snd-card-0 snd-hda-intel
#options snd-hda-intel model=6stack-dig-demo position_fix=1
options snd-hda-intel model=auto
alias sound-slot-0 snd-hda-intel

my /proc/asound/card0/codec#0:
Codec: Realtek ALC883

Don't know what to give you more interesting, and I'm getting to have a
big headache to search everywhere ^^

Is it possible to make ALC883's working on GNU/Linux or I must sell my
laptop ? :/

If I can help .. Thx for all you('ve) do(ne) for the GNU/Linux community



----------------------------------------------------------------------
 arpac - 07-20-06 17:28 
----------------------------------------------------------------------
I've found someone who have an Intel Corporation 82801G with ALC883, on an
acer laptop. sound is working for him with last alsa tarball ..
**lucky one ^^**

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-06 22:14 lodp2          New Issue                                    
07-06-06 22:14 lodp2          Distribution              => Kubuntu Dapper  
07-06-06 22:14 lodp2          Kernel Version            => 2.6.15-25       
07-06-06 22:24 lodp2          Issue Monitored: lodp2                       
07-10-06 15:01 arpac          Issue Monitored: arpac                       
07-10-06 15:02 arpac          Note Added: 0010961                          
07-10-06 15:03 arpac          Note Edited: 0010961                         
07-10-06 15:04 arpac          Note Edited: 0010961                         
07-10-06 15:04 arpac          Note Edited: 0010961                         
07-20-06 17:28 arpac          Note Added: 0011133                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
