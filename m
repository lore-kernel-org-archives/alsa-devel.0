From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH] ASoC: tas571x: add input channel mixer for
	TAS5717/19
Date: Mon, 23 May 2016 23:12:47 +0200
Message-ID: <1464037967-24671-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep18.mx.upcmail.net (fep18.mx.upcmail.net [62.179.121.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 951F1266C27
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 23:13:52 +0200 (CEST)
Received: from edge03.upcmail.net ([192.168.13.238]) by viefep18-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20160523211352.HRRC24796.viefep18-int.chello.at@edge03.upcmail.net>
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 23:13:52 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

Add channel 1 and 2 input mixer registers and the related ALSA mixer
controls for TAS5717/19 chips.

The mixer control coefficients on the chip are linear in the range
-3.99999 to +3.99999, encoded in 3.23 number format.
In this patch the mixer controls are limited to 128 values
from 0.0 to 1.0 in 1/64 steps.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
 sound/soc/codecs/tas571x.c | 19 +++++++++++++++++++
 sound/soc/codecs/tas571x.h |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 39307ad..bca0e84 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -57,6 +57,11 @@ static int tas571x_register_size(struct tas571x_private *priv, unsigned int reg)
 	case TAS571X_CH1_VOL_REG:
 	case TAS571X_CH2_VOL_REG:
 		return priv->chip->vol_reg_size;
+	case TAS5717_CH1_RIGHT_CH_MIX_REG:
+	case TAS5717_CH1_LEFT_CH_MIX_REG:
+	case TAS5717_CH2_LEFT_CH_MIX_REG:
+	case TAS5717_CH2_RIGHT_CH_MIX_REG:
+		return 4;
 	default:
 		return 1;
 	}
@@ -293,6 +298,16 @@ static const struct snd_kcontrol_new tas5717_controls[] = {
 		   TAS571X_SOFT_MUTE_REG,
 		   TAS571X_SOFT_MUTE_CH1_SHIFT, TAS571X_SOFT_MUTE_CH2_SHIFT,
 		   1, 1),
+
+	SOC_DOUBLE_R_RANGE("CH1 Mixer Volume",
+			   TAS5717_CH1_LEFT_CH_MIX_REG,
+			   TAS5717_CH1_RIGHT_CH_MIX_REG,
+			   16, 0, 0x80, 0),
+
+	SOC_DOUBLE_R_RANGE("CH2 Mixer Volume",
+			   TAS5717_CH2_LEFT_CH_MIX_REG,
+			   TAS5717_CH2_RIGHT_CH_MIX_REG,
+			   16, 0, 0x80, 0),
 };
 
 static const struct reg_default tas5717_reg_defaults[] = {
@@ -303,6 +318,10 @@ static const struct reg_default tas5717_reg_defaults[] = {
 	{ 0x08, 0x00c0 },
 	{ 0x09, 0x00c0 },
 	{ 0x1b, 0x82 },
+	{ TAS5717_CH1_RIGHT_CH_MIX_REG, 0x0 },
+	{ TAS5717_CH1_LEFT_CH_MIX_REG, 0x800000},
+	{ TAS5717_CH2_LEFT_CH_MIX_REG, 0x0 },
+	{ TAS5717_CH2_RIGHT_CH_MIX_REG, 0x800000},
 };
 
 static const struct regmap_config tas5717_regmap_config = {
diff --git a/sound/soc/codecs/tas571x.h b/sound/soc/codecs/tas571x.h
index 0aee471..b4175d6 100644
--- a/sound/soc/codecs/tas571x.h
+++ b/sound/soc/codecs/tas571x.h
@@ -30,4 +30,9 @@
 
 #define TAS571X_OSC_TRIM_REG		0x1b
 
+#define TAS5717_CH1_RIGHT_CH_MIX_REG	0x72
+#define TAS5717_CH1_LEFT_CH_MIX_REG	0x73
+#define TAS5717_CH2_LEFT_CH_MIX_REG	0x76
+#define TAS5717_CH2_RIGHT_CH_MIX_REG	0x77
+
 #endif /* _TAS571X_H */
-- 
2.5.0
