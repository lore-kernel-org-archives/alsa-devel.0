From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tlv320dac33: Error handling for broken
	chip
Date: Tue, 26 Oct 2010 11:45:59 +0300
Message-ID: <1288082759-25276-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 69798103801
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 10:46:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Correct/Implement handling of broken chip.
Fail the soc_prope if the communication with the chip
fails (can not read chip ID).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tlv320dac33.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index d251ff5..fed1458 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -200,7 +200,7 @@ static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
 		      u8 *value)
 {
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
-	int val;
+	int val, ret = 0;
 
 	*value = reg & 0xff;
 
@@ -210,6 +210,7 @@ static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
 		if (val < 0) {
 			dev_err(codec->dev, "Read failed (%d)\n", val);
 			value[0] = dac33_read_reg_cache(codec, reg);
+			ret = val;
 		} else {
 			value[0] = val;
 			dac33_write_reg_cache(codec, reg, val);
@@ -218,7 +219,7 @@ static int dac33_read(struct snd_soc_codec *codec, unsigned int reg,
 		value[0] = dac33_read_reg_cache(codec, reg);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int dac33_write(struct snd_soc_codec *codec, unsigned int reg,
@@ -329,13 +330,18 @@ static void dac33_init_chip(struct snd_soc_codec *codec)
 		    dac33_read_reg_cache(codec, DAC33_LINER_TO_RLO_VOL));
 }
 
-static inline void dac33_read_id(struct snd_soc_codec *codec)
+static inline int dac33_read_id(struct snd_soc_codec *codec)
 {
+	int i, ret = 0;
 	u8 reg;
 
-	dac33_read(codec, DAC33_DEVICE_ID_MSB, &reg);
-	dac33_read(codec, DAC33_DEVICE_ID_LSB, &reg);
-	dac33_read(codec, DAC33_DEVICE_REV_ID, &reg);
+	for (i = 0; i < 3; i++) {
+		ret = dac33_read(codec, DAC33_DEVICE_ID_MSB + i, &reg);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
 }
 
 static inline void dac33_soft_power(struct snd_soc_codec *codec, int power)
@@ -1414,9 +1420,15 @@ static int dac33_soc_probe(struct snd_soc_codec *codec)
 		dev_err(codec->dev, "Failed to power up codec: %d\n", ret);
 		goto err_power;
 	}
-	dac33_read_id(codec);
+	ret = dac33_read_id(codec);
 	dac33_hard_power(codec, 0);
 
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to read chip ID: %d\n", ret);
+		ret = -ENODEV;
+		goto err_power;
+	}
+
 	/* Check if the IRQ number is valid and request it */
 	if (dac33->irq >= 0) {
 		ret = request_irq(dac33->irq, dac33_interrupt_handler,
-- 
1.7.3.2
