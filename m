From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] [v3] ASoC: cs4270: use the built-in register
	cache support
Date: Mon, 10 Jan 2011 13:28:32 -0600
Message-ID: <1294687713-16433-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by alsa0.perex.cz (Postfix) with ESMTP id 9C8A7245CA
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 20:28:44 +0100 (CET)
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

Update the CS4270 driver to use ASoC's internal codec register cache feature.
This change allows ASoC to perform the low-level I2C operations necessary to
read the register cache.  Support is also added for initializing the register
cache with an array of known power-on default values.

The CS4270 driver was handling the register cache itself, but somwhere along
the conversion to multi-compaonent, this feature broke.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Mark, I don't have power-management support working on my hardware, so I can't
test cs4270_soc_resume(), but I have a suspicion that the call to
i2c_smbus_write_byte_data() should be replaced with codec->hw_write().

 sound/soc/codecs/cs4270.c |  161 +++++++++++++-------------------------------
 1 files changed, 48 insertions(+), 113 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 3a582ca..8b51245 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -106,6 +106,21 @@
 #define CS4270_MUTE_DAC_A	0x01
 #define CS4270_MUTE_DAC_B	0x02
 
+/* Power-on default values for the registers
+ *
+ * This array contains the power-on default values of the registers, with the
+ * exception of the "CHIPID" register (01h).  The lower four bits of that
+ * register contain the hardware revision, so it is treated as volatile.
+ *
+ * Also note that on the CS4270, the first readable register is 1, but ASoC
+ * assumes the first register is 0.  Therfore, the array must have an entry for
+ * register 0, but we use cs4270_reg_is_readable() to tell ASoC that it can't
+ * be read.
+ */
+static const u8 cs4270_default_reg_cache[CS4270_LASTREG + 1] = {
+	0x00, 0x00, 0x00, 0x30, 0x00, 0x60, 0x20, 0x00, 0x00
+};
+
 static const char *supply_names[] = {
 	"va", "vd", "vlc"
 };
@@ -178,6 +193,20 @@ static struct cs4270_mode_ratios cs4270_mode_ratios[] = {
 /* The number of MCLK/LRCK ratios supported by the CS4270 */
 #define NUM_MCLK_RATIOS		ARRAY_SIZE(cs4270_mode_ratios)
 
+static int cs4270_reg_is_readable(unsigned int reg)
+{
+	return (reg >= CS4270_FIRSTREG) && (reg <= CS4270_LASTREG);
+}
+
+static int cs4270_reg_is_volatile(unsigned int reg)
+{
+	/* Unreadable registers are considered volatile */
+	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
+		return 1;
+
+	return reg == CS4270_CHIPID;
+}
+
 /**
  * cs4270_set_dai_sysclk - determine the CS4270 samples rates.
  * @codec_dai: the codec DAI
@@ -263,97 +292,6 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
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
- * cs4270_read_reg_cache - read from the CS4270 register cache.
- * @codec: the codec for this CS4270
- * @reg: the register to read
- *
- * This function returns the value for a given register.  It reads only from
- * the register cache, not the hardware itself.
- *
- * This CS4270 registers are cached to avoid excessive I2C I/O operations.
- * After the initial read to pre-fill the cache, the CS4270 never updates
- * the register values, so we won't have a cache coherency problem.
- */
-static unsigned int cs4270_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u8 *cache = codec->reg_cache;
-
-	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
-		return -EIO;
-
-	return cache[reg - CS4270_FIRSTREG];
-}
-
-/**
- * cs4270_i2c_write - write to a CS4270 register via the I2C bus.
- * @codec: the codec for this CS4270
- * @reg: the register to write
- * @value: the value to write to the register
- *
- * This function writes the given value to the given CS4270 register, and
- * also updates the register cache.
- *
- * Note that we don't use the hw_write function pointer of snd_soc_codec.
- * That's because it's too clunky: the hw_write_t prototype does not match
- * i2c_smbus_write_byte_data(), and it's just another layer of overhead.
- */
-static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
-			    unsigned int value)
-{
-	u8 *cache = codec->reg_cache;
-
-	if ((reg < CS4270_FIRSTREG) || (reg > CS4270_LASTREG))
-		return -EIO;
-
-	/* Only perform an I2C operation if the new value is different */
-	if (cache[reg - CS4270_FIRSTREG] != value) {
-		struct i2c_client *client = codec->control_data;
-		if (i2c_smbus_write_byte_data(client, reg, value)) {
-			dev_err(codec->dev, "i2c write failed\n");
-			return -EIO;
-		}
-
-		/* We've written to the hardware, so update the cache */
-		cache[reg - CS4270_FIRSTREG] = value;
-	}
-
-	return 0;
-}
-
-/**
  * cs4270_hw_params - program the CS4270 with the given hardware parameters.
  * @substream: the audio stream
  * @params: the hardware parameters to set
@@ -550,15 +488,16 @@ static struct snd_soc_dai_driver cs4270_dai = {
 static int cs4270_probe(struct snd_soc_codec *codec)
 {
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	int i, ret, reg;
+	int i, ret;
 
 	codec->control_data = cs4270->control_data;
 
-	/* The I2C interface is set up, so pre-fill our register cache */
-
-	ret = cs4270_fill_cache(codec);
+	/* Tell ASoC what kind of I/O to use to read the registers.  ASoC will
+	 * then do the I2C transactions itself.
+	 */
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, cs4270->control_type);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to fill register cache\n");
+		dev_err(codec->dev, "failed to set cache I/O (ret=%i)\n", ret);
 		return ret;
 	}
 
