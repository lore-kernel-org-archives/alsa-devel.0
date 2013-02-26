From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8994: Defer declaration of open
	circuit microphones
Date: Tue, 26 Feb 2013 17:15:33 +0000
Message-ID: <1361898934-615-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2660265326
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 18:15:40 +0100 (CET)
In-Reply-To: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Provide a bit of debounce to handle pathological cases with slow input
better by allowing the microphone detection to run for a bit longer.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   40 +++++++++++++++++++++++++++++++---------
 sound/soc/codecs/wm8994.h |    1 +
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index d6e994d..1d98f28 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3474,6 +3474,31 @@ static void wm8958_button_det(struct snd_soc_codec *codec, u16 status)
 			    wm8994->btn_mask);
 }
 
+static void wm8958_open_circuit_work(struct work_struct *work)
+{
+	struct wm8994_priv *wm8994 = container_of(work,
+						  struct wm8994_priv,
+						  open_circuit_work.work);
+	struct device *dev = wm8994->wm8994->dev;
+
+	mutex_lock(&wm8994->accdet_lock);
+
+	dev_dbg(dev, "Reporting open circuit\n");
+
+	wm8994->jack_mic = false;
+	wm8994->mic_detecting = true;
+
+	wm1811_micd_stop(wm8994->hubs.codec);
+
+	wm8958_micd_set_rate(wm8994->hubs.codec);
+
+	snd_soc_jack_report(wm8994->micdet[0].jack, 0,
+			    wm8994->btn_mask |
+			    SND_JACK_HEADSET);
+
+	mutex_unlock(&wm8994->accdet_lock);
+}
+
 static void wm8958_mic_id(void *data, u16 status)
 {
 	struct snd_soc_codec *codec = data;
@@ -3483,16 +3508,9 @@ static void wm8958_mic_id(void *data, u16 status)
 	if (!(status & WM8958_MICD_STS)) {
 		/* If nothing present then clear our statuses */
 		dev_dbg(codec->dev, "Detected open circuit\n");
-		wm8994->jack_mic = false;
-		wm8994->mic_detecting = true;
-
-		wm1811_micd_stop(codec);
 
-		wm8958_micd_set_rate(codec);
-
-		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
-				    wm8994->btn_mask |
-				    SND_JACK_HEADSET);
+		schedule_delayed_work(&wm8994->open_circuit_work,
+				      msecs_to_jiffies(500));
 		return;
 	}
 
@@ -3778,6 +3796,8 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	if (!(snd_soc_read(codec, WM8958_MIC_DETECT_1) & WM8958_MICD_ENA))
 		return IRQ_HANDLED;
 
+	cancel_delayed_work_sync(&wm8994->open_circuit_work);
+
 	pm_runtime_get_sync(codec->dev);
 
 	/* We may occasionally read a detection without an impedence
@@ -3877,6 +3897,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	mutex_init(&wm8994->accdet_lock);
 	INIT_DELAYED_WORK(&wm8994->jackdet_bootstrap,
 			  wm1811_jackdet_bootstrap);
+	INIT_DELAYED_WORK(&wm8994->open_circuit_work,
+			  wm8958_open_circuit_work);
 
 	switch (control->type) {
 	case WM8994:
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 20356b3..130ce93 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -134,6 +134,7 @@ struct wm8994_priv {
 	struct mutex accdet_lock;
 	struct wm8994_micdet micdet[2];
 	struct delayed_work mic_work;
+	struct delayed_work open_circuit_work;
 	bool mic_detecting;
 	bool jack_mic;
 	int btn_mask;
-- 
1.7.10.4
