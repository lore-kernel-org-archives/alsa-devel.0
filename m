From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: cdn-dp sound output use
	spdif" to the asoc tree
Date: Wed, 23 May 2018 09:38:23 +0100
Message-ID: <E1fLPHr-00014N-8h@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C4342671D2
 for <alsa-devel@alsa-project.org>; Wed, 23 May 2018 10:38:27 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lin Huang <hl@rock-chips.com>
Cc: Chris Zhong <zyw@rock-chips.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: cdn-dp sound output use spdif

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b18c6c3c7768b7b81c2250bbccd0c3c0aed6b71f Mon Sep 17 00:00:00 2001
From: Lin Huang <hl@rock-chips.com>
Date: Tue, 22 May 2018 16:53:42 +0800
Subject: [PATCH] ASoC: rockchip: cdn-dp sound output use spdif

some monitors care about the parity bit in the sub-frame of I2S,
but the cdn-dp always set this bit to "1", so these monitors
do not have sound output if use i2s, use spdif can fix this issue.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 46 +--------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 9a10181a0811..f184168f9a41 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -220,45 +220,6 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int rockchip_sound_cdndp_hw_params(struct snd_pcm_substream *substream,
-					  struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int mclk, ret;
-
-	/* in bypass mode, the mclk has to be one of the frequencies below */
-	switch (params_rate(params)) {
-	case 8000:
-	case 16000:
-	case 24000:
-	case 32000:
-	case 48000:
-	case 64000:
-	case 96000:
-		mclk = 12288000;
-		break;
-	case 11025:
-	case 22050:
-	case 44100:
-	case 88200:
-		mclk = 11289600;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
-				     SND_SOC_CLOCK_OUT);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "Can't set cpu clock out %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int rockchip_sound_dmic_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -293,10 +254,6 @@ static const struct snd_soc_ops rockchip_sound_da7219_ops = {
 	.hw_params = rockchip_sound_da7219_hw_params,
 };
 
-static const struct snd_soc_ops rockchip_sound_cdndp_ops = {
-	.hw_params = rockchip_sound_cdndp_hw_params,
-};
-
 static const struct snd_soc_ops rockchip_sound_dmic_ops = {
 	.hw_params = rockchip_sound_dmic_hw_params,
 };
@@ -323,8 +280,7 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_CDNDP] = {
 		.name = "DP",
 		.stream_name = "DP PCM",
-		.codec_dai_name = "i2s-hifi",
-		.ops = &rockchip_sound_cdndp_ops,
+		.codec_dai_name = "spdif-hifi",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 	},
-- 
2.17.0
