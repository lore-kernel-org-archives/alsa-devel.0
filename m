From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] ASoC: wm8753: Integrate capacitor charging
	into the DAPM sequence
Date: Mon, 30 Mar 2015 21:04:48 +0200
Message-ID: <1427742293-8588-4-git-send-email-lars@metafoo.de>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CEC72605A6
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:53 +0200 (CEST)
In-Reply-To: <1427742293-8588-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

When being powered on, either initially on probe or when resuming from
suspend, the wm8971 configures the device for quick output capacitor
charging. Since the charging can take a rather long time (up to multiple
seconds) it is done asynchronously without blocking. A delayed work item is
run once the charging is finished and the device is switched to the target
bias level.

This all done asynchronously to the regular DAPM sequence accessing the same
data structures and registers without any looking, which can lead to race
conditions. Furthermore this potentially delays the start of stream on the
CODEC while the rest of the system is already up and running, meaning the
first bytes of audio are lost. It also does no comply with the assumption of
the DAPM core that if set_bias_level() returned successfully the device will
be at the requested bias level.

This patch slightly refactors things and makes sure that the caps charging
is properly integrated into the DAPM sequence. When transitioning from
SND_SOC_BIAS_OFF to SND_SOC_BIAS_STANDBY the part will be put into fast
charging mode and a work item will be scheduled that puts it back into
standby charging once the charging period has elapsed. If a playback or
capture stream is started while charging is in progress the driver will now
wait in SND_SOC_BIAS_PREPARE until the charging is done. This makes sure
that charging is done asynchronously in the background when the chip is
idle, but at the same time makes sure that playback/capture is not started
before the charging is done.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8753.c | 54 +++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 21ca3a9..176fcb1 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -153,6 +153,7 @@ struct wm8753_priv {
 	unsigned int hifi_fmt;
 
 	int dai_func;
+	struct delayed_work charge_work;
 };
 
 #define wm8753_reset(c) snd_soc_write(c, WM8753_RESET, 0)
@@ -1326,9 +1327,19 @@ static int wm8753_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static void wm8753_charge_work(struct work_struct *work)
+{
+	struct wm8753_priv *wm8753 =
+		container_of(work, struct wm8753_priv, charge_work.work);
+
+	/* Set to 500k */
+	regmap_update_bits(wm8753->regmap, WM8753_PWR1, 0x0180, 0x0100);
+}
+
 static int wm8753_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
+	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 pwr_reg = snd_soc_read(codec, WM8753_PWR1) & 0xfe3e;
 
 	switch (level) {
@@ -1337,14 +1348,22 @@ static int wm8753_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x00c0);
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		/* set vmid to 5k for quick power up */
-		snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x01c1);
+		/* Wait until fully charged */
+		flush_delayed_work(&wm8753->charge_work);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		/* mute dac and set vmid to 500k, enable VREF */
-		snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x0141);
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+			/* set vmid to 5k for quick power up */
+			snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x01c1);
+			schedule_delayed_work(&wm8753->charge_work,
+				msecs_to_jiffies(caps_charge));
+		} else {
+			/* mute dac and set vmid to 500k, enable VREF */
+			snd_soc_write(codec, WM8753_PWR1, pwr_reg | 0x0141);
+		}
 		break;
 	case SND_SOC_BIAS_OFF:
+		cancel_delayed_work_sync(&wm8753->charge_work);
 		snd_soc_write(codec, WM8753_PWR1, 0x0001);
 		break;
 	}
@@ -1428,15 +1447,6 @@ static struct snd_soc_dai_driver wm8753_dai[] = {
 },
 };
 
-static void wm8753_work(struct work_struct *work)
-{
-	struct snd_soc_dapm_context *dapm =
-		container_of(work, struct snd_soc_dapm_context,
-			     delayed_work.work);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	wm8753_set_bias_level(codec, dapm->bias_level);
-}
-
 static int wm8753_suspend(struct snd_soc_codec *codec)
 {
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -1450,16 +1460,6 @@ static int wm8753_resume(struct snd_soc_codec *codec)
 	regcache_sync(wm8753->regmap);
 
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* charge wm8753 caps */
-	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
-		wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
-		codec->dapm.bias_level = SND_SOC_BIAS_ON;
-		queue_delayed_work(system_power_efficient_wq,
-				   &codec->dapm.delayed_work,
-				   msecs_to_jiffies(caps_charge));
-	}
-
 	return 0;
 }
 
@@ -1468,7 +1468,7 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8753_work);
+	INIT_DELAYED_WORK(&wm8753->charge_work, wm8753_charge_work);
 
 	ret = wm8753_reset(codec);
 	if (ret < 0) {
@@ -1479,11 +1479,6 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	wm8753->dai_func = 0;
 
-	/* charge output caps */
-	wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
-	schedule_delayed_work(&codec->dapm.delayed_work,
-			      msecs_to_jiffies(caps_charge));
-
 	/* set the update bits */
 	snd_soc_update_bits(codec, WM8753_LDAC, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8753_RDAC, 0x0100, 0x0100);
@@ -1502,7 +1497,6 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 /* power down chip */
 static int wm8753_remove(struct snd_soc_codec *codec)
 {
-	flush_delayed_work(&codec->dapm.delayed_work);
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
-- 
1.8.0
