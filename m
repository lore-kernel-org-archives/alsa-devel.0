From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum workaround into SPI I/O function
Date: Wed, 18 Sep 2013 19:06:26 +0100
Message-ID: <1379527587-14567-2-git-send-email-broonie@kernel.org>
References: <1379527587-14567-1-git-send-email-broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379527587-14567-1-git-send-email-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Marc Reilly <marc@cpdesign.com.au>, u.kleine-koenig@pengutronix.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Move the workaround for double sending AUDIO_CODEC and AUDIO_DAC writes
into the SPI core, aiding refactoring to eliminate the ASoC custom I/O
functions and avoiding the extra writes for I2C.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mfd/mc13xxx-spi.c   | 5 +++++
 include/linux/mfd/mc13xxx.h | 7 +++++++
 sound/soc/codecs/mc13783.c  | 4 ----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mc13xxx-spi.c b/drivers/mfd/mc13xxx-spi.c
index 77189da..363c359 100644
--- a/drivers/mfd/mc13xxx-spi.c
+++ b/drivers/mfd/mc13xxx-spi.c
@@ -94,10 +94,15 @@ static int mc13xxx_spi_write(void *context, const void *data, size_t count)
 {
 	struct device *dev = context;
 	struct spi_device *spi = to_spi_device(dev);
+	char *reg = data;
 
 	if (count != 4)
 		return -ENOTSUPP;
 
+	/* include errata fix for spi audio problems */
+	if (*reg == MC13783_AUDIO_CODEC || *reg == MC13783_AUDIO_DAC)
+		spi_write(spi, data, count);
+
 	return spi_write(spi, data, count);
 }
 
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 41ed592..67c17b5 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -41,6 +41,13 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx,
 		unsigned int mode, unsigned int channel,
 		u8 ato, bool atox, unsigned int *sample);
 
+#define MC13783_AUDIO_RX0	36
+#define MC13783_AUDIO_RX1	37
+#define MC13783_AUDIO_TX	38
+#define MC13783_SSI_NETWORK	39
+#define MC13783_AUDIO_CODEC	40
+#define MC13783_AUDIO_DAC	41
+
 #define MC13XXX_IRQ_ADCDONE	0
 #define MC13XXX_IRQ_ADCBISDONE	1
 #define MC13XXX_IRQ_TS		2
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index ea141e1..4d3c8fd 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -125,10 +125,6 @@ static int mc13783_write(struct snd_soc_codec *codec,
 
 	ret = mc13xxx_reg_write(priv->mc13xxx, reg, value);
 
-	/* include errata fix for spi audio problems */
-	if (reg == MC13783_AUDIO_CODEC || reg == MC13783_AUDIO_DAC)
-		ret = mc13xxx_reg_write(priv->mc13xxx, reg, value);
-
 	mc13xxx_unlock(priv->mc13xxx);
 
 	return ret;
-- 
1.8.4.rc3
