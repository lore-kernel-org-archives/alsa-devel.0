From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz sample rates" to the asoc tree
Date: Mon, 24 Jun 2019 17:32:13 +0100 (BST)
Message-ID: <20190624163213.96F5D440046@finisterre.sirena.org.uk>
References: <20190621155808.17182-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621155808.17182-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: alsa-devel@alsa-project.org, Benson Leung <bleung@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Jaroslav Kysela <perex@perex.cz>, kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Xing Zheng <zhengxing@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz sample rates

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 30b233b1cb4291d39ca08a95566721e8a52e5ee3 Mon Sep 17 00:00:00 2001
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Fri, 21 Jun 2019 17:58:08 +0200
Subject: [PATCH] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz sample
 rates

According to the datasheet the max98357a also supports 32, 44.1 and
88.2 kHz sample rate. This support was also introduced recently by
commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").

Actually the machine driver validates the supported sample rates but
this is not really needed because the component driver can all apply
whatever constraints are needed and do their own validation. So, remove
the checks from the machine driver as are not needed at all. This way,
we also support 32, 44.1 and 88.2 kHz sample rates and we get rid of the
errors like the below.

  rk3399-gru-sound sound: rockchip_sound_max98357a_hw_params() doesn't support this sample rate: 44100
  rk3399-gru-sound sound: ASoC: machine hw_params failed: -22

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 879069fc0b94..769d5795919c 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -66,19 +66,7 @@ static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substrea
 	unsigned int mclk;
 	int ret;
 
-	/* max98357a supports these sample rates */
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-	case 48000:
-	case 96000:
-		mclk = params_rate(params) * SOUND_FS;
-		break;
-	default:
-		dev_err(rtd->card->dev, "%s() doesn't support this sample rate: %d\n",
-				__func__, params_rate(params));
-		return -EINVAL;
-	}
+	mclk = params_rate(params) * SOUND_FS;
 
 	ret = snd_soc_dai_set_sysclk(rtd->cpu_dai, 0, mclk, 0);
 	if (ret) {
-- 
2.20.1
