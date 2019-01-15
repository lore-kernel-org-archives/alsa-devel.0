From: "kernelci.org bot" <bot@kernelci.org>
Subject: next/master boot bisection: next-20190115 on
 sun8i-h2-plus-libretech-all-h3-cc
Date: Tue, 15 Jan 2019 02:17:41 -0800 (PST)
Message-ID: <5c3db345.1c69fb81.49892.a0b3@mx.google.com>
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

next/master boot bisection: next-20190115 on sun8i-h2-plus-libretech-all-h3=
-cc

Summary:
  Start:      5aa6589e17bd Add linux-next specific files for 20190115
  Details:    https://kernelci.org/boot/id/5c3d783659b51451106edd6c
  Plain log:  https://storage.kernelci.org//next/master/next-20190115/arm/s=
unxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190115/arm/s=
unxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretech-all-h3-cc.html
  Result:     8780cf1142a5 ASoC: soc-core: defer card probe until all compo=
nent is added to list

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
  Branch:     master
  Target:     sun8i-h2-plus-libretech-all-h3-cc
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
# good: [3719876809e745b9db5293d418600c194bbf5c23] sbitmap: Protect swap_lo=
ck from softirqs
git bisect good 3719876809e745b9db5293d418600c194bbf5c23
# bad: [5aa6589e17bd4dbc1856e37281f00a290d733ab0] Add linux-next specific f=
iles for 20190115
git bisect bad 5aa6589e17bd4dbc1856e37281f00a290d733ab0
# bad: [f2dd4e3054741e22c4c97c8a0fa05faa7239d60a] Merge remote-tracking bra=
nch 'crypto/master'
git bisect bad f2dd4e3054741e22c4c97c8a0fa05faa7239d60a
# bad: [3ba858cbc004b32f8767d295b9b566eb0381da0c] Merge remote-tracking bra=
nch 'qcom/for-next'
git bisect bad 3ba858cbc004b32f8767d295b9b566eb0381da0c
# bad: [4cc2339ea8900debf88333934fa9b1dbc96ee2aa] Merge remote-tracking bra=
nch 'btrfs-fixes/next-fixes'
git bisect bad 4cc2339ea8900debf88333934fa9b1dbc96ee2aa
# good: [259764fd4e5b47aedd6317d2edf5d813333909c5] Merge remote-tracking br=
anch 'net/master'
git bisect good 259764fd4e5b47aedd6317d2edf5d813333909c5
# bad: [29568b4049ff4ef23ce0a2dd46cbaed94b589c78] Merge remote-tracking bra=
nch 'usb-serial-fixes/usb-linus'
git bisect bad 29568b4049ff4ef23ce0a2dd46cbaed94b589c78
# good: [798729dc036d5bb384e24bb48af5c9ea6554d945] Merge remote-tracking br=
anch 'sound-current/for-linus'
git bisect good 798729dc036d5bb384e24bb48af5c9ea6554d945
# bad: [d9c51542207a29b7b06c11f1085a1e3b8eb24f07] Merge branch 'asoc-5.0' i=
nto asoc-linus
git bisect bad d9c51542207a29b7b06c11f1085a1e3b8eb24f07
# good: [678e2b44c8e3fec3afc7202f1996a4500a50be93] ALSA: compress: prevent =
potential divide by zero bugs
git bisect good 678e2b44c8e3fec3afc7202f1996a4500a50be93
# good: [667e9334fa64da2273e36ce131b05ac9e47c5769] ASoC: tlv320aic32x4: Ker=
nel OOPS while entering DAPM standby mode
git bisect good 667e9334fa64da2273e36ce131b05ac9e47c5769
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
