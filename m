From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] ASoC: wm8971: Integrate capacitor charging
	into the DAPM sequence
Date: Mon, 30 Mar 2015 21:04:46 +0200
Message-ID: <1427742293-8588-2-git-send-email-lars@metafoo.de>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 9934F260592
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:50 +0200 (CEST)
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
 sound/soc/codecs/wm8971.c | 71 +++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 44baacd..4ab034d 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -34,6 +34,8 @@
 /* codec private data */
 struct wm8971_priv {
 	unsigned int sysclk;
+	struct delayed_work charge_work;
+	struct regmap *regmap;
 };
 
 /*
@@ -550,9 +552,19 @@ static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 	return 0;
 }
 
+static void wm8971_charge_work(struct work_struct *work)
+{
+	struct wm8971_priv *wm8971 =
+		container_of(work, struct wm8971_priv, charge_work.work);
+
+	/* Set to 500k */
+	regmap_update_bits(wm8971->regmap, WM8971_PWR1, 0x0180, 0x0100);
+}
+
 static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
 
 	switch (level) {
@@ -561,15 +573,24 @@ static int wm8971_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x00c1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
+		/* Wait until fully charged */
+		flush_delayed_work(&wm8971->charge_work);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
+		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
 			snd_soc_cache_sync(codec);
+			/* charge output caps - set vmid to 5k for quick power up */
+			snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x01c0);
+			queue_delayed_work(system_power_efficient_wq,
+				&wm8971->charge_work, msecs_to_jiffies(1000));
+		} else {
+			/* mute dac and set vmid to 500k, enable VREF */
+			snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
+		}
 
-		/* mute dac and set vmid to 500k, enable VREF */
-		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
 		break;
 	case SND_SOC_BIAS_OFF:
+		cancel_delayed_work_sync(&wm8971->charge_work);
 		snd_soc_write(codec, WM8971_PWR1, 0x0001);
 		break;
 	}
@@ -608,15 +629,6 @@ static struct snd_soc_dai_driver wm8971_dai = {
 	.ops = &wm8971_dai_ops,
 };
 
-static void wm8971_work(struct work_struct *work)
-{
-	struct snd_soc_dapm_context *dapm =
-		container_of(work, struct snd_soc_dapm_context,
-			     delayed_work.work);
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	wm8971_set_bias_level(codec, codec->dapm.bias_level);
-}
-
 static int wm8971_suspend(struct snd_soc_codec *codec)
 {
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
@@ -625,39 +637,19 @@ static int wm8971_suspend(struct snd_soc_codec *codec)
 
 static int wm8971_resume(struct snd_soc_codec *codec)
 {
-	u16 reg;
-
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* charge wm8971 caps */
-	if (codec->dapm.suspend_bias_level == SND_SOC_BIAS_ON) {
-		reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
-		snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
-		codec->dapm.bias_level = SND_SOC_BIAS_ON;
-		queue_delayed_work(system_power_efficient_wq,
-			&codec->dapm.delayed_work,
-			msecs_to_jiffies(1000));
-	}
-
 	return 0;
 }
 
 static int wm8971_probe(struct snd_soc_codec *codec)
 {
-	int ret = 0;
-	u16 reg;
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 
-	INIT_DELAYED_WORK(&codec->dapm.delayed_work, wm8971_work);
+	INIT_DELAYED_WORK(&wm8971->charge_work, wm8971_charge_work);
 
 	wm8971_reset(codec);
 
-	/* charge output caps - set vmid to 5k for quick power up */
-	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
-	snd_soc_write(codec, WM8971_PWR1, reg | 0x01c0);
-	codec->dapm.bias_level = SND_SOC_BIAS_STANDBY;
-	queue_delayed_work(system_power_efficient_wq,
-		&codec->dapm.delayed_work,
-		msecs_to_jiffies(1000));
+	wm8971_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* set the update bits */
 	snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
@@ -669,7 +661,7 @@ static int wm8971_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8971_LINVOL, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8971_RINVOL, 0x0100, 0x0100);
 
-	return ret;
+	return 0;
 }
 
 
@@ -710,7 +702,6 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm8971_priv *wm8971;
-	struct regmap *regmap;
 	int ret;
 
 	wm8971 = devm_kzalloc(&i2c->dev, sizeof(struct wm8971_priv),
@@ -718,9 +709,9 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 	if (wm8971 == NULL)
 		return -ENOMEM;
 
-	regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	wm8971->regmap = devm_regmap_init_i2c(i2c, &wm8971_regmap);
+	if (IS_ERR(wm8971->regmap))
+		return PTR_ERR(wm8971->regmap);
 
 	i2c_set_clientdata(i2c, wm8971);
 
-- 
1.8.0
