From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] ASoC: cs4270: fix dynamic initialization of
	register cache
Date: Thu, 6 Jan 2011 12:52:48 -0600
Message-ID: <1294339968-420-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by alsa0.perex.cz (Postfix) with ESMTP id 3D53524503
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 19:53:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, dp@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The CS4270 codec driver dynamically initializes its register cache, rather than
using a hard-coded array.  Somwhere along the conversion to multi-compaonent,
this feature broke.

Because the register cache is more deeply ingrained into ASoC itself, the
initialization of the cache has to happen earlier, in the I2C probe function.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |   68 ++++++++++++++++----------------------------
 1 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 3a582ca..4d36c0e 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -114,6 +114,8 @@ static const char *supply_names[] = {
 struct cs4270_private {
 	enum snd_soc_control_type control_type;
 	void *control_data;
+	u8 reg_cache[CS4270_NUMREGS];
+	struct snd_soc_codec_driver codec_drv;
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
@@ -263,38 +265,6 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 }
 
 /**
- * cs4270_fill_cache - pre-fill the CS4270 register cache.
- * @codec: the codec for this CS4270
- *
- * This function fills in the CS4270 register cache by reading the register
- * values from the hardware.
- *
- * This CS4270 registers are cached to avoid excessive I2C I/O operations.
- * After the initial read to pre-fill the cache, the CS4270 never updates
- * the register values, so we won't have a cache coherency problem.
- *
- * We use the auto-increment feature of the CS4270 to read all registers in
- * one shot.
- */
-static int cs4270_fill_cache(struct snd_soc_codec *codec)
-{
-	u8 *cache = codec->reg_cache;
-	struct i2c_client *i2c_client = codec->control_data;
-	s32 length;
-
-	length = i2c_smbus_read_i2c_block_data(i2c_client,
-		CS4270_FIRSTREG | CS4270_I2C_INCR, CS4270_NUMREGS, cache);
-
-	if (length != CS4270_NUMREGS) {
-		dev_err(codec->dev, "i2c read failure, addr=0x%x\n",
-		       i2c_client->addr);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-/**
  * cs4270_read_reg_cache - read from the CS4270 register cache.
  * @codec: the codec for this CS4270
  * @reg: the register to read
@@ -554,14 +524,6 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 
 	codec->control_data = cs4270->control_data;
 
-	/* The I2C interface is set up, so pre-fill our register cache */
-
-	ret = cs4270_fill_cache(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to fill register cache\n");
-		return ret;
-	}
-
 	/* Disable auto-mute.  This feature appears to be buggy.  In some
 	 * situations, auto-mute will not deactivate when it should, so we want
 	 * this feature disabled by default.  An application (e.g. alsactl) can
@@ -707,7 +669,7 @@ static int cs4270_soc_resume(struct snd_soc_codec *codec)
  * Assign this variable to the codec_dev field of the machine driver's
  * snd_soc_device structure.
  */
-static struct snd_soc_codec_driver soc_codec_device_cs4270 = {
+static const struct snd_soc_codec_driver soc_codec_device_cs4270 = {
 	.probe =	cs4270_probe,
 	.remove =	cs4270_remove,
 	.suspend =	cs4270_soc_suspend,
@@ -757,12 +719,32 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		return -ENOMEM;
 	}
 
+	/* Initialize the register cache.  We do this dynamically because we
+	 * don't know what the default values are.
+	 */
+	ret = i2c_smbus_read_i2c_block_data(i2c_client,
+		CS4270_FIRSTREG | CS4270_I2C_INCR, CS4270_NUMREGS,
+		cs4270->reg_cache);
+	if (ret != CS4270_NUMREGS) {
+		dev_err(&i2c_client->dev, "i2c read failure, addr=0x%x\n",
+		       i2c_client->addr);
+		return -EIO;
+	}
+
+	/* We need to create a new copy of the snd_soc_codec_driver structure
+	 * for each CS4270 because the .reg_cache_default field is different
+	 * for each one.
+	 */
+	memcpy(&cs4270->codec_drv, &soc_codec_device_cs4270,
+	       sizeof(soc_codec_device_cs4270));
+	cs4270->codec_drv.reg_cache_default = cs4270->reg_cache;
+
 	i2c_set_clientdata(i2c_client, cs4270);
 	cs4270->control_data = i2c_client;
 	cs4270->control_type = SND_SOC_I2C;
 
-	ret = snd_soc_register_codec(&i2c_client->dev,
-			&soc_codec_device_cs4270, &cs4270_dai, 1);
+	ret = snd_soc_register_codec(&i2c_client->dev, &cs4270->codec_drv,
+				     &cs4270_dai, 1);
 	if (ret < 0)
 		kfree(cs4270);
 	return ret;
-- 
1.7.3.4
