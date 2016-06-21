From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Set idle_bias_off true" to the asoc tree
Date: Tue, 21 Jun 2016 19:52:41 +0100
Message-ID: <E1bFQmv-0008Mx-Vo@debutante>
References: <1466213517-18523-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466213517-18523-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Set idle_bias_off true

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b0e71c0ddda4e1540b38658cac705222a648c756 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Fri, 17 Jun 2016 18:31:57 -0700
Subject: [PATCH] ASoC: cs53l30: Set idle_bias_off true

The driver is using the set_bias_level to control the power on and
off so it should get SND_SOC_BIAS_OFF in order to proceed normal
powering sequences. This patch enables the idle_bias_off option so
the DAPM core will set the bias level to SND_SOC_BIAS_OFF instead
of stopping at SND_SOC_BIAS_STANDBY.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index a5976f3b589a..b0a64a19a045 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -879,6 +879,7 @@ static int cs53l30_codec_probe(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver cs53l30_driver = {
 	.probe = cs53l30_codec_probe,
 	.set_bias_level = cs53l30_set_bias_level,
+	.idle_bias_off = true,
 
 	.dapm_widgets = cs53l30_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(cs53l30_dapm_widgets),
-- 
2.8.1
