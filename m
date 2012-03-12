From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3.4 1/2] ASoC: wm8994: Prevent ABBA deadlock
	with CODEC and accdet mutexes
Date: Mon, 12 Mar 2012 17:06:46 +0000
Message-ID: <1331572007-32234-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2165124422
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 18:06:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently we can the accdet mutex from within DAPM when updating the device
state which means we take accdet then the CODEC mutex but we also do the
locking the other way around when responding to the jackdet IRQ. Move all
the jackdet use of the CODEC mutex out of the accdet lock to avoid this.
Since all the DAPM interactions depend only on a single threaded IRQ this
is still serialised.

The locking improvements in 3.5 allow a better solution there.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   50 +++++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1a967d9..ac0cd4b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3193,6 +3193,7 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 	struct wm8994_priv *wm8994 = data;
 	struct snd_soc_codec *codec = wm8994->codec;
 	int reg;
+	bool present;
 
 	mutex_lock(&wm8994->accdet_lock);
 
@@ -3205,11 +3206,10 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 
 	dev_dbg(codec->dev, "JACKDET %x\n", reg);
 
-	if (reg & WM1811_JACKDET_LVL) {
-		dev_dbg(codec->dev, "Jack detected\n");
+	present = reg & WM1811_JACKDET_LVL;
 
-		snd_soc_jack_report(wm8994->micdet[0].jack,
-				    SND_JACK_MECHANICAL, SND_JACK_MECHANICAL);
+	if (present) {
+		dev_dbg(codec->dev, "Jack detected\n");
 
 		snd_soc_update_bits(codec, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, 0);
@@ -3227,32 +3227,12 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, WM8958_MICD_ENA);
-
-		/* If required for an external cap force MICBIAS on */
-		if (wm8994->pdata->jd_ext_cap) {
-			mutex_lock(&codec->mutex);
-			snd_soc_dapm_force_enable_pin(&codec->dapm,
-						      "MICBIAS2");
-			snd_soc_dapm_sync(&codec->dapm);
-			mutex_unlock(&codec->mutex);
-		}
 	} else {
 		dev_dbg(codec->dev, "Jack not detected\n");
 
 		snd_soc_update_bits(codec, WM8958_MICBIAS2,
 				    WM8958_MICB2_DISCH, WM8958_MICB2_DISCH);
 
-		if (wm8994->pdata->jd_ext_cap) {
-			mutex_lock(&codec->mutex);
-			snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS2");
-			snd_soc_dapm_sync(&codec->dapm);
-			mutex_unlock(&codec->mutex);
-		}
-
-		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
-				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
-				    wm8994->btn_mask);
-
 		/* Enable debounce while removed */
 		snd_soc_update_bits(codec, WM1811_JACKDET_CTRL,
 				    WM1811_JACKDET_DB, WM1811_JACKDET_DB);
@@ -3266,6 +3246,28 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 
 	mutex_unlock(&wm8994->accdet_lock);
 
+	/* If required for an external cap force MICBIAS on */
+	if (wm8994->pdata->jd_ext_cap) {
+		mutex_lock(&codec->mutex);
+
+		if (present)
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+						      "MICBIAS2");
+		else
+			snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS2");
+
+		snd_soc_dapm_sync(&codec->dapm);
+		mutex_unlock(&codec->mutex);
+	}
+
+	if (present)
+		snd_soc_jack_report(wm8994->micdet[0].jack,
+				    SND_JACK_MECHANICAL, SND_JACK_MECHANICAL);
+	else
+		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
+				    SND_JACK_MECHANICAL | SND_JACK_HEADSET |
+				    wm8994->btn_mask);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.9.1
