From: David Santinoli <david@santinoli.com>
Subject: Re: [PATCH] hda/realtek: quirk for D945GCLF2 mainboard
Date: Tue, 8 Dec 2009 19:07:47 +0100
Message-ID: <20091208180747.GA26852@aidi.santinoli.com>
References: <20091204221918.GA28065@aidi.santinoli.com>
	<s5htyw1sphd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dora.fastpath.it (dora.fastpath.it [66.150.225.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D411103846
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 19:08:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htyw1sphd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2009 at 11:57:02AM +0100, Takashi Iwai wrote:
> Could you check whether model=auto doesn't work with the very latest
> version?  If not, please give alsa-info.sh output.

Hi Takashi,
  I tried the alsa-driver-20091208.tar.bz2 snapshot, and modprobe'ing
with model=auto leaves the soundcard silent.  I have to set
model=3stack-dig to make playback audible.

As for alsa-info.sh, I am currently unable to run it on our
quasi-embedded test system due to the dependencies it requires.  I'll
try to see if I can run a more complete live distro on the platform and
extract the information.


> If this quirk is inevitably needed, I'll apply it, of course.
> But, please put the quirk entry in the sorted order.

My apologies, I inferred the wrong criterion from other sections of the
file, where the ordering is less obvious.
Here's a reworked version based on said snapshot.

Signed-off-by: David Santinoli <david@santinoli.com>
---

--- alsa-kernel/pci/hda/patch_realtek.c.orig	2009-12-08 18:59:51.000000000 +0100
+++ alsa-kernel/pci/hda/patch_realtek.c	2009-12-08 19:00:43.000000000 +0100
@@ -16846,6 +16846,7 @@
 					ALC662_3ST_6ch_DIG),
 	SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
 			   ALC663_ASUS_H13),
+	SND_PCI_QUIRK(0x8086, 0xd604, "Intel mobo", ALC662_3ST_2ch_DIG),
 	{}
 };
