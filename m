From: Mark Brown <broonie@kernel.org>
Subject: Applied "SoC: rockchip-max98090: Remove MICBIAS as supply of input pin IN34" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:05 +0100 (BST)
Message-ID: <20190722122205.95EA72742C1A@ypsilon.sirena.org.uk>
References: <20190719180558.11459-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719180558.11459-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: alsa-devel@alsa-project.org, Collabora Kernel ML <kernel@collabora.com>, cychiang@chromium.org, dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   SoC: rockchip-max98090: Remove MICBIAS as supply of input pin IN34

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 03cc2c22a711080790c5dcb546dd073fe38add05 Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Fri, 19 Jul 2019 20:05:58 +0200
Subject: [PATCH] SoC: rockchip-max98090: Remove MICBIAS as supply of input pin
 IN34

Commit ec0d23b295b9 ("ASoC: rockchip-max98090: Fix the Headset Mic
route.") moved the MICBIAS widget to supply Headset Mic but forget to
remove the MICBIAS widget to supply IN34 which is not really needed, so
remove that path so we have:

   IN34 <==== Headset MIC <==== MICBIAS

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Link: https://lore.kernel.org/r/20190719180558.11459-1-enric.balletbo@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index c5fc24675a33..d1c907631c2d 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -45,7 +45,6 @@ static const struct snd_soc_dapm_widget rk_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route rk_audio_map[] = {
 	{"IN34", NULL, "Headset Mic"},
-	{"IN34", NULL, "MICBIAS"},
 	{"Headset Mic", NULL, "MICBIAS"},
 	{"DMICL", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPL"},
-- 
2.20.1
