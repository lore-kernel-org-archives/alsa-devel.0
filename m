From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: wm8994: Allow debounce before MICDET
	identification
Date: Thu, 30 May 2013 13:42:29 +0100
Message-ID: <1369917750-7322-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1369917750-7322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7C9902651A3
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:42:35 +0200 (CEST)
In-Reply-To: <1369917750-7322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For systems which do not have a jack detection feature allow some debounce
to be specified before we perform accessory identification, improving
robustness without impacting button detection responsiveness.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h |    5 +++++
 sound/soc/codecs/wm8994.c        |   35 +++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm8994.h        |    2 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index 90e9bf8..90c6052 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -182,6 +182,11 @@ struct wm8994_pdata {
 	 */
 	int micdet_delay;
 
+	/* Delay between microphone detect completing and reporting on
+	 * insert (specified in ms)
+	 */
+	int mic_id_delay;
+
 	/* IRQ for microphone detection if brought out directly as a
 	 * signal.
 	 */
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 365e6f9..d921463 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3666,6 +3666,8 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 
 	pm_runtime_get_sync(codec->dev);
 
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
+
 	mutex_lock(&wm8994->accdet_lock);
 
 	reg = snd_soc_read(codec, WM1811_JACKDET_CTRL);
@@ -3848,11 +3850,33 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 }
 EXPORT_SYMBOL_GPL(wm8958_mic_detect);
 
+static void wm8958_mic_work(struct work_struct *work)
+{
+	struct wm8994_priv *wm8994 = container_of(work,
+						  struct wm8994_priv,
+						  mic_complete_work.work);
+	struct snd_soc_codec *codec = wm8994->hubs.codec;
+
+	dev_crit(codec->dev, "MIC WORK %x\n", wm8994->mic_status);
+
+	pm_runtime_get_sync(codec->dev);
+
+	mutex_lock(&wm8994->accdet_lock);
+
+	wm8994->mic_id_cb(wm8994->mic_id_cb_data, wm8994->mic_status);
+
+	mutex_unlock(&wm8994->accdet_lock);
+
+	pm_runtime_put(codec->dev);
+
+	dev_crit(codec->dev, "MIC WORK %x DONE\n", wm8994->mic_status);
+}
+
 static irqreturn_t wm8958_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *wm8994 = data;
 	struct snd_soc_codec *codec = wm8994->hubs.codec;
-	int reg, count, ret;
+	int reg, count, ret, id_delay;
 
 	/*
 	 * Jack detection may have detected a removal simulataneously
@@ -3862,6 +3886,7 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	if (!(snd_soc_read(codec, WM8958_MIC_DETECT_1) & WM8958_MICD_ENA))
 		return IRQ_HANDLED;
 
+	cancel_delayed_work_sync(&wm8994->mic_complete_work);
 	cancel_delayed_work_sync(&wm8994->open_circuit_work);
 
 	pm_runtime_get_sync(codec->dev);
@@ -3916,8 +3941,12 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 		goto out;
 	}
 
+	wm8994->mic_status = reg;
+	id_delay = wm8994->wm8994->pdata.mic_id_delay;
+
 	if (wm8994->mic_detecting)
-		wm8994->mic_id_cb(wm8994->mic_id_cb_data, reg);
+		schedule_delayed_work(&wm8994->mic_complete_work,
+				      msecs_to_jiffies(id_delay));
 	else
 		wm8958_button_det(codec, reg);
 
@@ -3983,6 +4012,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	}
 
+	INIT_DELAYED_WORK(&wm8994->mic_complete_work, wm8958_mic_work);
+
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll_locked); i++)
 		init_completion(&wm8994->fll_locked[i]);
 
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 9d19a91..6536f8d 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -135,6 +135,8 @@ struct wm8994_priv {
 	struct wm8994_micdet micdet[2];
 	struct delayed_work mic_work;
 	struct delayed_work open_circuit_work;
+	struct delayed_work mic_complete_work;
+	u16 mic_status;
 	bool mic_detecting;
 	bool jack_mic;
 	int btn_mask;
-- 
1.7.10.4
