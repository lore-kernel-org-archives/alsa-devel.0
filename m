From: Arthur Marsh <arthur.marsh@internode.on.net>
Subject: lock-up when loading desktop
Date: Mon, 13 Oct 2014 11:30:40 +1030
Message-ID: <543B2438.1050002@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A7E026049A
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 03:03:18 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1XdU2f-0006aJ-Jr
 for alsa-devel@alsa-project.org; Mon, 13 Oct 2014 03:03:17 +0200
Received: from ppp14-2-14-165.lns21.adl2.internode.on.net ([14.2.14.165])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 03:03:17 +0200
Received: from arthur.marsh by ppp14-2-14-165.lns21.adl2.internode.on.net with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 03:03:17 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have been experiencing a lock-up situation on a dual-core P4 machine 
since some time after kernel 3.17.0 was released.

After the lock-up, it takes a couple of reboots into a known good kernel 
(3.17.0) to successfully boot as the corruption seems to hit the hard disks.

After doing a git-bisect I received the following result:

git bisect bad
257f8cce5d40b811d229ed71602882baa0012808 is the first bad commit
commit 257f8cce5d40b811d229ed71602882baa0012808
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Aug 29 15:32:29 2014 +0200

     ALSA: pcm: Allow nonatomic trigger operations

     Currently, many PCM operations are performed in a critical section
     protected by spinlock, typically the trigger and pointer callbacks are
     assumed to be atomic.  This is basically because some trigger action
     (e.g. PCM stop after drain or xrun) is done in the interrupt handler.
     If a driver runs in a threaded irq, however, this doesn't have to be
     atomic.  And many devices want to handle trigger in a non-atomic
     context due to lengthy communications.

     This patch tries all PCM calls operational in non-atomic context.
     What it does is very simple: replaces the substream spinlock with the
     corresponding substream mutex when pcm->nonatomic flag is set.  The
     driver that wants to use the non-atomic PCM ops just needs to set the
     flag and keep the rest as is.  (Of course, it must not handle any PCM
     ops in irq context.)

     Note that the code doesn't check whether it's atomic-safe or not, but
     trust in 100% that the driver sets pcm->nonatomic correctly.

     One possible problem is the case where linked PCM substreams have
     inconsistent nonatomic states.  For avoiding this, snd_pcm_link()
     returns an error if one tries to link an inconsistent PCM substream.

     Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 e395bf17236b9d109745444ae818b2ecdc21f206 
e002045c29bc96fe0a99c81db9c905db04e87e03 M      include
:040000 040000 44044ea9f3c2aacbd488524c060554256c2b2ceb 
77d1a1e452b9321876f9e1a8f6926f11814a9cd9 M      sound

  git bisect log
