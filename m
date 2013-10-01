From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] ASoC: tas5086: move two variables into
	private struct
Date: Tue,  1 Oct 2013 14:48:24 +0200
Message-ID: <1380631706-19365-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id C83E7264F07
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 14:48:32 +0200 (CEST)
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
Cc: broonie@kernel.org, s.neumann@raumfeld.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

We need to access the charge_period and start_mid_z values from other
places later, so move them to the private struct.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 6d31d88..31b5868 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -244,6 +244,8 @@ struct tas5086_private {
 	unsigned int	mclk, sclk;
 	unsigned int	format;
 	bool		deemph;
+	unsigned int	charge_period;
+	unsigned int	pwm_start_mid_z;
 	/* Current sample rate for de-emphasis control */
 	int		rate;
 	/* GPIO driving Reset pin, if any */
@@ -720,13 +722,15 @@ static const int tas5086_charge_period[] = {
 static int tas5086_probe(struct snd_soc_codec *codec)
 {
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
-	int charge_period = 1300000; /* hardware default is 1300 ms */
-	u8 pwm_start_mid_z = 0;
 	int i, ret;
 
+	priv->pwm_start_mid_z = 0;
+	priv->charge_period = 1300000; /* hardware default is 1300 ms */
+
 	if (of_match_device(of_match_ptr(tas5086_dt_ids), codec->dev)) {
 		struct device_node *of_node = codec->dev->of_node;
-		of_property_read_u32(of_node, "ti,charge-period", &charge_period);
+		of_property_read_u32(of_node, "ti,charge-period",
+				     &priv->charge_period);
 
 		for (i = 0; i < 6; i++) {
 			char name[25];
@@ -735,7 +739,7 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 				 "ti,mid-z-channel-%d", i + 1);
 
 			if (of_get_property(of_node, name, NULL) != NULL)
-				pwm_start_mid_z |= 1 << i;
+				priv->pwm_start_mid_z |= 1 << i;
 		}
 	}
 
@@ -744,25 +748,25 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 	 * configure 'part 1' of the PWM starts to use Mid-Z, and tell
 	 * all configured mid-z channels to start start under 'part 1'.
 	 */
-	if (pwm_start_mid_z)
+	if (priv->pwm_start_mid_z)
 		regmap_write(priv->regmap, TAS5086_PWM_START,
 			     TAS5086_PWM_START_MIDZ_FOR_START_1 |
-				pwm_start_mid_z);
+				priv->pwm_start_mid_z);
 
 	/* lookup and set split-capacitor charge period */
-	if (charge_period == 0) {
+	if (priv->charge_period == 0) {
 		regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE, 0);
 	} else {
 		i = index_in_array(tas5086_charge_period,
 				   ARRAY_SIZE(tas5086_charge_period),
-				   charge_period);
+				   priv->charge_period);
 		if (i >= 0)
 			regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE,
 				     i + 0x08);
 		else
 			dev_warn(codec->dev,
 				 "Invalid split-cap charge period of %d ns.\n",
-				 charge_period);
+				 priv->charge_period);
 	}
 
 	/* enable factory trim */
-- 
1.8.3.1
