From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 07/10] ASoC: core: Combine
	snd_soc_put_volsw/put_volsw_2r functions
Date: Wed,  5 Oct 2011 10:29:25 +0300
Message-ID: <1317799768-15683-8-git-send-email-peter.ujfalusi@ti.com>
References: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id D1E17103A2F
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:53 +0200 (CEST)
Received: by mail-bw0-f44.google.com with SMTP id q10so2789311bka.17
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:51 -0700 (PDT)
In-Reply-To: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Handle the put_volsw/put_volsw_2r in one function.

To avoid build breakage in twl6040 keep the
snd_soc_put_volsw_2r as define, and map it snd_soc_put_volsw.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h  |    7 ++---
 sound/soc/soc-core.c |   66 ++++++++++++++-----------------------------------
 2 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cab1ffe..14883a4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -64,7 +64,7 @@
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_2r, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
 #define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
@@ -82,7 +82,7 @@
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_2r, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
@@ -393,8 +393,7 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
+#define snd_soc_put_volsw_2r snd_soc_put_volsw
 int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6c78841..5ba02d1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2327,7 +2327,8 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw);
  * @kcontrol: mixer control
  * @ucontrol: control element information
  *
- * Callback to set the value of a single mixer control.
+ * Callback to set the value of a single mixer control, or a double mixer
+ * control that spans 2 registers.
  *
  * Returns 0 for success.
  */
@@ -2338,73 +2339,44 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
 	unsigned int mask = (1 << fls(max)) - 1;
 	unsigned int invert = mc->invert;
-	unsigned int val, val2, val_mask;
+	int err;
+	bool type_2r = 0;
+	unsigned int val2 = 0;
+	unsigned int val, val_mask;
 
 	val = (ucontrol->value.integer.value[0] & mask);
 	if (invert)
 		val = max - val;
 	val_mask = mask << shift;
 	val = val << shift;
-	if (shift != rshift) {
+	if (snd_soc_volsw_is_stereo(mc)) {
 		val2 = (ucontrol->value.integer.value[1] & mask);
 		if (invert)
 			val2 = max - val2;
-		val_mask |= mask << rshift;
-		val |= val2 << rshift;
-	}
-	return snd_soc_update_bits_locked(codec, reg, val_mask, val);
-}
-EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
-
-/**
- * snd_soc_put_volsw_2r - double mixer set callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to set the value of a double mixer control that spans 2 registers.
- *
- * Returns 0 for success.
- */
-int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned int reg = mc->reg;
-	unsigned int reg2 = mc->rreg;
-	unsigned int shift = mc->shift;
-	int max = mc->max;
-	unsigned int mask = (1 << fls(max)) - 1;
-	unsigned int invert = mc->invert;
-	int err;
-	unsigned int val, val2, val_mask;
-
-	val_mask = mask << shift;
-	val = (ucontrol->value.integer.value[0] & mask);
-	val2 = (ucontrol->value.integer.value[1] & mask);
-
-	if (invert) {
-		val = max - val;
-		val2 = max - val2;
+		if (reg == reg2) {
+			val_mask |= mask << rshift;
+			val |= val2 << rshift;
+		} else {
+			val2 = val2 << shift;
+			type_2r = 1;
+		}
 	}
-
-	val = val << shift;
-	val2 = val2 << shift;
-
 	err = snd_soc_update_bits_locked(codec, reg, val_mask, val);
 	if (err < 0)
 		return err;
 
-	err = snd_soc_update_bits_locked(codec, reg2, val_mask, val2);
+	if (type_2r)
+		err = snd_soc_update_bits_locked(codec, reg2, val_mask, val2);
+
 	return err;
 }
-EXPORT_SYMBOL_GPL(snd_soc_put_volsw_2r);
+EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
 /**
  * snd_soc_info_volsw_s8 - signed mixer info callback
-- 
1.7.7
