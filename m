From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH 01/12] ASoC: dapm: Support second register for
 DAPM control updates
Date: Mon,  3 Oct 2016 19:07:53 +0800
Message-ID: <20161003110804.28235-2-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBIHYZC7QKGQEHT6Q3NY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161003110804.28235-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

To support double channel shared controls split across 2 registers, one
for each channel, we must be able to update both registers together.

Add a second set of register fields to struct snd_soc_dapm_update, and
update the DAPM control writeback (put) callbacks to support this.

For codecs that use custom events which call into DAPM to do updates,
also clear struct snd_soc_dapm_update before using it, so the second
set of fields remains clean.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 include/sound/soc-dapm.h       |  4 ++++
 sound/soc/codecs/adau17x1.c    |  2 +-
 sound/soc/codecs/tlv320aic3x.c |  2 +-
 sound/soc/codecs/wm9712.c      |  2 +-
 sound/soc/codecs/wm9713.c      |  2 +-
 sound/soc/soc-dapm.c           | 13 +++++++++++--
 6 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index f60d755f7ac6..d5f4677776ce 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -615,6 +615,10 @@ struct snd_soc_dapm_update {
 	int reg;
 	int mask;
 	int val;
+	int reg2;
+	int mask2;
+	int val2;
+	bool has_second_set;
 };
 
 struct snd_soc_dapm_wcache {
diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 439aa3ff1f99..b36511d965c8 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -160,7 +160,7 @@ static int adau17x1_dsp_mux_enum_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct adau *adau = snd_soc_codec_get_drvdata(codec);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	struct snd_soc_dapm_update update;
+	struct snd_soc_dapm_update update = { 0 };
 	unsigned int stream = e->shift_l;
 	unsigned int val, change;
 	int reg;
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 5a8d96ec058c..8877b74b0510 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -157,7 +157,7 @@ static int snd_soc_dapm_put_volsw_aic3x(struct snd_kcontrol *kcontrol,
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned short val;
-	struct snd_soc_dapm_update update;
+	struct snd_soc_dapm_update update = { 0 };
 	int connect, change;
 
 	val = (ucontrol->value.integer.value[0] & mask);
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 557709eac698..85f7c5bb8b82 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -187,7 +187,7 @@ static int wm9712_hp_mixer_put(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mixer, mask, shift, old;
-	struct snd_soc_dapm_update update;
+	struct snd_soc_dapm_update update = { 0 };
 	bool change;
 
 	mixer = mc->shift >> 8;
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index e4301ddb1b84..7e4822185feb 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -231,7 +231,7 @@ static int wm9713_hp_mixer_put(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mixer, mask, shift, old;
-	struct snd_soc_dapm_update update;
+	struct snd_soc_dapm_update update = { 0 };
 	bool change;
 
 	mixer = mc->shift >> 8;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5f37fe9c454b..535c20e4fac9 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1635,6 +1635,15 @@ static void dapm_widget_update(struct snd_soc_card *card)
 		dev_err(w->dapm->dev, "ASoC: %s DAPM update failed: %d\n",
 			w->name, ret);
 
+	if (update->has_second_set) {
+		ret = soc_dapm_update_bits(w->dapm, update->reg2,
+					   update->mask2, update->val2);
+		if (ret < 0)
+			dev_err(w->dapm->dev,
+				"ASoC: %s DAPM update failed: %d\n",
+				w->name, ret);
+	}
+
 	for (wi = 0; wi < wlist->num_widgets; wi++) {
 		w = wlist->widgets[wi];
 
@@ -3093,7 +3102,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int invert = mc->invert;
 	unsigned int val;
 	int connect, change, reg_change = 0;
-	struct snd_soc_dapm_update update;
+	struct snd_soc_dapm_update update = { 0 };
 	int ret = 0;
 
 	if (snd_soc_volsw_is_stereo(mc))
@@ -3201,7 +3210,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int *item = ucontrol->value.enumerated.item;
 	unsigned int val, change, reg_change = 0;
 	unsigned int mask;
-	struct snd_soc_dapm_update update;
+	struct snd_soc_dapm_update update = { 0 };
 	int ret = 0;
 
 	if (item[0] >= e->items)
-- 
2.9.3
