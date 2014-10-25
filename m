From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Use generic control handlers for S8
	control
Date: Sat, 25 Oct 2014 20:25:56 +0200
Message-ID: <1414261556-16212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 334AB260610
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 20:26:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit f227b88f0fce ("ASoC: core: Add signed register volume control logic")
added support for signed control to the generic volsw control handler.
This makes it possible to use them for the S8 control as well, rather than
having to use a custom control handler implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 19 +++++-------
 sound/soc/soc-core.c | 87 ----------------------------------------------------
 2 files changed, 8 insertions(+), 98 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7ba7130..ad47e96 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -36,6 +36,11 @@
 	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
 	.rshift = shift_right, .max = xmax, .platform_max = xmax, \
 	.invert = xinvert, .autodisable = xautodisable})
+#define SOC_DOUBLE_S_VALUE(xreg, shift_left, shift_right, xmin, xmax, xsign_bit, xinvert, xautodisable) \
+	((unsigned long)&(struct soc_mixer_control) \
+	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
+	.rshift = shift_right, .min = xmin, .max = xmax, .platform_max = xmax, \
+	.sign_bit = xsign_bit, .invert = xinvert, .autodisable = xautodisable})
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert, xautodisable) \
 	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert, xautodisable)
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
@@ -171,11 +176,9 @@
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
 		  SNDRV_CTL_ELEM_ACCESS_READWRITE, \
 	.tlv.p  = (tlv_array), \
-	.info   = snd_soc_info_volsw_s8, .get = snd_soc_get_volsw_s8, \
-	.put    = snd_soc_put_volsw_s8, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .min = xmin, .max = xmax, \
-		 .platform_max = xmax} }
+	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
+	.put = snd_soc_put_volsw, \
+	.private_value = SOC_DOUBLE_S_VALUE(xreg, 0, 8, xmin, xmax, 7, 0, 0) }
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xitems, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.items = xitems, .texts = xtexts, \
@@ -545,12 +548,6 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo);
-int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_info_volsw_range(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96ecdc3..47c378a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2721,93 +2721,6 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_sx);
 
 /**
- * snd_soc_info_volsw_s8 - signed mixer info callback
- * @kcontrol: mixer control
- * @uinfo: control element information
- *
- * Callback to provide information about a signed mixer control.
- *
- * Returns 0 for success.
- */
-int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int platform_max;
-	int min = mc->min;
-
-	if (!mc->platform_max)
-		mc->platform_max = mc->max;
-	platform_max = mc->platform_max;
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 2;
-	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = platform_max - min;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_info_volsw_s8);
-
-/**
- * snd_soc_get_volsw_s8 - signed mixer get callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to get the value of a signed mixer control.
- *
- * Returns 0 for success.
- */
-int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	unsigned int reg = mc->reg;
-	unsigned int val;
-	int min = mc->min;
-	int ret;
-
-	ret = snd_soc_component_read(component, reg, &val);
-	if (ret)
-		return ret;
-
-	ucontrol->value.integer.value[0] =
-		((signed char)(val & 0xff))-min;
-	ucontrol->value.integer.value[1] =
-		((signed char)((val >> 8) & 0xff))-min;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_get_volsw_s8);
-
-/**
- * snd_soc_put_volsw_sgn - signed mixer put callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to set the value of a signed mixer control.
- *
- * Returns 0 for success.
- */
-int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	unsigned int reg = mc->reg;
-	int min = mc->min;
-	unsigned int val;
-
-	val = (ucontrol->value.integer.value[0]+min) & 0xff;
-	val |= ((ucontrol->value.integer.value[1]+min) & 0xff) << 8;
-
-	return snd_soc_component_update_bits(component, reg, 0xffff, val);
-}
-EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
-
-/**
  * snd_soc_info_volsw_range - single mixer info callback with range.
  * @kcontrol: mixer control
  * @uinfo: control element information
-- 
1.8.0
