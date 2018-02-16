From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Fix suspend/resume" to the asoc tree
Date: Fri, 16 Feb 2018 15:21:13 +0000
Message-ID: <E1emhp3-0003Sk-Gi@debutante>
References: <1518789534-11828-1-git-send-email-festevam@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1518789534-11828-1-git-send-email-festevam@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, eric@nelint.com, alsa-devel@alsa-project.orgstable@vger.kernel.org, max.krummenacher@toradex.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Fix suspend/resume

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

>From a8992973edbb2555e956b90f6fe97c4bc14d761d Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Fri, 16 Feb 2018 11:58:54 -0200
Subject: [PATCH] ASoC: sgtl5000: Fix suspend/resume

Commit 8419caa72702 ("ASoC: sgtl5000: Do not disable regulators in
SND_SOC_BIAS_OFF") causes the sgtl5000 to fail after a suspend/resume
sequence:

Playing WAVE '/media/a2002011001-e02.wav' : Signed 16 bit Little
Endian, Rate 44100 Hz, Stereo
aplay: pcm_write:2051: write error: Input/output error

The problem is caused by the fact that the aforementioned commit
dropped the cache handling, so re-introduce the register map
resync to fix the problem.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index c445a0794a27..c5c76ab8ccf1 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -876,15 +876,26 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
+	struct sgtl5000_priv *sgtl = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 	case SND_SOC_BIAS_STANDBY:
+		regcache_cache_only(sgtl->regmap, false);
+		ret = regcache_sync(sgtl->regmap);
+		if (ret) {
+			regcache_cache_only(sgtl->regmap, true);
+			return ret;
+		}
+
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				    SGTL5000_REFTOP_POWERUP,
 				    SGTL5000_REFTOP_POWERUP);
 		break;
 	case SND_SOC_BIAS_OFF:
+		regcache_cache_only(sgtl->regmap, true);
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 				    SGTL5000_REFTOP_POWERUP, 0);
 		break;
-- 
2.16.1
