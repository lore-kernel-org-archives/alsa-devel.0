From: Patrick Lai <plai@codeaurora.org>
Subject: [PATCH] ASoC: introduce SOC_SINGLE_S8_TLV macro
Date: Sat,  7 Jan 2012 17:53:26 -0800
Message-ID: <1325987606-7179-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id C15402434F
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 02:53:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

ASoC currently has macro for double 8-bit signed TLV.
Enhance info,get,put callback functions of SOC_DOUBLE_S8_TLV
for single single 8-bit signed TLV.

Signed-off-by: Patrick Lai <plai@codeaurora.org>
---
 include/sound/soc.h  |   10 ++++++++++
 sound/soc/soc-core.c |   28 ++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 11cfb59..558e9ff 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -55,6 +55,16 @@
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_SINGLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
+{	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
+		SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.tlv.p  = (tlv_array), \
+	.info   = snd_soc_info_volsw_s8, .get = snd_soc_get_volsw_s8, \
+	.put    = snd_soc_put_volsw_s8, \
+	.private_value = (unsigned long)&(struct soc_mixer_control) \
+		{.reg = xreg, .min = xmin, .max = xmax, \
+		 .platform_max = xmax} }
 #define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a5d3685..3d1ba5f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2399,13 +2399,15 @@ int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int platform_max;
 	int min = mc->min;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
 
 	if (!mc->platform_max)
 		mc->platform_max = mc->max;
 	platform_max = mc->platform_max;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 2;
+	uinfo->count = shift == rshift ? 1 : 2;
 	uinfo->value.integer.min = 0;
 	uinfo->value.integer.max = platform_max - min;
 	return 0;
@@ -2428,13 +2430,16 @@ int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
 	int min = mc->min;
 	int val = snd_soc_read(codec, reg);
 
 	ucontrol->value.integer.value[0] =
-		((signed char)(val & 0xff))-min;
-	ucontrol->value.integer.value[1] =
-		((signed char)((val >> 8) & 0xff))-min;
+		((signed char)((val >> shift) & 0xff))-min;
+	if (shift != rshift)
+		ucontrol->value.integer.value[1] =
+			((signed char)((val >> rshift) & 0xff))-min;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_s8);
@@ -2455,13 +2460,20 @@ int snd_soc_put_volsw_s8(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
+	unsigned int shift = mc->shift;
+	unsigned int rshift = mc->rshift;
 	int min = mc->min;
-	unsigned int val;
+	unsigned int val, val2, val_mask;
 
-	val = (ucontrol->value.integer.value[0]+min) & 0xff;
-	val |= ((ucontrol->value.integer.value[1]+min) & 0xff) << 8;
+	val = ((ucontrol->value.integer.value[0]+min) & 0xff) << shift;
+	val_mask = 0xff << shift;
+	if (shift != rshift) {
+		val2 = (ucontrol->value.integer.value[1]+min) & 0xff;
+		val |= val2 << rshift;
+		val_mask |= 0xff << rshift;
+	}
 
-	return snd_soc_update_bits_locked(codec, reg, 0xffff, val);
+	return snd_soc_update_bits_locked(codec, reg, val_mask, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw_s8);
 
-- 
1.7.3.3
--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
--
