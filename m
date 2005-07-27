From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001285]: Live! Value [CT4832] high pitched tone instead of sound and interrupt errors
Date: Wed, 27 Jul 2005 20:30:32 +0200
Message-ID: <cce5b331f87d4b18e9ee53e8da268c97@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C4C071C5
	for <alsa-devel@alsa-project.org>; Wed, 27 Jul 2005 20:30:32 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1285> 
======================================================================
Reported By:                pilophae
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1285
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             gentoo-sources-2.6.12-r6
======================================================================
Date Submitted:             07-27-2005 20:30 CEST
Last Modified:              07-27-2005 20:30 CEST
======================================================================
Summary:                    Live! Value [CT4832] high pitched tone instead of
sound and interrupt errors
Description: 
Specs:
ASUS A8N-SLI Deluxe Motherboard
AMD Athlon64 3200+
2GB PC3200 DDR

Problem:
Whenever I play a sound, wether direct via ALSA or OSS emulation, a high
pitched tone is heard through the speakers. This sound can be lowered with
a mixer. Also, just invoking aplay with an unknown format, causes it to
play an 8kHz tone, which is noticably lower, so I'm guessing the tone is
based on the output sampling frequency.

This problem only occurs in this configuration, the sound card works fine
in my old computer and another tested computer, even together with another
emu10k1-based card. In Gentoo linux on one, and Windows on the latter.

Also, with kernel 2.6.10 through 2.6.11 I receive different kind of
interrupt errors when trying to play sound:

2.6.10-vanilla:
   interrupt: PCI error
   emu10k1: unhandled interrupt: 0xe7400000

2.6.11-gentoo-r9:
   interrupt: PCI error
(using OSS driver emu10k1:
   emu10k1: Warning, unhandled interrupt: 0xe763fc7f)

2.6.12-gentoo-r[46]:
   (no messages, some new interrupt patch was applied to this kernel,
apparently)

During the first attempt at using this card, the second built in NIC on
the motherboard shared interrupt with the soundcard and when I tried to
play sounds, the NIC was disabled and spat this at me:
skge hardware error detected (status 0x400)

I have tried compiling the driver as a module, disabling the onboard audio
chip, enabling MSI/MSI-X, disabling the conflicting on-board LAN (not
conflicting anymore?), disabling APIC (both in bios and in kernel),
swapping between PCI-slots and using OSS module emu10k1, with no avail.

I will try to use another emu10k1-based card in this same setup, to rule
out specific incompabilities.

Any ideas?
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-27-05 20:30 pilophae       New Issue                                    
07-27-05 20:30 pilophae       Kernel Version            =>
gentoo-sources-2.6.12-r6
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
