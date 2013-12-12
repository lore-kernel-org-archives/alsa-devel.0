From: Nenghua Cao <nhcao@marvell.com>
Subject: [PATCH] ASOC:DAPM: extend dapm kcontrol to support
	runtime route update
Date: Thu, 12 Dec 2013 16:06:59 +0800
Message-ID: <1386835619-18070-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 04C6926080B
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 09:02:18 +0100 (CET)
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
Cc: Henry zhao <xzhao10@marvell.com>, nhcao <nhcao@marvell.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org

From: nhcao <nhcao@marvell.com>

    DPCM can dynamically alter the FE to BE PCM links at runtime based
on mixer setting updates. DAPM has provided common get/put function for
mixer/mux. But these function doesn't call soc_dpcm_runtime_update()
func to update pcm links. This patch defines a DPCM DPCM kcontrol. For
this control, the common get/put function will update FE to BE links
dynamically. This patch has no impact to the current code.

Change-Id: I45e291f467e4fa17e21aa8923c2b712d52067aca
Signed-off-by: nhcao <nhcao@marvell.com>
---
 include/sound/control.h  |    4 ++++
 include/sound/soc-dapm.h |   32 ++++++++++++++++++++++++++++++++
 sound/core/control.c     |    1 +
 sound/soc/soc-dapm.c     |   28 ++++++++++++++++++++++++----
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 5358892..3788284 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -44,6 +44,8 @@ struct snd_kcontrol_new {
 	unsigned int index;		/* index of item */
 	unsigned int access;		/* access rights */
 	unsigned int count;		/* count of same elements */
+	/* this kcontrol impact fe<->be relationship at runtime */
+	unsigned char dpcm_checked;
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
@@ -63,6 +65,8 @@ struct snd_kcontrol {
 	struct list_head list;		/* list of controls */
 	struct snd_ctl_elem_id id;
 	unsigned int count;		/* count of same elements */
+	/* this kcontrol impact fe<->be relationship at runtime */
+	unsigned char dpcm_checked;
 	snd_kcontrol_info_t *info;
 	snd_kcontrol_get_t *get;
 	snd_kcontrol_put_t *put;
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 56ebdfc..8962884 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -336,6 +336,38 @@ struct device;
 	.put = snd_soc_dapm_put_pin_switch, \
 	.private_value = (unsigned long)xname }
 
+/* dapm & dpcm kcontrol types */
+#define SOC_DAPM_DPCM_SINGLE(xname, reg, shift, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.dpcm_checked = 1, .info = snd_soc_info_volsw, \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_DAPM_DPCM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.dpcm_checked = 1, .info = snd_soc_info_volsw, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
+	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
+#define SOC_DAPM_DPCM_ENUM(xname, xenum) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.dpcm_checked = 1, .info = snd_soc_info_enum_double, \
+	.get = snd_soc_dapm_get_enum_double, \
+	.put = snd_soc_dapm_put_enum_double, \
+	.private_value = (unsigned long)&xenum }
+#define SOC_DAPM_DPCM_ENUM_VIRT(xname, xenum)		    \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.dpcm_checked = 1, .info = snd_soc_info_enum_double, \
+	.get = snd_soc_dapm_get_enum_virt, \
+	.put = snd_soc_dapm_put_enum_virt, \
+	.private_value = (unsigned long)&xenum }
+#define SOC_DAPM_DPCM_VALUE_ENUM(xname, xenum) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.dpcm_checked = 1, .info = snd_soc_info_enum_double, \
+	.get = snd_soc_dapm_get_value_enum_double, \
+	.put = snd_soc_dapm_put_value_enum_double, \
+	.private_value = (unsigned long)&xenum }
+
 /* dapm stream operations */
 #define SND_SOC_DAPM_STREAM_NOP			0x0
 #define SND_SOC_DAPM_STREAM_START		0x1
diff --git a/sound/core/control.c b/sound/core/control.c
index d8aa206..34df2c4 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -254,6 +254,7 @@ struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new *ncontrol,
 				      SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE|
 				      SNDRV_CTL_ELEM_ACCESS_TLV_COMMAND|
 				      SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK));
+	kctl.dpcm_checked = ncontrol->dpcm_checked;
 	kctl.info = ncontrol->info;
 	kctl.get = ncontrol->get;
 	kctl.put = ncontrol->put;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index dcade13..b568183 100644
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
+	if ((ret > 0) && (kcontrol->dpcm_checked == 1))
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
+	if ((ret > 0) && (kcontrol->dpcm_checked == 1))
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
+	if ((ret > 0) && (kcontrol->dpcm_checked == 1))
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
+	if ((ret > 0) && (kcontrol->dpcm_checked == 1))
+		soc_dpcm_runtime_update(card);
+
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_value_enum_double);
-- 
1.7.0.4