git bisect start
# bad: [ca321885b0511a85e2d1cd40caafedbeb18f4af6] Merge 
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect bad ca321885b0511a85e2d1cd40caafedbeb18f4af6
# good: [bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9] Linux 3.17
git bisect good bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9
# good: [f86dc4b04dd5292cae3708c16ca6e46dbb5c95fa] Merge tag 
'defconfig-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good f86dc4b04dd5292cae3708c16ca6e46dbb5c95fa
# good: [5e5f6dc10546f5c03bc572e3ba3089af30c66e2d] arm64: mm: enable 
HAVE_RCU_TABLE_FREE logic
git bisect good 5e5f6dc10546f5c03bc572e3ba3089af30c66e2d
# good: [4d9708ea5e5a45973df7cf965805fdfb185dd5bf] Merge tag 
'media/v3.18-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 4d9708ea5e5a45973df7cf965805fdfb185dd5bf
# bad: [e98d6e7f7625ed60c7bc1d39aeb2375ed3918fd5] Merge tag 
'devicetree-for-linus' of 
git://git.kernel.org/pub/scm/linux/kernel/git/glikely/linux
git bisect bad e98d6e7f7625ed60c7bc1d39aeb2375ed3918fd5
# good: [bdf20b4291eaa3b327398b8dd330065ad8e6d3ce] Merge remote-tracking 
branches 'asoc/fix/88pm860x', 'asoc/fix/fsl', 'asoc/fix/imx', 
'asoc/fix/mc13783', 'asoc/fix/rockchip' and 'asoc/fix/simple' into 
asoc-linus
git bisect good bdf20b4291eaa3b327398b8dd330065ad8e6d3ce
# good: [3db3525196a992da628fb210776d73ec4bb59460] mmc: sdhci-acpi: Get 
UID directly from acpi_device
git bisect good 3db3525196a992da628fb210776d73ec4bb59460
# bad: [3d0fdc86e4b500dfcfbf2f68039d2d6853536c2e] ALSA: ctxfi: added 
reference of snd_card
git bisect bad 3d0fdc86e4b500dfcfbf2f68039d2d6853536c2e
# bad: [7fd4394dfe1db02ba904dfa1048f718cbca822d1] Merge branch 
'topic/pcm-nonatomic' into for-next
git bisect bad 7fd4394dfe1db02ba904dfa1048f718cbca822d1
# good: [c77900e63abd9e2bdf385ba846a22858a0ed50a7] ALSA: hda/realtek - 
move DELL2_MIC_NO_PRESENCE quirk for alc255
git bisect good c77900e63abd9e2bdf385ba846a22858a0ed50a7
# good: [d89c6c0c91af0344b52dd21ca48dd29821fee677] ALSA: hda - Add 
TLV_DB_SCALE_MUTE bit for relevant controls
git bisect good d89c6c0c91af0344b52dd21ca48dd29821fee677
# good: [dd38dc1a9bf780b619ab93b3d7a5e90ebad441f5] ALSA: virtuoso: add 
one more headphone impedance setting
git bisect good dd38dc1a9bf780b619ab93b3d7a5e90ebad441f5
# bad: [7af142f752116e86adbe2073f2922d8265a77709] ALSA: pcm: Uninline 
snd_pcm_stream_lock() and _unlock()
git bisect bad 7af142f752116e86adbe2073f2922d8265a77709
# bad: [257f8cce5d40b811d229ed71602882baa0012808] ALSA: pcm: Allow 
nonatomic trigger operations
git bisect bad 257f8cce5d40b811d229ed71602882baa0012808
# first bad commit: [257f8cce5d40b811d229ed71602882baa0012808] ALSA: 
pcm: Allow nonatomic trigger operations

The problem still exists with the Linus git head as of earlier today, 
but only seems to get triggered when loading the desktop (which is 
actually an ancient KDE 3.51 with a library recompiled to work with 
newer kernels).

The soundcard on the machine is:

00:0a.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
         Subsystem: Creative Labs SB Audigy 2 ZS (SB0350)
         Flags: bus master, medium devsel, latency 32, IRQ 18
         I/O ports at 8400 [size=64]
         Capabilities: <access denied>
         Kernel driver in use: snd_emu10k1

00:0a.1 Input device controller: Creative Labs SB Audigy Game Port (rev 04)
         Subsystem: Creative Labs SB Audigy Game Port
         Flags: bus master, medium devsel, latency 32
         I/O ports at 8000 [size=8]
         Capabilities: <access denied>
         Kernel driver in use: Emu10k1_gameport

00:0a.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 
04) (prog-if 10 [OHCI])
         Subsystem: Creative Labs SB Audigy FireWire Port
         Flags: bus master, medium devsel, latency 32, IRQ 19
         Memory at bc800000 (32-bit, non-prefetchable) [size=2K]
         Memory at bc000000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: <access denied>
         Kernel driver in use: firewire_ohci

I have not looked at the "first bad patch", only built against it.

I am happy to supply further build and machine details, and run extra 
tests to help identify the problem.
