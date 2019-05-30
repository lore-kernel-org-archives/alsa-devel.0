From: "kernelci.org bot" <bot@kernelci.org>
Subject: next/master boot bisection: next-20190528 on
 sun8i-h3-libretech-all-h3-cc
Date: Thu, 30 May 2019 02:16:22 -0700 (PDT)
Message-ID: <5cef9f66.1c69fb81.39f30.21e8@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com, mgalka@collabora.combroonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, matthew.hart@linaro.org, khilman@baylibre.com, enric.balletbo@collabora.com
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/master boot bisection: next-20190528 on sun8i-h3-libretech-all-h3-cc

Summary:
  Start:      531b0a360899 Add linux-next specific files for 20190528
  Details:    https://kernelci.org/boot/id/5cece0fd59b5144bc47a362b
  Plain log:  https://storage.kernelci.org//next/master/next-20190528/arm/s=
unxi_defconfig/gcc-8/lab-baylibre/boot-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190528/arm/s=
unxi_defconfig/gcc-8/lab-baylibre/boot-sun8i-h3-libretech-all-h3-cc.html
  Result:     34ac3c3eb8f0 ASoC: core: lock client_mutex while removing lin=
k components

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  Branch:     master
  Target:     sun8i-h3-libretech-all-h3-cc
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     sunxi_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb
Author: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Date:   Thu May 23 10:12:01 2019 -0700

    ASoC: core: lock client_mutex while removing link components
    =

    Removing link components results in topology unloading. So,
    acquire the client_mutex before removing components in
    soc_remove_link_components. This will prevent the lockdep warning
    seen when dai links are removed during topology removal.
    =

    Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2403bec2fccf..7c9415987ac7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1005,12 +1005,14 @@ static void soc_remove_link_components(struct snd_s=
oc_card *card,
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 =

+	mutex_lock(&client_mutex);
 	for_each_rtdcom(rtd, rtdcom) {
 		component =3D rtdcom->component;
 =

 		if (component->driver->remove_order =3D=3D order)
 			soc_remove_component(component);
 	}
+	mutex_unlock(&client_mutex);
 }
 =

 static void soc_remove_dai_links(struct snd_soc_card *card)
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [cd6c84d8f0cdc911df435bb075ba22ce3c605b07] Linux 5.2-rc2
git bisect good cd6c84d8f0cdc911df435bb075ba22ce3c605b07
# bad: [531b0a360899269bd99a38ba9852a8ba46852bcd] Add linux-next specific f=
iles for 20190528
git bisect bad 531b0a360899269bd99a38ba9852a8ba46852bcd
# bad: [0b61d4c3b7d7938ef0014778c328e3f65c0d6d57] Merge remote-tracking bra=
nch 'crypto/master'
git bisect bad 0b61d4c3b7d7938ef0014778c328e3f65c0d6d57
# bad: [6179e21b065dc0f592cd3d9d3676bd64d4278025] Merge remote-tracking bra=
nch 'xtensa/xtensa-for-next'
git bisect bad 6179e21b065dc0f592cd3d9d3676bd64d4278025
# bad: [3e085f66fe7e93575f2a583a3d434415cef2d860] Merge remote-tracking bra=
nch 'amlogic/for-next'
git bisect bad 3e085f66fe7e93575f2a583a3d434415cef2d860
# bad: [b9afa223a3420432bc483d2b43429c88c6a5d0e0] Merge remote-tracking bra=
nch 'staging.current/staging-linus'
git bisect bad b9afa223a3420432bc483d2b43429c88c6a5d0e0
# good: [fc6557648e19dbd207dc815c6e09fc6452f01e63] Merge remote-tracking br=
anch 'bpf/master'
git bisect good fc6557648e19dbd207dc815c6e09fc6452f01e63
# bad: [6c3f2a0e0f236f31b47d63ab7d3f4ec889821d0d] Merge remote-tracking bra=
nch 'spi-fixes/for-linus'
git bisect bad 6c3f2a0e0f236f31b47d63ab7d3f4ec889821d0d
# bad: [20a5f9c8649d74407aa657ce5b76cf8b0bbb17e3] Merge branch 'asoc-5.2' i=
nto asoc-linus
git bisect bad 20a5f9c8649d74407aa657ce5b76cf8b0bbb17e3
# good: [ad6eecbfc01c987e0253371f274c3872042e4350] ASoC: cs42xx8: Add regca=
che mask dirty
git bisect good ad6eecbfc01c987e0253371f274c3872042e4350
# good: [069d037aea98ffa64c26d4b1dc958fb8f39f5c2b] ASoC: simple-card: Fix c=
onfiguration of DAI format
git bisect good 069d037aea98ffa64c26d4b1dc958fb8f39f5c2b
# good: [df9366131a452296d040a7a496d93108f1fc240c] ASoC: Intel: sof-rt5682:=
 fix AMP quirk support
git bisect good df9366131a452296d040a7a496d93108f1fc240c
# bad: [34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb] ASoC: core: lock client_m=
utex while removing link components
git bisect bad 34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb
# good: [4819d06292c9b57eabdd6d1603e49a27baf183be] ASoC: simple-card: Resto=
re original configuration of DAI format
git bisect good 4819d06292c9b57eabdd6d1603e49a27baf183be
# first bad commit: [34ac3c3eb8f0c07252ceddf0a22dd240e5c91ccb] ASoC: core: =
lock client_mutex while removing link components
---------------------------------------------------------------------------=
----
