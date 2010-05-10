From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: core: Fix for the volume limiting when
	invert is in use
Date: Mon, 10 May 2010 14:39:24 +0300
Message-ID: <1273491564-11666-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id CA5A324730
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 13:39:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

If the register for the volume needs invert, than the inversion
need to be done from the chip maximum, and not from the platform
dependent limit.
Introduce soc_mixer_control.platform_max value, which initially
equals to chip maximum.
The snd_soc_limit_volume function only modify the platform_max,
all volsw_info call returns this as well.
The .max value holds the chip default (maximum), and it is used
for the inversion, if it is needed.

Additional check in the volsw_info call has been added to check
the validity of the platform_max in case, when custom macros
used by codec drivers are not initializing it correctly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

Hello,

Normal, and inverted volume controls now can be limited, and
both behave correctly.
Has been tested on twl4030, tpa6130a2, and tlv320dac33
codec drivers.

The patch is generated against Takashi's topic/asoc branch,
but I think it should be fine with Mark's tree as well.

Peter

 include/sound/soc.h  |   23 ++++++++++++-----------
 sound/soc/soc-core.c |   30 +++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9f306f0..aac97d7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -30,10 +30,10 @@
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .shift = xshift, .rshift = xshift, .max = xmax, \
-	.invert = xinvert})
+	.platform_max = xmax, .invert = xinvert})
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .max = xmax, .invert = xinvert})
+	{.reg = xreg, .max = xmax, .platform_max = xmax, .invert = xinvert})
 #define SOC_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
@@ -53,14 +53,14 @@
 	.put = snd_soc_put_volsw, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
-		 .max = xmax, .invert = xinvert} }
+		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .invert = xinvert} }
+		.max = xmax, .platform_max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -70,7 +70,7 @@
 	.put = snd_soc_put_volsw, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .shift = shift_left, .rshift = shift_right,\
-		 .max = xmax, .invert = xinvert} }
+		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -80,7 +80,7 @@
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .invert = xinvert} }
+		.max = xmax, .platform_max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
@@ -89,7 +89,8 @@
 	.info   = snd_soc_info_volsw_s8, .get = snd_soc_get_volsw_s8, \
 	.put    = snd_soc_put_volsw_s8, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .min = xmin, .max = xmax} }
+		{.reg = xreg, .min = xmin, .max = xmax, \
+		 .platform_max = xmax} }
 #define SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmax, xtexts) \
 {	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
 	.max = xmax, .texts = xtexts }
@@ -126,7 +127,7 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
-		 .max = xmax, .invert = xinvert} }
+		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
 #define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -146,7 +147,7 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
-		.max = xmax, .invert = xinvert} }
+		.max = xmax, .platform_max = xmax, .invert = xinvert} }
 #define SOC_DOUBLE_R_EXT_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -157,7 +158,7 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .invert = xinvert} }
+		.max = xmax, .platform_max = xmax, .invert = xinvert} }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
@@ -569,7 +570,7 @@ struct snd_soc_pcm_runtime {
 
 /* mixer control */
 struct soc_mixer_control {
-	int min, max;
+	int min, max, platform_max;
 	unsigned int reg, rreg, shift, rshift, invert;
 };
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4079223..9340dcd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1954,18 +1954,22 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int max = mc->max;
+	int platform_max;
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 
-	if (max == 1 && !strstr(kcontrol->id.name, " Volume"))
+	if (!mc->platform_max)
+		mc->platform_max = mc->max;
+	platform_max = mc->platform_max;
+
+	if (platform_max == 1 && !strstr(kcontrol->id.name, " Volume"))
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 
 	uinfo->count = shift == rshift ? 1 : 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
+	uinfo->value.integer.max = platform_max;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
@@ -2063,16 +2067,20 @@ int snd_soc_info_volsw_2r(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int max = mc->max;
+	int platform_max;
 
-	if (max == 1 && !strstr(kcontrol->id.name, " Volume"))
+	if (!mc->platform_max)
+		mc->platform_max = mc->max;
+	platform_max = mc->platform_max;
+
+	if (platform_max == 1 && !strstr(kcontrol->id.name, " Volume"))
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	else
 		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 
 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max;
+	uinfo->value.integer.max = platform_max;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw_2r);
@@ -2173,13 +2181,17 @@ int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int max = mc->max;
+	int platform_max;
 	int min = mc->min;
 
+	if (!mc->platform_max)
+		mc->platform_max = mc->max;
+	platform_max = mc->platform_max;
+
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = max-min;
+	uinfo->value.integer.max = platform_max - min;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_info_volsw_s8);
@@ -2268,7 +2280,7 @@ int snd_soc_limit_volume(struct snd_soc_codec *codec,
 	if (found) {
 		mc = (struct soc_mixer_control *)kctl->private_value;
 		if (max <= mc->max) {
-			mc->max = max;
+			mc->platform_max = max;
 			ret = 0;
 		}
 	}
-- 
1.7.1
