From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Prevent double lock of
	accdet_lock mutex on wm1811
Date: Mon, 16 Jun 2014 21:24:03 +0100
Message-ID: <1402950243-3490-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8262D2654B5
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 22:24:10 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

wm1811_micd_stop takes the accdet_lock mutex, and is called from two
places, one of which is already holding the accdet_lock. This obviously
causes a lock up.

This patch fixes this issue by removing the lock from wm1811_micd_stop
and ensuring that it is always locked externally.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 247b390..9719d3c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3505,6 +3505,7 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Should be called with accdet_lock held */
 static void wm1811_micd_stop(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -3512,14 +3513,10 @@ static void wm1811_micd_stop(struct snd_soc_codec *codec)
 	if (!wm8994->jackdet)
 		return;
 
-	mutex_lock(&wm8994->accdet_lock);
-
 	snd_soc_update_bits(codec, WM8958_MIC_DETECT_1, WM8958_MICD_ENA, 0);
 
 	wm1811_jackdet_set_mode(codec, WM1811_JACKDET_MODE_JACK);
 
-	mutex_unlock(&wm8994->accdet_lock);
-
 	if (wm8994->wm8994->pdata.jd_ext_cap)
 		snd_soc_dapm_disable_pin(&codec->dapm,
 					 "MICBIAS2");
@@ -3560,10 +3557,10 @@ static void wm8958_open_circuit_work(struct work_struct *work)
 						  open_circuit_work.work);
 	struct device *dev = wm8994->wm8994->dev;
 
-	wm1811_micd_stop(wm8994->hubs.codec);
-
 	mutex_lock(&wm8994->accdet_lock);
 
+	wm1811_micd_stop(wm8994->hubs.codec);
+
 	dev_dbg(dev, "Reporting open circuit\n");
 
 	wm8994->jack_mic = false;
-- 
1.7.9.5
