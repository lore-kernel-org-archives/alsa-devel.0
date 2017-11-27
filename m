From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use internal reg_cache on tlv320dac33"
	to the asoc tree
Date: Mon, 27 Nov 2017 18:51:52 +0000
Message-ID: <E1eJOVU-0006oj-9c@debutante>
References: <873787m01y.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0799526755D
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:51:55 +0100 (CET)
In-Reply-To: <873787m01y.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use internal reg_cache on tlv320dac33

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

>From c4305af43a80158fba0d2801be9a0e774634add0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Nov 2017 01:04:25 +0000
Subject: [PATCH] ASoC: use internal reg_cache on tlv320dac33

Codec reg_cache is legacy feature and very few driver only are using
it. But, ALSA SoC framework needs to support it.
Codec will be merged into Component in the future, so, let's remove
legacy and unused feature from framework.
This patch implements ALSA SoC reg_cache feature into driver,
and don't use  ALSA SoC framework's feature.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320dac33.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 80a26418827c..675f5b1b90a6 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -106,6 +106,7 @@ struct tlv320dac33_priv {
 	int mode1_latency;		/* latency caused by the i2c writes in
 					 * us */
 	u8 burst_bclkdiv;		/* BCLK divider value in burst mode */
+	u8 *reg_cache;
 	unsigned int burst_rate;	/* Interface speed in Burst modes */
 
 	int keep_bclk;			/* Keep the BCLK continuously running
@@ -173,7 +174,8 @@ static const u8 dac33_reg[DAC33_CACHEREGNUM] = {
 static inline unsigned int dac33_read_reg_cache(struct snd_soc_codec *codec,
 						unsigned reg)
 {
-	u8 *cache = codec->reg_cache;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	u8 *cache = dac33->reg_cache;
 	if (reg >= DAC33_CACHEREGNUM)
 		return 0;
 
@@ -183,7 +185,8 @@ static inline unsigned int dac33_read_reg_cache(struct snd_soc_codec *codec,
 static inline void dac33_write_reg_cache(struct snd_soc_codec *codec,
 					 u8 reg, u8 value)
 {
-	u8 *cache = codec->reg_cache;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	u8 *cache = dac33->reg_cache;
 	if (reg >= DAC33_CACHEREGNUM)
 		return;
 
@@ -243,19 +246,6 @@ static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
 	return ret;
 }
 
-static int dac33_write_locked(struct snd_soc_codec *codec, unsigned int reg,
-		       unsigned int value)
-{
-	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-
-	mutex_lock(&dac33->mutex);
-	ret = dac33_write(codec, reg, value);
-	mutex_unlock(&dac33->mutex);
-
-	return ret;
-}
-
 #define DAC33_I2C_ADDR_AUTOINC	0x80
 static int dac33_write16(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value)
@@ -1432,13 +1422,9 @@ static int dac33_soc_remove(struct snd_soc_codec *codec)
 }
 
 static const struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
-	.read = dac33_read_reg_cache,
-	.write = dac33_write_locked,
 	.set_bias_level = dac33_set_bias_level,
 	.idle_bias_off = true,
-	.reg_cache_size = ARRAY_SIZE(dac33_reg),
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = dac33_reg,
+
 	.probe = dac33_soc_probe,
 	.remove = dac33_soc_remove,
 
@@ -1497,6 +1483,13 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	if (dac33 == NULL)
 		return -ENOMEM;
 
+	dac33->reg_cache = devm_kmemdup(&client->dev,
+					dac33_reg,
+					ARRAY_SIZE(dac33_reg) * sizeof(u8),
+					GFP_KERNEL);
+	if (!dac33->reg_cache)
+		return -ENOMEM;
+
 	dac33->i2c = client;
 	mutex_init(&dac33->mutex);
 	spin_lock_init(&dac33->lock);
-- 
2.15.0
