From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: rt286: Replace direct snd_soc_codec
	dapm field access
Date: Tue, 19 May 2015 21:49:06 +0200
Message-ID: <1432064952-31997-2-git-send-email-lars@metafoo.de>
References: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A6BA26058B
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 21:49:20 +0200 (CEST)
In-Reply-To: <1432064952-31997-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level() and replace all
other manual access to codec->dapm with snd_soc_codec_get_dapm().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt286.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index dbdbb9e..c6cca06 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -301,6 +301,7 @@ static int rt286_support_power_controls[] = {
 
 static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 {
+	struct snd_soc_dapm_context *dapm;
 	unsigned int val, buf;
 
 	*hp = false;
@@ -308,6 +309,9 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 
 	if (!rt286->codec)
 		return -EINVAL;
+
+	dapm = snd_soc_codec_get_dapm(rt286->codec);
+
 	if (rt286->pdata.cbj_en) {
 		regmap_read(rt286->regmap, RT286_GET_HP_SENSE, &buf);
 		*hp = buf & 0x80000000;
@@ -316,14 +320,11 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 			regmap_update_bits(rt286->regmap,
 				RT286_DC_GAIN, 0x200, 0x200);
 
-			snd_soc_dapm_force_enable_pin(&rt286->codec->dapm,
-							"HV");
-			snd_soc_dapm_force_enable_pin(&rt286->codec->dapm,
-							"VREF");
+			snd_soc_dapm_force_enable_pin(dapm, "HV");
+			snd_soc_dapm_force_enable_pin(dapm, "VREF");
 			/* power LDO1 */
-			snd_soc_dapm_force_enable_pin(&rt286->codec->dapm,
-							"LDO1");
-			snd_soc_dapm_sync(&rt286->codec->dapm);
+			snd_soc_dapm_force_enable_pin(dapm, "LDO1");
+			snd_soc_dapm_sync(dapm);
 
 			regmap_write(rt286->regmap, RT286_SET_MIC1, 0x24);
 			msleep(50);
@@ -360,11 +361,11 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 		*mic = buf & 0x80000000;
 	}
 
-	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "HV");
-	snd_soc_dapm_disable_pin(&rt286->codec->dapm, "VREF");
+	snd_soc_dapm_disable_pin(dapm, "HV");
+	snd_soc_dapm_disable_pin(dapm, "VREF");
 	if (!*hp)
-		snd_soc_dapm_disable_pin(&rt286->codec->dapm, "LDO1");
-	snd_soc_dapm_sync(&rt286->codec->dapm);
+		snd_soc_dapm_disable_pin(dapm, "LDO1");
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
@@ -391,6 +392,7 @@ static void rt286_jack_detect_work(struct work_struct *work)
 
 int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
 
 	rt286->jack = jack;
@@ -398,7 +400,7 @@ int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	if (jack) {
 		/* enable IRQ */
 		if (rt286->jack->status & SND_JACK_HEADPHONE)
-			snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO1");
+			snd_soc_dapm_force_enable_pin(dapm, "LDO1");
 		regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x2, 0x2);
 		/* Send an initial empty report */
 		snd_soc_jack_report(rt286->jack, rt286->jack->status,
@@ -406,9 +408,9 @@ int rt286_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	} else {
 		/* disable IRQ */
 		regmap_update_bits(rt286->regmap, RT286_IRQ_CTRL, 0x2, 0x0);
-		snd_soc_dapm_disable_pin(&codec->dapm, "LDO1");
+		snd_soc_dapm_disable_pin(dapm, "LDO1");
 	}
-	snd_soc_dapm_sync(&codec->dapm);
+	snd_soc_dapm_sync(dapm);
 
 	return 0;
 }
@@ -985,7 +987,7 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
+		if (SND_SOC_BIAS_STANDBY == snd_soc_codec_get_bias_level(codec)) {
 			snd_soc_write(codec,
 				RT286_SET_AUDIO_POWER, AC_PWRST_D0);
 			snd_soc_update_bits(codec,
-- 
1.8.0
