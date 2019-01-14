From: "kernelci.org bot" <bot@kernelci.org>
Subject: next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on
 sun8i-h3-libretech-all-h3-cc
Date: Mon, 14 Jan 2019 06:07:08 -0800 (PST)
Message-ID: <5c3c978c.1c69fb81.6e329.1da7@mx.google.com>
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

next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on sun8i-h3-l=
ibretech-all-h3-cc

Summary:
  Start:      727b373740d1 Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Details:    https://kernelci.org/boot/id/5c3c423359b5145dde6edd37
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all=
-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all=
-h3-cc.html
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
  Target:     sun8i-h3-libretech-all-h3-cc
  CPU arch:   arm
  Lab:        lab-baylibre
  Config:     sunxi_defconfig
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
# good: [6b529fb0a3eabf9c4cc3e94c11477250379ce6d8] Merge tag 'for-5.0-rc1-t=
ag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good 6b529fb0a3eabf9c4cc3e94c11477250379ce6d8
# bad: [727b373740d1d3c6d3273cfc6e81d5e9a229b12d] Merge remote-tracking bra=
nch 'drm-misc-fixes/for-linux-next-fixes'
git bisect bad 727b373740d1d3c6d3273cfc6e81d5e9a229b12d
# good: [34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d] Merge remote-tracking br=
anch 'net/master'
git bisect good 34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d
# bad: [52bb35a9520ac1746fb34687c5582695813aa00a] Merge remote-tracking bra=
nch 'char-misc.current/char-misc-linus'
git bisect bad 52bb35a9520ac1746fb34687c5582695813aa00a
# bad: [4baf5101d553aae944fa7dc7bd13772eb559d78b] Merge remote-tracking bra=
nch 'sound-asoc-fixes/for-linus'
git bisect bad 4baf5101d553aae944fa7dc7bd13772eb559d78b
# good: [49ff71f99a8826eda5cee76b69f15600d1cbf4b2] Merge remote-tracking br=
anch 'rdma-fixes/for-rc'
git bisect good 49ff71f99a8826eda5cee76b69f15600d1cbf4b2
# good: [678e2b44c8e3fec3afc7202f1996a4500a50be93] ALSA: compress: prevent =
potential divide by zero bugs
git bisect good 678e2b44c8e3fec3afc7202f1996a4500a50be93
# good: [667e9334fa64da2273e36ce131b05ac9e47c5769] ASoC: tlv320aic32x4: Ker=
nel OOPS while entering DAPM standby mode
git bisect good 667e9334fa64da2273e36ce131b05ac9e47c5769
# bad: [239b8b34a856777e562373ae0de605536a7ccade] ASoC: Intel: Boards: move=
 the codec PLL configuration to _init
git bisect bad 239b8b34a856777e562373ae0de605536a7ccade
# bad: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-core: defer car=
d probe until all component is added to list
git bisect bad 8780cf1142a59568a3aa77959cbd76b2edb6fd81
# good: [44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661] ASoC: atom: fix a missin=
g check of snd_pcm_lib_malloc_pages
git bisect good 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661
# first bad commit: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-co=
re: defer card probe until all component is added to list
---------------------------------------------------------------------------=
----
