From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: [PATCH] soc-core: Fix volsw_range funcs so SOC_DOUBLE_R_RANGE_TLV works.
Date: Fri, 19 Sep 2014 12:50:31 +0100
Message-ID: <1411127431-31144-1-git-send-email-hm@hmbedded.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Howard Mitchell <hm@hmbedded.co.uk>
List-Id: alsa-devel@alsa-project.org

This fixes a bug when using the SOC_DOUBLE_R_RANGE_TLV macro in
the invert mode. In the non-invert case, e.g.

SOC_DOUBLE_R_RANGE_TLV("<name>", <reg_l>, <reg_r>,
					0, 40, 255, 0, <tlv>)

the range sent to the hardware is 40..255, but in the invert case:

SOC_DOUBLE_R_RANGE_TLV("<name>", <reg_l>, <reg_r>,
					0, 40, 255, 1, <tlv>)

the range 215..0 was being sent to the hardware. This commit
corrects this to 255..40 so it is consistent with the non-invert
case.

Signed-off-by: Howard Mitchell <hm@hmbedded.co.uk>
---
 sound/soc/soc-core.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d4bfd4a..6a58af3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3027,9 +3027,10 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 	unsigned int val, val_mask;
 	int ret;
 
-	val = ((ucontrol->value.integer.value[0] + min) & mask);
 	if (invert)
-		val = max - val;
+		val = (max - ucontrol->value.integer.value[0]) & mask;
+	else
+		val = ((ucontrol->value.integer.value[0] + min) & mask);
 	val_mask = mask << shift;
 	val = val << shift;
 
@@ -3038,9 +3039,10 @@ int snd_soc_put_volsw_range(struct snd_kcontrol *kcontrol,
 		return ret;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
-		val = ((ucontrol->value.integer.value[1] + min) & mask);
 		if (invert)
-			val = max - val;
+			val = (max - ucontrol->value.integer.value[1]) & mask;
+		else
+			val = ((ucontrol->value.integer.value[1] + min) & mask);
 		val_mask = mask << shift;
 		val = val << shift;
 
@@ -3085,8 +3087,9 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 	if (invert)
 		ucontrol->value.integer.value[0] =
 			max - ucontrol->value.integer.value[0];
-	ucontrol->value.integer.value[0] =
-		ucontrol->value.integer.value[0] - min;
+	else
+		ucontrol->value.integer.value[0] =
+			ucontrol->value.integer.value[0] - min;
 
 	if (snd_soc_volsw_is_stereo(mc)) {
 		ret = snd_soc_component_read(component, rreg, &val);
@@ -3097,8 +3100,9 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 		if (invert)
 			ucontrol->value.integer.value[1] =
 				max - ucontrol->value.integer.value[1];
-		ucontrol->value.integer.value[1] =
-			ucontrol->value.integer.value[1] - min;
+		else
+			ucontrol->value.integer.value[1] =
+				ucontrol->value.integer.value[1] - min;
 	}
 
 	return 0;
-- 
1.7.9.5
