From: "kernelci.org bot" <bot@kernelci.org>
Subject: next/pending-fixes boot bisection: v5.0-rc2-361-g08b435ee366b on
 bcm2837-rpi-3-b-32
Date: Tue, 15 Jan 2019 03:50:09 -0800 (PST)
Message-ID: <5c3dc8f1.1c69fb81.7f7ca.c87c@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ajit Pandey <ajitp@codeaurora.org>, tomeu.vizoso@collabora.com, Rohit kumar <rohitkr@codeaurora.org>, guillaume.tucker@collabora.com, Mark Brown <broonie@kernel.org>broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com, enric.balletbo@collabora.com
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/pending-fixes boot bisection: v5.0-rc2-361-g08b435ee366b on bcm2837-rp=
i-3-b-32

Summary:
  Start:      08b435ee366b Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Details:    https://kernelci.org/boot/id/5c3d7a2759b51458916edd4d
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.0-rc2-361=
-g08b435ee366b/arm/bcm2835_defconfig/lab-baylibre/boot-bcm2837-rpi-3-b.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.0-rc2-361=
-g08b435ee366b/arm/bcm2835_defconfig/lab-baylibre/boot-bcm2837-rpi-3-b.html
  Result:     8780cf1142a5 ASoC: soc-core: defer card probe until all compo=
nent is added to list

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
  Branch:     pending-fixes
  Target:     bcm2837-rpi-3-b-32
  CPU arch:   arm
  Lab:        lab-baylibre
  Config:     bcm2835_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 8780cf1142a59568a3aa77959cbd76b2edb6fd81
Author: Ajit Pandey <ajitp@codeaurora.org>
Date:   Wed Jan 9 14:17:07 2019 +0530

    ASoC: soc-core: defer card probe until all component is added to list
    =

    DAI component probe is not called if it is not present
    in component list during sound card registration.
    Check if component is available in component list for
    platform and cpu dai before soundcard registration.
    =

    Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
    Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..eec92f17dd15 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,7 +1027,6 @@ static int snd_soc_init_platform(struct snd_soc_card =
*card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform =3D dai_link->platform;
-
 	/*
 	 * FIXME
 	 *
@@ -1129,6 +1128,14 @@ static int soc_init_dai_link(struct snd_soc_card *ca=
rd,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if platform dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->platform->of_node, link->platform->name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * CPU device may be specified by either name or OF node, but
 	 * can be left unspecified, and will be matched based on DAI
@@ -1140,6 +1147,14 @@ static int soc_init_dai_link(struct snd_soc_card *ca=
rd,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if cpu dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * At least one of CPU DAI name or CPU device name/node must be
 	 * specified
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [3719876809e745b9db5293d418600c194bbf5c23] sbitmap: Protect swap_lo=
ck from softirqs
git bisect good 3719876809e745b9db5293d418600c194bbf5c23
# bad: [08b435ee366bab63250c375ffea3c94cb02fcd93] Merge remote-tracking bra=
nch 'drm-misc-fixes/for-linux-next-fixes'
git bisect bad 08b435ee366bab63250c375ffea3c94cb02fcd93
# good: [f80eb2d45c4e34750337d1210a78bfe2ebf43b73] Merge remote-tracking br=
anch 'ipsec/master'
git bisect good f80eb2d45c4e34750337d1210a78bfe2ebf43b73
# bad: [e242412b491b4e34643f82c6f422e964beb81704] Merge remote-tracking bra=
nch 'input-current/for-linus'
git bisect bad e242412b491b4e34643f82c6f422e964beb81704
# bad: [eb1c2383c8b929fcc5a56f5698ff3fe3d0ec54e6] Merge remote-tracking bra=
nch 'sound-asoc-fixes/for-linus'
git bisect bad eb1c2383c8b929fcc5a56f5698ff3fe3d0ec54e6
# bad: [04eb1efcd614d6f067b76a355b3a3599667959dc] ASoC: soc-core: Hold clie=
nt_mutex around soc_init_dai_link()
git bisect bad 04eb1efcd614d6f067b76a355b3a3599667959dc
# good: [a41d9dbf5dac5b6a1283ee8001f22807d18352ea] ASoC: qdsp6: q6asm-dai: =
Fix a small memory leak
git bisect good a41d9dbf5dac5b6a1283ee8001f22807d18352ea
# good: [6175471755075d256c1c654151fc1cad183c1e33] ASoC: ti: davinci-mcasp:=
 Move context save/restore to runtime_pm callbacks
git bisect good 6175471755075d256c1c654151fc1cad183c1e33
# good: [44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661] ASoC: atom: fix a missin=
g check of snd_pcm_lib_malloc_pages
git bisect good 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661
# bad: [239b8b34a856777e562373ae0de605536a7ccade] ASoC: Intel: Boards: move=
 the codec PLL configuration to _init
git bisect bad 239b8b34a856777e562373ae0de605536a7ccade
# bad: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-core: defer car=
d probe until all component is added to list
git bisect bad 8780cf1142a59568a3aa77959cbd76b2edb6fd81
# first bad commit: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-co=
re: defer card probe until all component is added to list
---------------------------------------------------------------------------=
----
