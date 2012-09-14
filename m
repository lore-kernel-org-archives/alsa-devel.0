From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Avoid recalculating the bitmask for
	SOC_ENUM controls
Date: Fri, 14 Sep 2012 13:57:27 +0200
Message-ID: <1347623847-25287-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-028.synserver.de (smtp-out-028.synserver.de
 [212.40.185.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 17A3E265D12
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 13:57:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

For ENUM controls the bitmask is calculated based on the number of items.
Currently this is done each time the control is accessed. And while the
performance impact of this should be negligible we can easily do better. The
roundup_pow_of_two macro performs the same calculation which is currently done
manually, but it is also possible to use this macro with compile time constants
and so it can be used to initialize static data. So we can use it to initialize
the mask field of a ENUM control during its declaration.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h        |    4 +++-
 sound/soc/codecs/twl4030.c |    8 +++-----
 sound/soc/soc-core.c       |   16 ++++++----------
 sound/soc/soc-dapm.c       |   22 ++++++++--------------
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 313b766..91244a0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/regmap.h>
+#include <linux/log2.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/compress_driver.h>
@@ -160,7 +161,8 @@
 		 .platform_max = xmax} }
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmax, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
-	.max = xmax, .texts = xtexts }
+	.max = xmax, .texts = xtexts, \
+	.mask = xmax ? roundup_pow_of_two(xmax) - 1 : 0}
 #define SOC_ENUM_SINGLE(xreg, xshift, xmax, xtexts) \
 	SOC_ENUM_DOUBLE(xreg, xshift, xshift, xmax, xtexts)
 #define SOC_ENUM_SINGLE_EXT(xmax, xtexts) \
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 391fcfc..2548f5c 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -999,7 +999,7 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned short val;
-	unsigned short mask, bitmask;
+	unsigned short mask;
 
 	if (twl4030->configured) {
 		dev_err(codec->dev,
@@ -1007,18 +1007,16 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 		return -EBUSY;
 	}
 
-	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
-		;
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
 
 	val = ucontrol->value.enumerated.item[0] << e->shift_l;
-	mask = (bitmask - 1) << e->shift_l;
+	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
 		if (ucontrol->value.enumerated.item[1] > e->max - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
-		mask |= (bitmask - 1) << e->shift_r;
+		mask |= e->mask << e->shift_r;
 	}
 
 	return snd_soc_update_bits(codec, e->reg, mask, val);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e5b0713..9a6daf9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2413,16 +2413,14 @@ int snd_soc_get_enum_double(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val, bitmask;
+	unsigned int val;
 
-	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
-		;
 	val = snd_soc_read(codec, e->reg);
 	ucontrol->value.enumerated.item[0]
-		= (val >> e->shift_l) & (bitmask - 1);
+		= (val >> e->shift_l) & e->mask;
 	if (e->shift_l != e->shift_r)
 		ucontrol->value.enumerated.item[1] =
-			(val >> e->shift_r) & (bitmask - 1);
+			(val >> e->shift_r) & e->mask;
 
 	return 0;
 }
@@ -2443,19 +2441,17 @@ int snd_soc_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val;
-	unsigned int mask, bitmask;
+	unsigned int mask;
 
-	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
-		;
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
 	val = ucontrol->value.enumerated.item[0] << e->shift_l;
-	mask = (bitmask - 1) << e->shift_l;
+	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
 		if (ucontrol->value.enumerated.item[1] > e->max - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
-		mask |= (bitmask - 1) << e->shift_r;
+		mask |= e->mask << e->shift_r;
 	}
 
 	return snd_soc_update_bits_locked(codec, e->reg, mask, val);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3b8ddb4..873e6e7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -358,12 +358,10 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_mux: {
 		struct soc_enum *e = (struct soc_enum *)
 			w->kcontrol_news[i].private_value;
-		int val, item, bitmask;
+		int val, item;
 
-		for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
-			;
 		val = soc_widget_read(w, e->reg);
-		item = (val >> e->shift_l) & (bitmask - 1);
+		item = (val >> e->shift_l) & e->mask;
 
 		p->connect = 0;
 		for (i = 0; i < e->max; i++) {
@@ -2680,15 +2678,13 @@ int snd_soc_dapm_get_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	unsigned int val, bitmask;
+	unsigned int val;
 
-	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
-		;
 	val = snd_soc_read(widget->codec, e->reg);
-	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & (bitmask - 1);
+	ucontrol->value.enumerated.item[0] = (val >> e->shift_l) & e->mask;
 	if (e->shift_l != e->shift_r)
 		ucontrol->value.enumerated.item[1] =
-			(val >> e->shift_r) & (bitmask - 1);
+			(val >> e->shift_r) & e->mask;
 
 	return 0;
 }
@@ -2712,22 +2708,20 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_soc_card *card = codec->card;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, mux, change;
-	unsigned int mask, bitmask;
+	unsigned int mask;
 	struct snd_soc_dapm_update update;
 	int wi;
 
-	for (bitmask = 1; bitmask < e->max; bitmask <<= 1)
-		;
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
 	mux = ucontrol->value.enumerated.item[0];
 	val = mux << e->shift_l;
-	mask = (bitmask - 1) << e->shift_l;
+	mask = e->mask << e->shift_l;
 	if (e->shift_l != e->shift_r) {
 		if (ucontrol->value.enumerated.item[1] > e->max - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
-		mask |= (bitmask - 1) << e->shift_r;
+		mask |= e->mask << e->shift_r;
 	}
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-- 
1.7.10.4
