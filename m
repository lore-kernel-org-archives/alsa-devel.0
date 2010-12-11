From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v4 2/3] ASoC: twl6040: Add jack support for
 headset and handset
Date: Fri, 10 Dec 2010 20:45:17 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225CC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 20B0A2464D
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 03:45:19 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

This patch adds support for reporting twl6040 headset and
handset jack events.

The machine driver retrieves and report the status  through
twl6040_hs_jack_detect.

A workq is used to debounce of the irq.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   67 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/twl6040.h |    7 ++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b92f2b7..5d7e2f7 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -42,6 +42,11 @@
 #define TWL6040_RATES	 (SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 #define TWL6040_FORMATS	 (SNDRV_PCM_FMTBIT_S32_LE)
 
+struct twl6040_jack_data {
+	struct snd_soc_jack *jack;
+	int report;
+};
+
 /* codec private data */
 struct twl6040_data {
 	int audpwron;
@@ -52,6 +57,11 @@ struct twl6040_data {
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 	struct completion ready;
+	struct twl6040_jack_data hs_jack;
+	struct snd_soc_codec *codec;
+	struct workqueue_struct *workqueue;
+	struct delayed_work delayed_work;
+	struct mutex mutex;
 };
 
 /*
@@ -381,6 +391,47 @@ static int twl6040_power_mode_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+void twl6040_hs_jack_report(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack, int report)
+{
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	int status;
+
+	mutex_lock(&priv->mutex);
+
+	/* Sync status */
+	status = twl6040_read_reg_volatile(codec, TWL6040_REG_STATUS);
+	if (status & TWL6040_PLUGCOMP)
+		snd_soc_jack_report(jack, report, report);
+	else
+		snd_soc_jack_report(jack, 0, report);
+
+	mutex_unlock(&priv->mutex);
+}
+
+void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
+				struct snd_soc_jack *jack, int report)
+{
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_jack_data *hs_jack = &priv->hs_jack;
+
+	hs_jack->jack = jack;
+	hs_jack->report = report;
+
+	twl6040_hs_jack_report(codec, hs_jack->jack, hs_jack->report);
+}
+EXPORT_SYMBOL_GPL(twl6040_hs_jack_detect);
+
+static void twl6040_accessory_work(struct work_struct *work)
+{
+	struct twl6040_data *priv = container_of(work,
+					struct twl6040_data, delayed_work.work);
+	struct snd_soc_codec *codec = priv->codec;
+	struct twl6040_jack_data *hs_jack = &priv->hs_jack;
+
+	twl6040_hs_jack_report(codec, hs_jack->jack, hs_jack->report);
+}
+
 /* audio interrupt handler */
 static irqreturn_t twl6040_naudint_handler(int irq, void *data)
 {
@@ -396,6 +447,9 @@ static irqreturn_t twl6040_naudint_handler(int irq, void *data)
 		break;
 	case TWL6040_PLUGINT:
 	case TWL6040_UNPLUGINT:
+		queue_delayed_work(priv->workqueue, &priv->delayed_work,
+							msecs_to_jiffies(200));
+		break;
 	case TWL6040_HOOKINT:
 		break;
 	case TWL6040_HFINT:
@@ -1023,6 +1077,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, priv);
 
+	priv->codec = codec;
+
 	if (twl_codec) {
 		audpwron = twl_codec->audpwron_gpio;
 		naudint = twl_codec->naudint_irq;
@@ -1033,6 +1089,14 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 
 	priv->audpwron = audpwron;
 	priv->naudint = naudint;
+	priv->workqueue = create_singlethread_workqueue("twl6040-codec");
+
+	if (!priv->workqueue)
+		goto work_err;
+
+	INIT_DELAYED_WORK(&priv->delayed_work, twl6040_accessory_work);
+
+	mutex_init(&priv->mutex);
 
 	init_completion(&priv->ready);
 
@@ -1089,6 +1153,8 @@ gpio2_err:
 	if (gpio_is_valid(audpwron))
 		gpio_free(audpwron);
 gpio1_err:
+	destroy_workqueue(priv->workqueue);
+work_err:
 	kfree(priv);
 	return ret;
 }
@@ -1107,6 +1173,7 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 	if (naudint)
 		free_irq(naudint, codec);
 
+	destroy_workqueue(priv->workqueue);
 	kfree(priv);
 
 	return 0;
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index f7c77fa..67396f6 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -135,4 +135,11 @@
 #define TWL6040_HPPLL_ID		1
 #define TWL6040_LPPLL_ID		2
 
+/* STATUS (0x2E) fields */
+
+#define TWL6040_PLUGCOMP		0x02
+
+void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
+			    struct snd_soc_jack *jack, int report);
+
 #endif /* End of __TWL6040_H__ */
-- 
1.7.0.4
