From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: cs42l51: Convert to direct regmap
	API usage
Date: Tue, 11 Feb 2014 19:26:48 +0000
Message-ID: <1392146808-19269-2-git-send-email-broonie@kernel.org>
References: <1392146808-19269-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB28526084B
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 20:27:26 +0100 (CET)
In-Reply-To: <1392146808-19269-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

As part of phasing out the ASoC level register I/O code (which is now just
a thin wrapper around regmap anyway) convert the cs42l51 driver to use the
regmap API directly.

We now no longer initialise the cache from hardware at startup, the regmap
caches are smart enough to understand which registers are actually cached
and read on demand. This should have no visible effect on the system.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/cs42l51.c | 59 ++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 50c08c8fc9bc..56be57429176 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -30,6 +30,7 @@
 #include <sound/pcm_params.h>
 #include <sound/pcm.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 
 #include "cs42l51.h"
 
@@ -40,7 +41,6 @@ enum master_slave_mode {
 };
 
 struct cs42l51_private {
-	enum snd_soc_control_type control_type;
 	unsigned int mclk;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
@@ -52,24 +52,6 @@ struct cs42l51_private {
 		SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
 		SNDRV_PCM_FMTBIT_S24_LE  | SNDRV_PCM_FMTBIT_S24_BE)
 
-static int cs42l51_fill_cache(struct snd_soc_codec *codec)
-{
-	u8 *cache = codec->reg_cache + 1;
-	struct i2c_client *i2c_client = to_i2c_client(codec->dev);
-	s32 length;
-
-	length = i2c_smbus_read_i2c_block_data(i2c_client,
-			CS42L51_FIRSTREG | 0x80, CS42L51_NUMREGS, cache);
-	if (length != CS42L51_NUMREGS) {
-		dev_err(&i2c_client->dev,
-				"I2C read failure, addr=0x%x (ret=%d vs %d)\n",
-				i2c_client->addr, length, CS42L51_NUMREGS);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
@@ -508,13 +490,7 @@ static int cs42l51_probe(struct snd_soc_codec *codec)
 	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
 	int ret, reg;
 
-	ret = cs42l51_fill_cache(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to fill register cache\n");
-		return ret;
-	}
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, cs42l51->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -538,8 +514,6 @@ static int cs42l51_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
 	.probe = cs42l51_probe,
-	.reg_cache_size = CS42L51_NUMREGS + 1,
-	.reg_word_size = sizeof(u8),
 
 	.controls = cs42l51_snd_controls,
 	.num_controls = ARRAY_SIZE(cs42l51_snd_controls),
@@ -549,28 +523,46 @@ static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
 	.num_dapm_routes = ARRAY_SIZE(cs42l51_routes),
 };
 
+static const struct regmap_config cs42l51_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = CS42L51_CHARGE_FREQ,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
 {
 	struct cs42l51_private *cs42l51;
+	struct regmap *regmap;
+	unsigned int val;
 	int ret;
 
+	regmap = devm_regmap_init_i2c(i2c_client, &cs42l51_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&i2c_client->dev, "Failed to create regmap: %d\n",
+			ret);
+		return ret;
+	}
+
 	/* Verify that we have a CS42L51 */
-	ret = i2c_smbus_read_byte_data(i2c_client, CS42L51_CHIP_REV_ID);
+	ret = regmap_read(regmap, CS42L51_CHIP_REV_ID, &val);
 	if (ret < 0) {
 		dev_err(&i2c_client->dev, "failed to read I2C\n");
 		goto error;
 	}
 
-	if ((ret != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_A)) &&
-	    (ret != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_B))) {
-		dev_err(&i2c_client->dev, "Invalid chip id\n");
+	if ((val != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_A)) &&
+	    (val != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_B))) {
+		dev_err(&i2c_client->dev, "Invalid chip id: %x\n", val);
 		ret = -ENODEV;
 		goto error;
 	}
 
 	dev_info(&i2c_client->dev, "found device cs42l51 rev %d\n",
-				ret & 7);
+		 val & 7);
 
 	cs42l51 = devm_kzalloc(&i2c_client->dev, sizeof(struct cs42l51_private),
 			       GFP_KERNEL);
@@ -578,7 +570,6 @@ static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c_client, cs42l51);
-	cs42l51->control_type = SND_SOC_I2C;
 
 	ret =  snd_soc_register_codec(&i2c_client->dev,
 			&soc_codec_device_cs42l51, &cs42l51_dai, 1);
-- 
1.9.0.rc3
