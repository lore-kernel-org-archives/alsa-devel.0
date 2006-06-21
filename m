From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002189]: No sound on speakers,
	low volume on the headphones, Packard bell V7900
Date: Wed, 21 Jun 2006 19:02:11 +0200
Message-ID: <4f2b59498151fc6812cc2b91dbda55c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1EC512C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 19:02:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2189> 
======================================================================
Reported By:                bettored
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2189
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15-23-386
======================================================================
Date Submitted:             06-07-2006 19:47 CEST
Last Modified:              06-21-2006 19:02 CEST
======================================================================
Summary:                    No sound on speakers, low volume on the headphones,
Packard bell V7900
Description: 
Hi,
I have a Packard Bell with a soundcard Realtek ALC260 HD Audio, with Intel
hda-intel, with problems.
I have no sound on speakers and very low on the headphones.
In the alsamixer all is on.
Recently i actualized to Alsa 1.0.11 but with same problem.

In the Volumen Control, i have two:
1. HDA intel (alsa mixer)
2. Realtek ALC260 (oss mixer)
And it is correct.

Here leave same test:


janek@janek-laptop:~$ lsmod | grep snd
snd_hda_intel          19348  2
snd_hda_codec         143152  1 snd_hda_intel
snd_pcm_oss            43936  0
snd_mixer_oss          18944  2 snd_pcm_oss
snd_pcm                89352  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              25348  1 snd_pcm
snd                    55396  8
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixe r_oss,snd_pcm,snd_timer
soundcore              10208  2 snd
snd_page_alloc         10760  2 snd_hda_intel,snd_pcm

--------------------------------------------------------------------------------

janek@janek-laptop:~$ lspci
0000:00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub
(rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics
Port (rev 03)
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
0000:00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 (rev 02)
0000:00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 2 (rev 02)
0000:00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 3 (rev 02)
0000:00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 4 (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev
e2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus
Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown
device 71c5
0000:03:00.0 Network controller: Intel Corporation: Unknown device 4222
(rev 02)
0000:06:02.0 FireWire (IEEE 1394): O2 Micro, Inc.: Unknown device 00f7
(rev 02)
0000:06:02.2 0805: O2 Micro, Inc.: Unknown device 7120 (rev 01)
0000:06:02.3 Mass storage controller: O2 Micro, Inc.: Unknown device 7130
(rev 01)
0000:06:08.0 Ethernet controller: Intel Corporation: Unknown device 1092
(rev 02)


-------------------------------------------------------------------------------

janek@janek-laptop:~$ modinfo soundcore
filename:       /lib/modules/2.6.15-23-386/kernel/sound/soundcore.ko
description:    Core sound module
author:         Alan Cox
license:        GPL
alias:          char-major-14-*
vermagic:       2.6.15-23-386 preempt 486 gcc-4.0
depends:
srcversion:     DD426F1CCA2CC5F060F6F92


---------------------------------------------------------------------------


Thanks for your time 




======================================================================

----------------------------------------------------------------------
 tiwai - 06-20-06 19:52 
----------------------------------------------------------------------
Try different model option like model=hp or model=basic, as described in
ALSA-Configuration.txt (see ALC260).

If it doesn't work, you can use model=test after building with debug
option (--with-debug=full of alsa-driver configure), then you can adjust
almost every mixer setting.

----------------------------------------------------------------------
 ixM - 06-21-06 19:02 
----------------------------------------------------------------------
tiwai,

As I said, I've tried modprobe hda-snd-intel with each model and there is
no result. With hp I've have no sound at all (even with an external
amplificator).
Maybe it worked for someone but not for me :)

Bye

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 19:47 bettored       New Issue                                    
06-07-06 19:47 bettored       Kernel Version            => 2.6.15-23-386   
06-15-06 20:25 bonobo         Note Added: 0010243                          
06-15-06 20:32 bonobo         Note Edited: 0010243                         
06-18-06 23:59 ixM            Note Added: 0010304                          
06-20-06 19:52 tiwai          Note Added: 0010350                          
06-21-06 19:02 ixM            Note Added: 0010402                          
======================================================================
