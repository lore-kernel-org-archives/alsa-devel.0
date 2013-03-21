From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2 resend] ASoC: cs4271: preserve "Master
	Playback Switch" setting
Date: Thu, 21 Mar 2013 20:43:55 +0100
Message-ID: <1363895035-20356-2-git-send-email-zonque@gmail.com>
References: <1363895035-20356-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 91DAF26604C
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 20:44:03 +0100 (CET)
In-Reply-To: <1363895035-20356-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@opensource.wolfsonmicro.com, subaparts@yandex.ru, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Currently, both the ALSA control for "Digital Master Playback Switch"
and the ALSA core (by calling dai_ops->mute_stream()) control the same
bits in the CS4271_VOL[AB]_MUTE registers.

That's a problem for applications which intentionally want to keep the
flag switched off from userspace, even though the stream is already
playing.

Fix this by keeping track of the states on both sides - the ALSA
control and the ASoC core - and actually mute the Codec if either one
of the two flags is set.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Michael Hirsch <m.hirsch@raumfeld.com>
Acked-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/codecs/cs4271.c | 74 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 03036b3..3a2ab48 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -171,6 +171,9 @@ struct cs4271_private {
 	int				gpio_disable;
 	/* enable soft reset workaround */
 	bool				enable_soft_reset;
+	/* keep track of playback mute flags */
+	bool				mute_control;
+	bool				digital_mute;
 };
 
 /*
@@ -281,6 +284,51 @@ static int cs4271_put_deemph(struct snd_kcontrol *kcontrol,
 	return cs4271_set_deemph(codec);
 }
 
+static int cs4271_set_mute(struct snd_soc_codec *codec)
+{
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+	int val_a = 0;
+	int val_b = 0;
+	int ret;
+
+	if (cs4271->digital_mute || cs4271->mute_control) {
+		val_a = CS4271_VOLA_MUTE;
+		val_b = CS4271_VOLB_MUTE;
+	}
+
+	ret = regmap_update_bits(cs4271->regmap, CS4271_VOLA,
+				 CS4271_VOLA_MUTE, val_a);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(cs4271->regmap, CS4271_VOLB,
+				 CS4271_VOLB_MUTE, val_b);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cs4271_get_playback_switch(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
+	ucontrol->value.enumerated.item[0] = !cs4271->mute_control;
+	return 0;
+}
+
+static int cs4271_put_playback_switch(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
+
+	cs4271->mute_control = !ucontrol->value.enumerated.item[0];
+	return cs4271_set_mute(codec);
+}
+
 struct cs4271_clk_cfg {
 	bool		master;		/* codec mode */
 	u8		speed_mode;	/* codec speed mode: 1x, 2x, 4x */
@@ -392,28 +440,12 @@ static int cs4271_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
-	int ret;
-	int val_a = 0;
-	int val_b = 0;
 
-	if (stream != SNDRV_PCM_STREAM_PLAYBACK)
-		return 0;
-
-	if (mute) {
-		val_a = CS4271_VOLA_MUTE;
-		val_b = CS4271_VOLB_MUTE;
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		cs4271->digital_mute = mute;
+		return cs4271_set_mute(codec);
 	}
 
-	ret = regmap_update_bits(cs4271->regmap, CS4271_VOLA,
-				 CS4271_VOLA_MUTE, val_a);
-	if (ret < 0)
-		return ret;
-
-	ret = regmap_update_bits(cs4271->regmap, CS4271_VOLB,
-				 CS4271_VOLB_MUTE, val_b);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -437,8 +469,8 @@ static const struct snd_kcontrol_new cs4271_snd_controls[] = {
 	SOC_DOUBLE("Master Capture Switch", CS4271_ADCCTL, 3, 2, 1, 1),
 	SOC_SINGLE("Dither 16-Bit Data Switch", CS4271_ADCCTL, 5, 1, 0),
 	SOC_DOUBLE("High Pass Filter Switch", CS4271_ADCCTL, 1, 0, 1, 1),
-	SOC_DOUBLE_R("Master Playback Switch", CS4271_VOLA, CS4271_VOLB,
-		7, 1, 1),
+	SOC_SINGLE_BOOL_EXT("Master Playback Switch", 0,
+		cs4271_get_playback_switch, cs4271_put_playback_switch),
 };
 
 static const struct snd_soc_dai_ops cs4271_dai_ops = {
-- 
1.8.1.4
