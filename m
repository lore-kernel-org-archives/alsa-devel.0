From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ASoC: tas5086: fix Mid-Z implementation
Date: Thu, 27 Jun 2013 21:59:11 +0200
Message-ID: <1372363151-31082-2-git-send-email-zonque@gmail.com>
References: <1372363151-31082-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 35C98265635
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 21:58:42 +0200 (CEST)
In-Reply-To: <1372363151-31082-1-git-send-email-zonque@gmail.com>
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
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

It turns out that the TAS5086 doesn't like channel start parts to be
empty, and if all channels are configured to Mid-Z, part 1 has to be
used.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 84c3f27..3a22741 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -721,7 +721,7 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 {
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 	int charge_period = 1300000; /* hardware default is 1300 ms */
-	u8 pwm_start = TAS5086_PWM_START_CHANNEL_MASK;
+	u8 pwm_start_mid_z = 0;
 	int i, ret;
 
 	if (of_match_device(of_match_ptr(tas5086_dt_ids), codec->dev)) {
@@ -735,16 +735,19 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 				 "ti,mid-z-channel-%d", i + 1);
 
 			if (of_get_property(of_node, name, NULL) != NULL)
-				pwm_start &= ~(1 << i);
+				pwm_start_mid_z |= 1 << i;
 		}
 	}
 
 	/*
-	 * Configure 'part 2' of the PWM starts to always use MID-Z, and tell
-	 * all configured mid-z channels to start start under 'part 2'.
+	 * If any of the channels is configured to start in Mid-Z mode,
+	 * configure 'part 1' of the PWM starts to use Mid-Z, and tell
+	 * all configured mid-z channels to start start under 'part 1'.
 	 */
-	regmap_write(priv->regmap, TAS5086_PWM_START,
-		     TAS5086_PWM_START_MIDZ_FOR_START_2 | pwm_start);
+	if (pwm_start_mid_z)
+		regmap_write(priv->regmap, TAS5086_PWM_START,
+			     TAS5086_PWM_START_MIDZ_FOR_START_1 |
+				pwm_start_mid_z);
 
 	/* lookup and set split-capacitor charge period */
 	if (charge_period == 0) {
-- 
1.8.1.4