@@ -567,10 +506,7 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 	 * this feature disabled by default.  An application (e.g. alsactl) can
 	 * re-enabled it by using the controls.
 	 */
-
-	reg = cs4270_read_reg_cache(codec, CS4270_MUTE);
-	reg &= ~CS4270_MUTE_AUTO;
-	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
+	ret = snd_soc_update_bits(codec, CS4270_MUTE, CS4270_MUTE_AUTO, 0);
 	if (ret < 0) {
 		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
@@ -581,10 +517,8 @@ static int cs4270_probe(struct snd_soc_codec *codec)
 	 * playback has started.  An application (e.g. alsactl) can
 	 * re-enabled it by using the controls.
 	 */
-
-	reg = cs4270_read_reg_cache(codec, CS4270_TRANS);
-	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
-	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
+	ret = snd_soc_update_bits(codec, CS4270_TRANS,
+		CS4270_TRANS_SOFT | CS4270_TRANS_ZERO, 0);
 	if (ret < 0) {
 		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
@@ -707,15 +641,16 @@ static int cs4270_soc_resume(struct snd_soc_codec *codec)
  * Assign this variable to the codec_dev field of the machine driver's
  * snd_soc_device structure.
  */
-static struct snd_soc_codec_driver soc_codec_device_cs4270 = {
-	.probe =	cs4270_probe,
-	.remove =	cs4270_remove,
-	.suspend =	cs4270_soc_suspend,
-	.resume =	cs4270_soc_resume,
-	.read = cs4270_read_reg_cache,
-	.write = cs4270_i2c_write,
-	.reg_cache_size = CS4270_NUMREGS,
-	.reg_word_size = sizeof(u8),
+static const struct snd_soc_codec_driver soc_codec_device_cs4270 = {
+	.probe =		cs4270_probe,
+	.remove =		cs4270_remove,
+	.suspend =		cs4270_soc_suspend,
+	.resume =		cs4270_soc_resume,
+	.volatile_register =	cs4270_reg_is_volatile,
+	.readable_register =	cs4270_reg_is_readable,
+	.reg_cache_size =	CS4270_LASTREG + 1,
+	.reg_word_size =	sizeof(u8),
+	.reg_cache_default =	cs4270_default_reg_cache,
 };
 
 /**
-- 
1.7.3.4
