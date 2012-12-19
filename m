From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Fix SOC_DOUBLE_RANGE() macros
Date: Wed, 19 Dec 2012 16:18:36 +0000
Message-ID: <1355933916-6301-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37336265049
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 17:18:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Although we've had macros defining double _RANGE controls for a while now
they've not actually been backed up properly by the implementation, it's
treated everything as mono. Fix that by implementing the handling in the
stereo controls, ensuring that the mono controls don't mistakenly get
treated as stereo.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |   10 ++++++----
 sound/soc/soc-core.c |   32 ++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4a27822..1e4ea78 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -58,8 +58,9 @@
 	.info = snd_soc_info_volsw_range, .get = snd_soc_get_volsw_range, \
 	.put = snd_soc_put_volsw_range, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = xshift, .min = xmin,\
-		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
+		{.reg = xreg, .rreg = xreg, .shift = xshift, \
+		 .rshift = xshift,  .min = xmin, .max = xmax, \
+		 .platform_max = xmax, .invert = xinvert} }
 #define SOC_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -88,8 +89,9 @@
 	.info = snd_soc_info_volsw_range, \
 	.get = snd_soc_get_volsw_range, .put = snd_soc_put_volsw_range, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = xshift, .min = xmin,\
-		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
+		{.reg = xreg, .rreg = xreg, .shift = xshift, \
+		 .rshift = xshift, .min = xmin, .max = xmax, \
+		 .platform_max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b1738d5..d4732ac 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2922,7 +2922,7 @@ int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
 	platform_max = mc->platform_max;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
+	uinfo->count = snd_soc_volsw_is_stereo(mc) ? 2 : 1;
 	uinfo->value.integer.min = 0;
 	uinfo->value.integer.max = platform_max - min;
 
@@ -2946,12 +2946,14 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
+	unsigned int rreg = mc->rreg;
 	unsigned int shift = mc->shift;
 	int min = mc->min;
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
 	unsigned int val, val_mask;
+	int ret;
 
 	val = ((ucontrol->value.integer.value[0] + min) & mask);
 	if (invert)
@@ -2959,7 +2961,21 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	val_mask = mask << shift;
 	val = val << shift;
 
-	return snd_soc_update_bits_locked(codec, reg, val_mask, val);
+	ret = snd_soc_update_bits_locked(codec, reg, val_mask, val);
+	if (ret != 0)
+		return ret;
+
+	if (snd_soc_volsw_is_stereo(mc)) {
+		val = ((ucontrol->value.integer.value[1] + min) & mask);
+		if (invert)
+			val = max - val;
+		val_mask = mask << shift;
+		val = val << shift;
+
+		ret = snd_soc_update_bits_locked(codec, rreg, val_mask, val);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_range);
 
@@ -2979,11 +2995,13 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
+	unsigned int rreg = mc->rreg;
 	unsigned int shift = mc->shift;
 	int min = mc->min;
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
+	int ret;
 
 	ucontrol->value.integer.value[0] =
 		(snd_soc_read(codec, reg) >> shift) & mask;
@@ -2993,6 +3011,16 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	ucontrol->value.integer.value[0] =
 		ucontrol->value.integer.value[0] - min;
 
+	if (snd_soc_volsw_is_stereo(mc)) {
+		ucontrol->value.integer.value[1] =
+			(snd_soc_read(codec, rreg) >> shift) & mask;
+		if (invert)
+			ucontrol->value.integer.value[1] =
+				max - ucontrol->value.integer.value[1];
+		ucontrol->value.integer.value[1] =
+			ucontrol->value.integer.value[1] - min;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
-- 
1.7.10.4
