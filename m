From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002313]: intel8x0 probe fails with
	error -12
Date: Sat, 29 Jul 2006 12:22:01 +0200
Message-ID: <bb37db785e0bd268ac5a108d550f589d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E70A171
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 12:22:02 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2313> 
======================================================================
Reported By:                coralsaw
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2313
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Etch
Kernel Version:             2.6.16
======================================================================
Date Submitted:             07-29-2006 12:22 CEST
Last Modified:              07-29-2006 12:22 CEST
======================================================================
Summary:                    intel8x0 probe fails with error -12
Description: 
Hello,

I'm running Debian Testing (ETCH) latest 2.6 kernel. Since a long time,
I've been having a semi-persistent issue with my soundcards (once every
approx. 5-10 reboots it works). Let me explain a bit.

I have 3 soundcards in the PC. First there is the onboard soundcard, an
Intel 82801DB which I want to configure as primary. Second, I have an RME
multiface/cardbus card that I use under XP (dual boot) for music
recording. And third, I have a Hauppauge WinTV card with a Conexant
CX23880 audio chip.

The problem I'm having is that most of the time, the Intel chip fails to
be recognized during boot. I get the following dmesg error:

   Intel ICH: probe of 0000:00:1f.5 failed with error -12

Afterwards, ALSA cannot recognize the card as well, so even if I
alsaconfand try to configure the Intel chip as primary, nothing changes
and most of the times the Connexant chip is the one that shows in cat
/proc/asound/cards.

I've got no idea why the driver fails to be recognized, and I don't really
know how to fix the issue, despite my long time google searches. I've
waited for a month to see if it's an ETCH instability problem, to no
avail. Note that I have no problem with either Ubuntu or XP on the same
PC.

cat /proc/asound/cards gives the following:

   0 [CX8811         ]: CX88x - Conexant CX8811
                        Conexant CX8811 at 0xf0000000
   1 [DSP            ]: H-DSP - Hammerfall DSP
                        RME Hammerfall DSP + Multiface at 0xef800000, irq
193

cat /proc/interrups gives the following:

              CPU0
     0:    1250978    IO-APIC-edge  timer
     1:       6569    IO-APIC-edge  i8042
     7:          0    IO-APIC-edge  parport0
     8:          4    IO-APIC-edge  rtc
    12:     166502    IO-APIC-edge  i8042
    14:      12588    IO-APIC-edge  ide0
    15:        153    IO-APIC-edge  ide1
   169:     504906   IO-APIC-level  acpi, ohci1394, cx88[0], cx88[0]
   185:      13253   IO-APIC-level  eth0
   193:         59   IO-APIC-level  libata, ehci_hcd:usb4, hdsp
   201:     423069   IO-APIC-level  uhci_hcd:usb1, mga@pci:0000:01:00.0
   209:          0   IO-APIC-level  uhci_hcd:usb2
   217:          0   IO-APIC-level  uhci_hcd:usb3
   NMI:          0
   LOC:    1250887
   ERR:          0

My dmesg.out, lspci.out and modules.conf are attached

Can you please help me, I'd appreciate it. Thx!

/coralsaw
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-06 12:22 coralsaw       New Issue                                    
07-29-06 12:22 coralsaw       File Added: coralsaw-alsa.tgz                    
07-29-06 12:22 coralsaw       Distribution              => Debian Etch     
07-29-06 12:22 coralsaw       Kernel Version            => 2.6.16          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
