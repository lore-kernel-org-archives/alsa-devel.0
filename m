From: Petr Kulhavy <brain@jikos.cz>
Subject: [PATCH v2] ASoC: tas571x: add input channel mixer for
	TAS5717/19
Date: Wed,  1 Jun 2016 09:30:00 +0200
Message-ID: <1464766200-21707-1-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep27.mx.upcmail.net (fep27.mx.upcmail.net [62.179.121.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 162A62652D7
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 09:30:07 +0200 (CEST)
Received: from edge04.upcmail.net ([192.168.13.239]) by viefep27-int.chello.at
 (InterMail vM.8.01.05.21 201-2260-151-156-20141103) with ESMTP
 id <20160601073006.BRCP3922.viefep27-int.chello.at@edge04.upcmail.net>
 for <alsa-devel@alsa-project.org>; Wed, 1 Jun 2016 09:30:06 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, cernekee@chromium.org, Petr Kulhavy <brain@jikos.cz>
List-Id: alsa-devel@alsa-project.org

Add channel 1 and 2 input mixer registers and the related ALSA mixer
controls for TAS5717/19 chips.

The mixer control coefficients on the chip are linear in the range
-3.99999 to +3.99999, encoded in 3.23 number format.
In this patch the mixer controls are limited to 128 values
from 0.0 to 1.0 in 1/64 steps.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
---
v1: initial
v2: re-apply on topics/tas571x

 sound/soc/codecs/tas571x.c | 18 ++++++++++++++++++
 sound/soc/codecs/tas571x.h |  5 +++++
 2 files changed, 23 insertions(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index bc1fbaf..d8baca3 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -64,6 +64,10 @@ static int tas571x_register_size(struct tas571x_private *priv, unsigned int reg)
 	case TAS571X_INPUT_MUX_REG:
 	case TAS571X_CH4_SRC_SELECT_REG:
 	case TAS571X_PWM_MUX_REG:
+	case TAS5717_CH1_RIGHT_CH_MIX_REG:
+	case TAS5717_CH1_LEFT_CH_MIX_REG:
+	case TAS5717_CH2_LEFT_CH_MIX_REG:
+	case TAS5717_CH2_RIGHT_CH_MIX_REG:
 		return 4;
 	default:
 		return 1;
@@ -397,6 +401,16 @@ static const struct snd_kcontrol_new tas5711_controls[] = {
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
 
 static const struct regmap_range tas571x_readonly_regs_range[] = {
@@ -520,6 +534,10 @@ static const struct reg_default tas5717_reg_defaults[] = {
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
index bf4d436..c45677b 100644
--- a/sound/soc/codecs/tas571x.h
+++ b/sound/soc/codecs/tas571x.h
@@ -87,4 +87,9 @@
 #define TAS5717_CH3_BQ0_REG		0x5e
 #define TAS5717_CH3_BQ1_REG		0x5f
 
+#define TAS5717_CH1_RIGHT_CH_MIX_REG	0x72
+#define TAS5717_CH1_LEFT_CH_MIX_REG	0x73
+#define TAS5717_CH2_LEFT_CH_MIX_REG	0x76
+#define TAS5717_CH2_RIGHT_CH_MIX_REG	0x77
+
 #endif /* _TAS571X_H */
-- 
2.5.0
