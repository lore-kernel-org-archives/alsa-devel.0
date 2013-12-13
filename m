From: Nenghua Cao <nhcao@marvell.com>
Subject: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
	runtime route update
Date: Fri, 13 Dec 2013 19:20:07 +0800
Message-ID: <1386933607-828-2-git-send-email-nhcao@marvell.com>
References: <1386933607-828-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id C3CAC261603
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:14:32 +0100 (CET)
In-Reply-To: <1386933607-828-1-git-send-email-nhcao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, alsa-devel@alsa-project.org
Cc: Henry zhao <xzhao10@marvell.com>, Nenghua Cao <nhcao@marvell.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org

From: Nenghua Cao <nhcao@marvell.com>

    DPCM can dynamically alter the FE to BE PCM links at runtime based
on mixer setting updates. DAPM has provided common get/put function for
mixer/mux. But these function doesn't call soc_dpcm_runtime_update()
func to update pcm links. This patch extends these common functions.
There is a flag to indicate if runtime_update is needed. And this flag
can be set in user's definition.

Signed-off-by: Nenghua Cao <nhcao@marvell.com>
---
 include/sound/soc-dapm.h |   14 ++++++++++++++
 include/sound/soc.h      |   19 +++++++++++++++++++
 sound/soc/soc-dapm.c     |   28 ++++++++++++++++++++++++----
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 56ebdfc..1af6caa 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -336,6 +336,20 @@ struct device;
 	.put = snd_soc_dapm_put_pin_switch, \
 	.private_value = (unsigned long)xname }
 
+/* dapm & dpcm kcontrol types */
+#define SOC_DAPM_DPCM_SINGLE(xname, reg, shift, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE_DPCM(reg, shift, max, invert, 1) }
+#define SOC_DAPM_DPCM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_volsw, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE_DPCM(reg, shift, max, invert, 1) }
+
 /* dapm stream operations */
 #define SND_SOC_DAPM_STREAM_NOP			0x0
 #define SND_SOC_DAPM_STREAM_START		0x1
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1f741cb..6766cc7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -49,6 +49,13 @@
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
 	.min = xmin, .max = xmax, .platform_max = xmax, .invert = xinvert})
+#define SOC_DOUBLE_VALUE_DPCM(xreg, shift_left, shift_right, xmax, xinvert, dpcm) \
+	((unsigned long)&(struct soc_mixer_control) \
+	{.reg = xreg, .rreg = xreg, .shift = shift_left, \
+	.rshift = shift_right, .max = xmax, .platform_max = xmax, \
+	.invert = xinvert, .dpcm_checked = dpcm})
+#define SOC_SINGLE_VALUE_DPCM(xreg, xshift, xmax, xinvert, dpcm) \
+	SOC_DOUBLE_VALUE_DPCM(xreg, xshift, xshift, xmax, xinvert, dpcm)
 #define SOC_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
@@ -175,6 +182,14 @@
 	.mask = xmask, .max = xmax, .texts = xtexts, .values = xvalues}
 #define SOC_VALUE_ENUM_SINGLE(xreg, xshift, xmask, xmax, xtexts, xvalues) \
 	SOC_VALUE_ENUM_DOUBLE(xreg, xshift, xshift, xmask, xmax, xtexts, xvalues)
+#define SOC_ENUM_SINGLE_DPCM(xreg, xshift, xmax, dpcm, xtexts) \
+{	.reg = xreg, .shift_l = xshift, .shift_r = xshift, \
+	.max = xmax, .dpcm_checked = dpcm, .texts = xtexts, \
+	.mask = xmax ? roundup_pow_of_two(xmax) - 1 : 0}
+#define SOC_ENUM_DOUBLE_DPCM(xreg, xshift_l, xshift_r, xmax, dpcm,  xtexts) \
+{	.reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
+	.max = xmax, .dpcm_checked = dpcm, .texts = xtexts, \
+	.mask = xmax ? roundup_pow_of_two(xmax) - 1 : 0}
 #define SOC_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,\
 	.info = snd_soc_info_enum_double, \
