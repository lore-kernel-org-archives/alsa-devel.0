From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use internal reg_cache on uda1380" to
	the asoc tree
Date: Mon, 27 Nov 2017 18:51:59 +0000
Message-ID: <E1eJOVb-0006pa-Cj@debutante>
References: <874lsnm02f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2499C267567
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:02 +0100 (CET)
In-Reply-To: <874lsnm02f.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use internal reg_cache on uda1380

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

>From c001bf633a910cfc8a5b84b80634db4636bf1724 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Nov 2017 01:04:08 +0000
Subject: [PATCH] ASoC: use internal reg_cache on uda1380

Codec reg_cache is legacy feature and very few driver only are using
it. But, ALSA SoC framework needs to support it.
Codec will be merged into Component in the future, so, let's remove
legacy and unused feature from framework.
This patch implements ALSA SoC reg_cache feature into driver,
and don't use  ALSA SoC framework's feature.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/uda1380.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 44448023edb0..46a495b4da8d 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -38,6 +38,7 @@ struct uda1380_priv {
 	unsigned int dac_clk;
 	struct work_struct work;
 	struct i2c_client *i2c;
+	u16 *reg_cache;
 };
 
 /*
@@ -63,7 +64,9 @@ static unsigned long uda1380_cache_dirty;
 static inline unsigned int uda1380_read_reg_cache(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	u16 *cache = codec->reg_cache;
+	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
+	u16 *cache = uda1380->reg_cache;
+
 	if (reg == UDA1380_RESET)
 		return 0;
 	if (reg >= UDA1380_CACHEREGNUM)
@@ -77,7 +80,8 @@ static inline unsigned int uda1380_read_reg_cache(struct snd_soc_codec *codec,
 static inline void uda1380_write_reg_cache(struct snd_soc_codec *codec,
 	u16 reg, unsigned int value)
 {
-	u16 *cache = codec->reg_cache;
+	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
+	u16 *cache = uda1380->reg_cache;
 
 	if (reg >= UDA1380_CACHEREGNUM)
 		return;
@@ -134,7 +138,7 @@ static void uda1380_sync_cache(struct snd_soc_codec *codec)
 	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
 	int reg;
 	u8 data[3];
-	u16 *cache = codec->reg_cache;
+	u16 *cache = uda1380->reg_cache;
 
 	/* Sync reg_cache with the hardware */
 	for (reg = 0; reg < UDA1380_MVOL; reg++) {
@@ -722,16 +726,9 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 
 static const struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.probe =	uda1380_probe,
-	.read =		uda1380_read_reg_cache,
-	.write =	uda1380_write,
 	.set_bias_level = uda1380_set_bias_level,
 	.suspend_bias_off = true,
 
-	.reg_cache_size = ARRAY_SIZE(uda1380_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = uda1380_reg,
-	.reg_cache_step = 1,
-
 	.component_driver = {
 		.controls		= uda1380_snd_controls,
 		.num_controls		= ARRAY_SIZE(uda1380_snd_controls),
@@ -771,6 +768,13 @@ static int uda1380_i2c_probe(struct i2c_client *i2c,
 			return ret;
 	}
 
+	uda1380->reg_cache = devm_kmemdup(&i2c->dev,
+					uda1380_reg,
+					ARRAY_SIZE(uda1380_reg) * sizeof(u16),
+					GFP_KERNEL);
+	if (!uda1380->reg_cache)
+		return -ENOMEM;
+
 	i2c_set_clientdata(i2c, uda1380);
 	uda1380->i2c = i2c;
 
-- 
2.15.0
