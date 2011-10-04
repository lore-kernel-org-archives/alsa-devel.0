From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 09/12] ASoC: core: Combine
	snd_soc_get_volsw/get_volsw_2r functions
Date: Tue,  4 Oct 2011 14:39:46 +0300
Message-ID: <1317728389-22062-10-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BE89103846
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:16 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so610915bkb.32
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:15 -0700 (PDT)
In-Reply-To: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
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

Handle the get_volsw/get_volsw_2r in one function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h  |    6 +---
 sound/soc/soc-core.c |   55 +++++++++++--------------------------------------
 2 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 190d603..fd97659 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -64,7 +64,7 @@
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_2r, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
 #define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
@@ -82,7 +82,7 @@
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
-	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw_2r, \
 	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
 					    xmax, xinvert) }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
@@ -393,8 +393,6 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw_2r(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d588bb1..a67c113 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2281,7 +2281,8 @@ EXPORT_SYMBOL_GPL(snd_soc_info_volsw);
  * @kcontrol: mixer control
  * @ucontrol: control element information
  *
- * Callback to get the value of a single mixer control.
+ * Callback to get the value of a single mixer control, or a double mixer
+ * control that spans 2 registers.
  *
  * Returns 0 for success.
  */
@@ -2292,6 +2293,7 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int reg = mc->reg;
+	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 	int max = mc->max;
@@ -2300,13 +2302,19 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 
 	ucontrol->value.integer.value[0] =
 		(snd_soc_read(codec, reg) >> shift) & mask;
-	if (shift != rshift)
-		ucontrol->value.integer.value[1] =
-			(snd_soc_read(codec, reg) >> rshift) & mask;
+
+	if (snd_soc_volsw_is_stereo(mc)) {
+		if (shift != rshift)
+			ucontrol->value.integer.value[1] =
+				(snd_soc_read(codec, reg) >> rshift) & mask;
+		else
+			ucontrol->value.integer.value[1] =
+				(snd_soc_read(codec, reg2) >> shift) & mask;
+	}
 	if (invert) {
 		ucontrol->value.integer.value[0] =
 			max - ucontrol->value.integer.value[0];
-		if (shift != rshift)
+		if (snd_soc_volsw_is_stereo(mc))
 			ucontrol->value.integer.value[1] =
 				max - ucontrol->value.integer.value[1];
 	}
@@ -2355,43 +2363,6 @@ int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_put_volsw);
 
 /**
- * snd_soc_get_volsw_2r - double mixer get callback
- * @kcontrol: mixer control
- * @ucontrol: control element information
- *
- * Callback to get the value of a double mixer control that spans 2 registers.
- *
- * Returns 0 for success.
- */
-int snd_soc_get_volsw_2r(struct snd_kcontrol *kcontrol,
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
-
-	ucontrol->value.integer.value[0] =
-		(snd_soc_read(codec, reg) >> shift) & mask;
-	ucontrol->value.integer.value[1] =
-		(snd_soc_read(codec, reg2) >> shift) & mask;
-	if (invert) {
-		ucontrol->value.integer.value[0] =
-			max - ucontrol->value.integer.value[0];
-		ucontrol->value.integer.value[1] =
-			max - ucontrol->value.integer.value[1];
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r);
-
-/**
  * snd_soc_put_volsw_2r - double mixer set callback
  * @kcontrol: mixer control
  * @ucontrol: control element information
-- 
1.7.7
