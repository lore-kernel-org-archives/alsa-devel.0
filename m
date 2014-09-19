From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/5] ASoC: max98090: Move interrupt request
	from codec probe to i2c probe
Date: Fri, 19 Sep 2014 14:48:17 +0300
Message-ID: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EE770261A7C
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:48:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Keep MAX98090 interrupt requested after i2c device probing as long as the
driver is loaded. This fixes the issue where subsequent codec probe
max98090_probe() call fails in interrupt request since interrupt wasn't
freed over codec remove-reprobe cycle.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index f1543653a699..fe77df6a76c2 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2159,12 +2159,16 @@ static void max98090_jack_work(struct work_struct *work)
 
 static irqreturn_t max98090_interrupt(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
-	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
+	struct max98090_priv *max98090 = data;
+	struct snd_soc_codec *codec = max98090->codec;
 	int ret;
 	unsigned int mask;
 	unsigned int active;
 
+	/* Treat interrupt before codec is initialized as spurious */
+	if (codec == NULL)
+		return IRQ_NONE;
+
 	dev_dbg(codec->dev, "***** max98090_interrupt *****\n");
 
 	ret = regmap_read(max98090->regmap, M98090_REG_INTERRUPT_S, &mask);
@@ -2367,17 +2371,6 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, M98090_REG_JACK_DETECT,
 		M98090_JDETEN_MASK | M98090_JDEB_25MS);
 
-	/* Register for interrupts */
-	dev_dbg(codec->dev, "irq = %d\n", max98090->irq);
-
-	ret = devm_request_threaded_irq(codec->dev, max98090->irq, NULL,
-		max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-		"max98090_interrupt", codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "request_irq failed: %d\n",
-			ret);
-	}
-
 	/*
 	 * Clear any old interrupts.
 	 * An old interrupt ocurring prior to installing the ISR
@@ -2417,6 +2410,7 @@ static int max98090_remove(struct snd_soc_codec *codec)
 	cancel_delayed_work_sync(&max98090->pll_det_enable_work);
 	cancel_work_sync(&max98090->pll_det_disable_work);
 	cancel_work_sync(&max98090->pll_work);
+	max98090->codec = NULL;
 
 	return 0;
 }
@@ -2478,6 +2472,15 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
+	ret = devm_request_threaded_irq(&i2c->dev, max98090->irq, NULL,
+		max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+		"max98090_interrupt", max98090);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "request_irq failed: %d\n",
+			ret);
+		return ret;
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_max98090, max98090_dai,
 			ARRAY_SIZE(max98090_dai));
-- 
2.1.0
