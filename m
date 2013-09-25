From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: tlv320aic26: Convert to direct
	regmap API usage
Date: Wed, 25 Sep 2013 13:30:39 +0100
Message-ID: <1380112239-11149-3-git-send-email-broonie@kernel.org>
References: <1380112239-11149-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A27BB26546D
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 14:30:47 +0200 (CEST)
In-Reply-To: <1380112239-11149-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This moves us towards being able to remove the duplicated register I/O
code in ASoC.

The datasheet and the driver document the device as having a register map
divided into pages but since the paging is actually done by sending the
page address and the register address with each transaction this is no
different to having a simple register address. The datasheet does also
document the low five bits of the 16 bit "command" as unused which we could
represent as padding but it seems simpler and less confusing to things
that use block transfers or autoincrement to represent these as part of
the register address.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 80 +++++++-----------------------------------
 sound/soc/codecs/tlv320aic26.h |  5 +--
 2 files changed, 13 insertions(+), 72 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 4d82447..94a658f 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -29,6 +29,7 @@ MODULE_LICENSE("GPL");
 /* AIC26 driver private data */
 struct aic26 {
 	struct spi_device *spi;
+	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 	int master;
 	int datfm;
@@ -40,72 +41,6 @@ struct aic26 {
 	int keyclick_len;
 };
 
-/* ---------------------------------------------------------------------
- * Register access routines
- */
-static unsigned int aic26_reg_read(struct snd_soc_codec *codec,
-				   unsigned int reg)
-{
-	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-	u16 cmd, value;
-	u8 buffer[2];
-	int rc;
-
-	if (reg >= AIC26_NUM_REGS) {
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	/* Do SPI transfer; first 16bits are command; remaining is
-	 * register contents */
-	cmd = AIC26_READ_COMMAND_WORD(reg);
-	buffer[0] = (cmd >> 8) & 0xff;
-	buffer[1] = cmd & 0xff;
-	rc = spi_write_then_read(aic26->spi, buffer, 2, buffer, 2);
-	if (rc) {
-		dev_err(&aic26->spi->dev, "AIC26 reg read error\n");
-		return -EIO;
-	}
-	value = (buffer[0] << 8) | buffer[1];
-
-	/* Update the cache before returning with the value */
-	cache[reg] = value;
-	return value;
-}
-
-static int aic26_reg_write(struct snd_soc_codec *codec, unsigned int reg,
-			   unsigned int value)
-{
-	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-	u16 cmd;
-	u8 buffer[4];
-	int rc;
-
-	if (reg >= AIC26_NUM_REGS) {
-		WARN_ON_ONCE(1);
-		return -EINVAL;
-	}
-
-	/* Do SPI transfer; first 16bits are command; remaining is data
-	 * to write into register */
-	cmd = AIC26_WRITE_COMMAND_WORD(reg);
-	buffer[0] = (cmd >> 8) & 0xff;
-	buffer[1] = cmd & 0xff;
-	buffer[2] = value >> 8;
-	buffer[3] = value;
-	rc = spi_write(aic26->spi, buffer, 4);
-	if (rc) {
-		dev_err(&aic26->spi->dev, "AIC26 reg read error\n");
-		return -EIO;
-	}
-
-	/* update cache before returning */
-	cache[reg] = value;
-	return 0;
-}
-
 static const struct snd_soc_dapm_widget tlv320aic26_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("MICIN"),
 SND_SOC_DAPM_INPUT("AUX"),
@@ -360,6 +295,8 @@ static int aic26_probe(struct snd_soc_codec *codec)
 	struct aic26 *aic26 = dev_get_drvdata(codec->dev);
 	int ret, reg;
 
+	snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
+
 	aic26->codec = codec;
 
 	/* Reset the codec to power on defaults */
@@ -385,8 +322,6 @@ static int aic26_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver aic26_soc_codec_dev = {
 	.probe = aic26_probe,
-	.read = aic26_reg_read,
-	.write = aic26_reg_write,
 	.controls = aic26_snd_controls,
 	.num_controls = ARRAY_SIZE(aic26_snd_controls),
 	.dapm_widgets = tlv320aic26_dapm_widgets,
@@ -395,6 +330,11 @@ static struct snd_soc_codec_driver aic26_soc_codec_dev = {
 	.num_dapm_routes = ARRAY_SIZE(tlv320aic26_dapm_routes),
 };
 
+static const struct regmap_config aic26_regmap = {
+	.reg_bits = 16,
+	.val_bits = 16,
+};
+
 /* ---------------------------------------------------------------------
  * SPI device portion of driver: probe and release routines and SPI
  * 				 driver registration.
@@ -411,6 +351,10 @@ static int aic26_spi_probe(struct spi_device *spi)
 	if (!aic26)
 		return -ENOMEM;
 
+	aic26->regmap = devm_regmap_init_spi(spi, &aic26_regmap);
+	if (IS_ERR(aic26->regmap))
+		return PTR_ERR(aic26->regmap);
+
 	/* Initialize the driver data */
 	aic26->spi = spi;
 	dev_set_drvdata(&spi->dev, aic26);
diff --git a/sound/soc/codecs/tlv320aic26.h b/sound/soc/codecs/tlv320aic26.h
index 67f19c3..629b85e 100644
--- a/sound/soc/codecs/tlv320aic26.h
+++ b/sound/soc/codecs/tlv320aic26.h
@@ -9,10 +9,7 @@
 #define _TLV320AIC16_H_
 
 /* AIC26 Registers */
-#define AIC26_READ_COMMAND_WORD(addr)	((1 << 15) | (addr << 5))
-#define AIC26_WRITE_COMMAND_WORD(addr)	((0 << 15) | (addr << 5))
-#define AIC26_PAGE_ADDR(page, offset)	((page << 6) | offset)
-#define AIC26_NUM_REGS			AIC26_PAGE_ADDR(3, 0)
+#define AIC26_PAGE_ADDR(page, offset)	((page << 11) | offset << 5)
 
 /* Page 0: Auxiliary data registers */
 #define AIC26_REG_BAT1			AIC26_PAGE_ADDR(0, 0x05)
-- 
1.8.4.rc3
