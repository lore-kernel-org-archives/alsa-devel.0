From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ad193x: Set constraint to always have 32 sample bits" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:37 +0000 (GMT)
Message-ID: <20190218184937.98EA21128008@debutante.sirena.org.uk>
References: <20190218160954.13929-3-codrin.ciubotariu@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218160954.13929-3-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, lars@metafoo.de, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, Codrin.Ciubotariu@microchip.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ad193x: Set constraint to always have 32 sample bits

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

>From 75c2ecb4bda296f89d4ea6a42750f48bfcd8a1d9 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:30 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Set constraint to always have 32 sample
 bits

DACs and ADCs on ad193x codecs require a 32 bit slot size. We should
assure that no other size is used.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 21a38cc9e3da..c16c9969d1a0 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -37,6 +37,13 @@ static SOC_ENUM_SINGLE_DECL(ad193x_deemp_enum, AD193X_DAC_CTRL2, 1,
 
 static const DECLARE_TLV_DB_MINMAX(adau193x_tlv, -9563, 0);
 
+static const unsigned int ad193x_sb[] = {32};
+
+static struct snd_pcm_hw_constraint_list constr = {
+	.list = ad193x_sb,
+	.count = ARRAY_SIZE(ad193x_sb),
+};
+
 static const struct snd_kcontrol_new ad193x_snd_controls[] = {
 	/* DAC volume control */
 	SOC_DOUBLE_R_TLV("DAC1 Volume", AD193X_DAC_L1_VOL,
@@ -321,7 +328,16 @@ static int ad193x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int ad193x_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *dai)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+				   &constr);
+}
+
 static const struct snd_soc_dai_ops ad193x_dai_ops = {
+	.startup = ad193x_startup,
 	.hw_params = ad193x_hw_params,
 	.digital_mute = ad193x_mute,
 	.set_tdm_slot = ad193x_set_tdm_slot,
-- 
2.20.1
