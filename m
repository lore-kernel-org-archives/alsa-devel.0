From: Yizhuo <yzhai003@ucr.edu>
Subject: [PATCH] ASoC: rt298: Variable "val" and "buf" in rt298_jack_detect() could be uninitialized
Date: Fri,  4 Jan 2019 13:52:53 -0800
Message-ID: <20190104215253.16278-1-yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In function rt298_jack_detect(), local variable "val" and "buf"
are supposed to get initialized by regmap_read(). However, they
 could be leave uninitialized if regmap_read() returns -EINVAL.
Those two variables are used in control flow or update the argument,
which could lead to undefined behavior and thus unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 sound/soc/codecs/rt298.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index ce963768449f..7f74349c17f3 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -223,6 +223,7 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 {
 	struct snd_soc_dapm_context *dapm;
 	unsigned int val, buf;
+	int ret = 0;
 
 	*hp = false;
 	*mic = false;
@@ -233,7 +234,10 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 	dapm = snd_soc_codec_get_dapm(rt298->codec);
 
 	if (rt298->pdata.cbj_en) {
-		regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		ret = regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		if (ret)
+			return ret;
+
 		*hp = buf & 0x80000000;
 		if (*hp == rt298->is_hp_in)
 			return -1;
@@ -260,16 +264,19 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 			regmap_update_bits(rt298->regmap,
 				RT298_CBJ_CTRL1, 0xfcc0, 0xd400);
 			msleep(300);
-			regmap_read(rt298->regmap, RT298_CBJ_CTRL2, &val);
-
+			ret = regmap_read(rt298->regmap, RT298_CBJ_CTRL2, &val);
+			if (ret)
+				return ret;
 			if (0x0070 == (val & 0x0070)) {
 				*mic = true;
 			} else {
 				regmap_update_bits(rt298->regmap,
 					RT298_CBJ_CTRL1, 0xfcc0, 0xe400);
 				msleep(300);
-				regmap_read(rt298->regmap,
+				ret = regmap_read(rt298->regmap,
 					RT298_CBJ_CTRL2, &val);
+				if (ret)
+					return ret;
 				if (0x0070 == (val & 0x0070))
 					*mic = true;
 				else
@@ -285,9 +292,14 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 				RT298_CBJ_CTRL1, 0x0400, 0x0000);
 		}
 	} else {
-		regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		ret = regmap_read(rt298->regmap, RT298_GET_HP_SENSE, &buf);
+		if (ret)
+			return ret;
+
 		*hp = buf & 0x80000000;
-		regmap_read(rt298->regmap, RT298_GET_MIC1_SENSE, &buf);
+		ret = regmap_read(rt298->regmap, RT298_GET_MIC1_SENSE, &buf);
+		if (ret)
+			return ret;
 		*mic = buf & 0x80000000;
 	}
 
-- 
2.17.1
