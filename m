From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: RT286: Fix silent at the beginning of
	stream
Date: Mon, 7 Jul 2014 19:15:30 +0800
Message-ID: <1404731730-21364-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 730E026516B
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 13:15:55 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch fix the issue that the output is almost silent at the
beginning of starting a playback.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 20 +++++++++++++++++++-
 sound/soc/codecs/rt286.h |  5 +++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index e6f33ab..8103315 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -54,6 +54,7 @@ static struct reg_default rt286_index_def[] = {
 	{ 0x09, 0xd810 },
 	{ 0x0a, 0x0060 },
 	{ 0x0b, 0x0000 },
+	{ 0x0d, 0x2800 },
 	{ 0x0f, 0x0000 },
 	{ 0x19, 0x0a17 },
 	{ 0x20, 0x0020 },
@@ -62,6 +63,9 @@ static struct reg_default rt286_index_def[] = {
 	{ 0x4f, 0x50e9 },
 	{ 0x50, 0x2c00 },
 	{ 0x63, 0x2902 },
+	{ 0x67, 0x1111 },
+	{ 0x68, 0x1016 },
+	{ 0x69, 0x273f },
 };
 #define INDEX_CACHE_SIZE ARRAY_SIZE(rt286_index_def)
 
@@ -902,14 +906,23 @@ static int rt286_set_bias_level(struct snd_soc_codec *codec,
 {
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level)
+		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
 			snd_soc_write(codec,
 				RT286_SET_AUDIO_POWER, AC_PWRST_D0);
+			snd_soc_update_bits(codec,
+				RT286_DC_GAIN, 0x200, 0x200);
+		}
+		break;
+
+	case SND_SOC_BIAS_ON:
+		mdelay(10);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		snd_soc_write(codec,
 			RT286_SET_AUDIO_POWER, AC_PWRST_D3);
+		snd_soc_update_bits(codec,
+			RT286_DC_GAIN, 0x200, 0x0);
 		break;
 
 	default:
@@ -1152,6 +1165,11 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	/*Power down LDO2*/
 	regmap_update_bits(rt286->regmap, RT286_POWER_CTRL2, 0x8, 0x0);
 
+	/*Set depop parameter*/
+	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL2, 0x403a, 0x401a);
+	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL3, 0xf777, 0x4737);
+	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL4, 0x00ff, 0x003f);
+
 	if (rt286->i2c->irq) {
 		regmap_update_bits(rt286->regmap,
 					RT286_IRQ_CTRL, 0x2, 0x2);
diff --git a/sound/soc/codecs/rt286.h b/sound/soc/codecs/rt286.h
index 21c570f..b539b73 100644
--- a/sound/soc/codecs/rt286.h
+++ b/sound/soc/codecs/rt286.h
@@ -127,6 +127,7 @@
 #define RT286_I2S_CTRL1		0x09
 #define RT286_I2S_CTRL2		0x0a
 #define RT286_CLK_DIV		0x0b
+#define RT286_DC_GAIN		0x0d
 #define RT286_POWER_CTRL3	0x0f
 #define RT286_MIC1_DET_CTRL	0x19
 #define RT286_MISC_CTRL1	0x20
@@ -135,6 +136,10 @@
 #define RT286_CBJ_CTRL1		0x4f
 #define RT286_CBJ_CTRL2		0x50
 #define RT286_PLL_CTRL		0x63
+#define RT286_DEPOP_CTRL1	0x66
+#define RT286_DEPOP_CTRL2	0x67
+#define RT286_DEPOP_CTRL3	0x68
+#define RT286_DEPOP_CTRL4	0x69
 
 /* SPDIF (0x06) */
 #define RT286_SPDIF_SEL_SFT	0
-- 
1.8.1.1.439.g50a6b54
