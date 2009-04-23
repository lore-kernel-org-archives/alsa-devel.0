From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/21] ASoC: Use DAPM supply widget for WM8903
	charge pump
Date: Thu, 23 Apr 2009 20:55:43 +0100
Message-ID: <1240516555-22249-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B2161038B2
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:07 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   53 +++++++++++++++++----------------------------
 1 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index c539184..a3a489d 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -217,7 +217,6 @@ struct wm8903_priv {
 	int sysclk;
 
 	/* Reference counts */
-	int charge_pump_users;
 	int class_w_users;
 	int playback_active;
 	int capture_active;
@@ -373,6 +372,15 @@ static void wm8903_reset(struct snd_soc_codec *codec)
 #define WM8903_OUTPUT_INT   0x2
 #define WM8903_OUTPUT_IN    0x1
 
+static int wm8903_cp_event(struct snd_soc_dapm_widget *w,
+			   struct snd_kcontrol *kcontrol, int event)
+{
+	WARN_ON(event != SND_SOC_DAPM_POST_PMU);
+	mdelay(4);
+
+	return 0;
+}
+
 /*
  * Event for headphone and line out amplifier power changes.  Special
  * power up/down sequences are required in order to maximise pop/click
@@ -382,12 +390,9 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 			       struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	struct wm8903_priv *wm8903 = codec->private_data;
-	struct i2c_client *i2c = codec->control_data;
 	u16 val;
 	u16 reg;
 	int shift;
-	u16 cp_reg = wm8903_read(codec, WM8903_CHARGE_PUMP_0);
 
 	switch (w->reg) {
 	case WM8903_POWER_MANAGEMENT_2:
@@ -419,18 +424,6 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 		/* Short the output */
 		val &= ~(WM8903_OUTPUT_SHORT << shift);
 		wm8903_write(codec, reg, val);
-
-		wm8903->charge_pump_users++;
-
-		dev_dbg(&i2c->dev, "Charge pump use count now %d\n",
-			wm8903->charge_pump_users);
-
-		if (wm8903->charge_pump_users == 1) {
-			dev_dbg(&i2c->dev, "Enabling charge pump\n");
-			wm8903_write(codec, WM8903_CHARGE_PUMP_0,
-				     cp_reg | WM8903_CP_ENA);
-			mdelay(4);
-		}
 	}
 
 	if (event & SND_SOC_DAPM_POST_PMU) {
@@ -464,19 +457,6 @@ static int wm8903_output_event(struct snd_soc_dapm_widget *w,
 		wm8903_write(codec, reg, val);
 	}
 
-	if (event & SND_SOC_DAPM_POST_PMD) {
-		wm8903->charge_pump_users--;
-
-		dev_dbg(&i2c->dev, "Charge pump use count now %d\n",
-			wm8903->charge_pump_users);
-
-		if (wm8903->charge_pump_users == 0) {
-			dev_dbg(&i2c->dev, "Disabling charge pump\n");
-			wm8903_write(codec, WM8903_CHARGE_PUMP_0,
-				     cp_reg & ~WM8903_CP_ENA);
-		}
-	}
-
 	return 0;
 }
 
@@ -844,26 +824,28 @@ SND_SOC_DAPM_MIXER("Right Speaker Mixer", WM8903_POWER_MANAGEMENT_4, 0, 0,
 SND_SOC_DAPM_PGA_E("Left Headphone Output PGA", WM8903_POWER_MANAGEMENT_2,
 		   1, 0, NULL, 0, wm8903_output_event,
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+		   SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_PGA_E("Right Headphone Output PGA", WM8903_POWER_MANAGEMENT_2,
 		   0, 0, NULL, 0, wm8903_output_event,
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+		   SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_PGA_E("Left Line Output PGA", WM8903_POWER_MANAGEMENT_3, 1, 0,
 		   NULL, 0, wm8903_output_event,
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+		   SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_PGA_E("Right Line Output PGA", WM8903_POWER_MANAGEMENT_3, 0, 0,
 		   NULL, 0, wm8903_output_event,
 		   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
-		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+		   SND_SOC_DAPM_PRE_PMD),
 
 SND_SOC_DAPM_PGA("Left Speaker PGA", WM8903_POWER_MANAGEMENT_5, 1, 0,
 		 NULL, 0),
 SND_SOC_DAPM_PGA("Right Speaker PGA", WM8903_POWER_MANAGEMENT_5, 0, 0,
 		 NULL, 0),
 
+SND_SOC_DAPM_SUPPLY("Charge Pump", WM8903_CHARGE_PUMP_0, 0, 0,
+		    wm8903_cp_event, SND_SOC_DAPM_POST_PMU),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
@@ -951,6 +933,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 	{ "ROP", NULL, "Right Speaker PGA" },
 	{ "RON", NULL, "Right Speaker PGA" },
+
+	{ "Left Headphone Output PGA", NULL, "Charge Pump" },
+	{ "Right Headphone Output PGA", NULL, "Charge Pump" },
+	{ "Left Line Output PGA", NULL, "Charge Pump" },
+	{ "Right Line Output PGA", NULL, "Charge Pump" },
 };
 
 static int wm8903_add_widgets(struct snd_soc_codec *codec)
-- 
1.5.6.3