@@ -1055,6 +1070,8 @@ struct soc_mixer_control {
 	unsigned int shift, rshift;
 	unsigned int invert:1;
 	unsigned int autodisable:1;
+	/* this kcontrol impact fe<->be relationship at runtime */
+	unsigned int dpcm_checked:1;
 };
 
 struct soc_bytes {
@@ -1079,6 +1096,8 @@ struct soc_enum {
 	unsigned int mask;
 	const char * const *texts;
 	const unsigned int *values;
+	/* this kcontrol impact fe<->be relationship at runtime */
+	unsigned int dpcm_checked:1;
 };
 
 /* codec IO */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcade13..b763d1d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2868,6 +2868,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 	unsigned int val;
 	int connect, change;
 	struct snd_soc_dapm_update update;
+	int ret = 0;
 
 	if (snd_soc_volsw_is_stereo(mc))
 		dev_warn(codec->dapm.dev,
@@ -2901,12 +2902,16 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 			card->update = &update;
 		}
 
-		soc_dapm_mixer_update_power(card, kcontrol, connect);
+		ret = soc_dapm_mixer_update_power(card, kcontrol, connect);
 
 		card->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
+
+	if ((ret > 0) && (mc->dpcm_checked == 1))
+		soc_dpcm_runtime_update(card);
+
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_volsw);
@@ -2955,6 +2960,7 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int val, mux, change;
 	unsigned int mask;
 	struct snd_soc_dapm_update update;
+	int ret = 0;
 
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
@@ -2978,12 +2984,16 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
 		update.val = val;
 		card->update = &update;
 
-		soc_dapm_mux_update_power(card, kcontrol, mux, e);
+		ret = soc_dapm_mux_update_power(card, kcontrol, mux, e);
 
 		card->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
+
+	if ((ret > 0) && (e->dpcm_checked == 1))
+		soc_dpcm_runtime_update(card);
+
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_double);
@@ -3019,6 +3029,7 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e =
 		(struct soc_enum *)kcontrol->private_value;
 	int change;
+	int ret = 0;
 
 	if (ucontrol->value.enumerated.item[0] >= e->max)
 		return -EINVAL;
@@ -3028,9 +3039,13 @@ int snd_soc_dapm_put_enum_virt(struct snd_kcontrol *kcontrol,
 	value = ucontrol->value.enumerated.item[0];
 	change = dapm_kcontrol_set_value(kcontrol, value);
 	if (change)
-		soc_dapm_mux_update_power(card, kcontrol, value, e);
+		ret = soc_dapm_mux_update_power(card, kcontrol, value, e);
 
 	mutex_unlock(&card->dapm_mutex);
+
+	if ((ret > 0) && (e->dpcm_checked == 1))
+		soc_dpcm_runtime_update(card);
+
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_enum_virt);
@@ -3097,6 +3112,7 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 	unsigned int val, mux, change;
 	unsigned int mask;
 	struct snd_soc_dapm_update update;
+	int ret = 0;
 
 	if (ucontrol->value.enumerated.item[0] > e->max - 1)
 		return -EINVAL;
@@ -3120,12 +3136,16 @@ int snd_soc_dapm_put_value_enum_double(struct snd_kcontrol *kcontrol,
 		update.val = val;
 		card->update = &update;
 
-		soc_dapm_mux_update_power(card, kcontrol, mux, e);
+		ret = soc_dapm_mux_update_power(card, kcontrol, mux, e);
 
 		card->update = NULL;
 	}
 
 	mutex_unlock(&card->dapm_mutex);
+
+	if ((ret > 0) && (e->dpcm_checked == 1))
+		soc_dpcm_runtime_update(card);
+
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
-- 
1.7.0.4
