From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: control: return payload length for
	TLV operation
Date: Tue, 30 Aug 2016 08:44:42 +0900
Message-ID: <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id F2D1F2663E8
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 01:44:56 +0200 (CEST)
In-Reply-To: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

TLV feature of control interface is originally introduced at
commit 42750b04c5ba ("[ALSA] Control API - TLV implementation for
additional information like dB scale") and commit 8aa9b586e420 ("[ALSA]
Control API - more robust TLV implementation"). In this time,
snd_kcontrol_tlv_rw_t is for generating and transferring information about
threshold level for applications.

This feature can transfer arbitrary data in a shape of an array with
members of unsigned int type, therefore it can be used to deliver quite
large arbitrary data from user space to in-kernel drivers via ALSA control
character device. Focusing on this nature, commit 7523a271682f ("ASoC:
core: add a helper for extended byte controls using TLV") introduced
snd_soc_bytes_tlv_callback() just for I/O operations.

In this case, typically, APIs return operated length, while TLV feature
can't. This is inconvenient to applications.

This commit enables control core to return operated length of TLV feature.
This changes the prototype of 'snd_kcontrol_tlv_rw_t' to get a pointer to
size variable so that each implementation of the prototype can modify the
variable with operated length.

This commit also changes related codes. Below modules are modified:
 - snd
 - hda-core
 - hda-codec
 - hda-codec-ca0132
 - lola
 - usb-audio
 - soc-core

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/control.h      |  2 +-
 include/sound/soc.h          |  2 +-
 sound/core/control.c         | 28 +++++++++++++++++++---------
 sound/core/pcm_lib.c         | 15 ++++++++-------
 sound/core/vmaster.c         |  2 +-
 sound/hda/hdmi_chmap.c       | 16 +++++++++-------
 sound/pci/hda/hda_codec.c    | 12 ++++++++----
 sound/pci/hda/hda_local.h    |  4 ++--
 sound/pci/hda/patch_ca0132.c |  2 +-
 sound/pci/lola/lola_mixer.c  |  7 +++++--
 sound/soc/soc-ops.c          |  9 +++++----
 sound/usb/mixer.c            |  7 +++++--
 sound/usb/mixer.h            |  2 +-
 sound/usb/stream.c           | 13 ++++++++-----
 14 files changed, 74 insertions(+), 47 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 21d047f..848940c 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -32,7 +32,7 @@ typedef int (snd_kcontrol_get_t) (struct snd_kcontrol * kcontrol, struct snd_ctl
 typedef int (snd_kcontrol_put_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
 typedef int (snd_kcontrol_tlv_rw_t)(struct snd_kcontrol *kcontrol,
 				    int op_flag, /* SNDRV_CTL_TLV_OP_XXX */
-				    unsigned int size,
+				    unsigned int *size,
 				    unsigned int __user *tlv);
 
 enum {
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6144882..cfd1ca1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -647,7 +647,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *ucontrol);
 int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
-	unsigned int size, unsigned int __user *tlv);
+	unsigned int *size, unsigned int __user *tlv);
 int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
diff --git a/sound/core/control.c b/sound/core/control.c
index fb096cb..485963e 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1139,7 +1139,7 @@ static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 
 static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
 				 int op_flag,
-				 unsigned int size,
+				 unsigned int *size,
 				 unsigned int __user *tlv)
 {
 	struct user_element *ue = kcontrol->private_data;
@@ -1147,19 +1147,19 @@ static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
 	void *new_data;
 
 	if (op_flag == SNDRV_CTL_TLV_OP_WRITE) {
-		if (size > 1024 * 128)	/* sane value */
+		if (*size > 1024 * 128)	/* sane value */
 			return -EINVAL;
 
-		new_data = memdup_user(tlv, size);
+		new_data = memdup_user(tlv, *size);
 		if (IS_ERR(new_data))
 			return PTR_ERR(new_data);
 		mutex_lock(&ue->card->user_ctl_lock);
-		change = ue->tlv_data_size != size;
+		change = ue->tlv_data_size != *size;
 		if (!change)
-			change = memcmp(ue->tlv_data, new_data, size);
+			change = memcmp(ue->tlv_data, new_data, *size);
 		kfree(ue->tlv_data);
 		ue->tlv_data = new_data;
-		ue->tlv_data_size = size;
+		ue->tlv_data_size = *size;
 		mutex_unlock(&ue->card->user_ctl_lock);
 	} else {
 		int ret = 0;
@@ -1169,12 +1169,13 @@ static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
 			ret = -ENXIO;
 			goto err_unlock;
 		}
-		if (size < ue->tlv_data_size) {
+		if (*size < ue->tlv_data_size) {
 			ret = -ENOSPC;
 			goto err_unlock;
 		}
 		if (copy_to_user(tlv, ue->tlv_data, ue->tlv_data_size))
 			ret = -EFAULT;
+		*size = ue->tlv_data_size;
 err_unlock:
 		mutex_unlock(&ue->card->user_ctl_lock);
 		if (ret)
@@ -1466,7 +1467,15 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 			err = -EPERM;
 			goto __kctl_end;
 		}
-		err = kctl->tlv.c(kctl, op_flag, tlv.length, _tlv->tlv);
+		len = tlv.length;
+		err = kctl->tlv.c(kctl, op_flag, &len, _tlv->tlv);
+		if (err < 0)
+			goto __kctl_end;
+		/* Return operated bytes. */
+		if (put_user(len, &_tlv->length)) {
+			err = -EFAULT;
+			goto __kctl_end;
+		}
 		if (err > 0) {
 			struct snd_ctl_elem_id id = kctl->id;
 			up_read(&card->controls_rwsem);
@@ -1483,7 +1492,8 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
 			err = -ENOMEM;
 			goto __kctl_end;
 		}
-		if (copy_to_user(_tlv->tlv, kctl->tlv.p, len))
+		if (copy_to_user(_tlv->tlv, kctl->tlv.p, len) ||
+		    put_user(len, &_tlv->length))
 			err = -EFAULT;
 	}
       __kctl_end:
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index bb12615..dfc84ab 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2516,7 +2516,7 @@ static int pcm_chmap_ctl_get(struct snd_kcontrol *kcontrol,
  * expands the pre-defined channel maps in a form of TLV
  */
 static int pcm_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			     unsigned int size, unsigned int __user *tlv)
+			     unsigned int *size, unsigned int __user *tlv)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	const struct snd_pcm_chmap_elem *map;
@@ -2525,27 +2525,27 @@ static int pcm_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 
 	if (snd_BUG_ON(!info->chmap))
 		return -EINVAL;
-	if (size < 8)
+	if (*size < 8)
 		return -ENOMEM;
 	if (put_user(SNDRV_CTL_TLVT_CONTAINER, tlv))
 		return -EFAULT;
-	size -= 8;
+	*size -= 8;
 	dst = tlv + 2;
 	for (map = info->chmap; map->channels; map++) {
 		int chs_bytes = map->channels * 4;
 		if (!valid_chmap_channels(info, map->channels))
 			continue;
-		if (size < 8)
+		if (*size < 8)
 			return -ENOMEM;
 		if (put_user(SNDRV_CTL_TLVT_CHMAP_FIXED, dst) ||
 		    put_user(chs_bytes, dst + 1))
 			return -EFAULT;
 		dst += 2;
-		size -= 8;
+		*size -= 8;
 		count += 8;
-		if (size < chs_bytes)
+		if (*size < chs_bytes)
 			return -ENOMEM;
-		size -= chs_bytes;
+		*size -= chs_bytes;
 		count += chs_bytes;
 		for (c = 0; c < map->channels; c++) {
 			if (put_user(map->map[c], dst))
@@ -2555,6 +2555,7 @@ static int pcm_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	}
 	if (put_user(count, tlv + 1))
 		return -EFAULT;
+	*size = count + sizeof(unsigned int) * 2;
 	return 0;
 }
 
diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index 6c58e6f..03f4681 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -220,7 +220,7 @@ static int slave_put(struct snd_kcontrol *kcontrol,
 }
 
 static int slave_tlv_cmd(struct snd_kcontrol *kcontrol,
-			 int op_flag, unsigned int size,
+			 int op_flag, unsigned int *size,
 			 unsigned int __user *tlv)
 {
 	struct link_slave *slave = snd_kcontrol_chip(kcontrol);
diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index 81acc20..3163387 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -661,7 +661,7 @@ static int spk_mask_from_spk_alloc(int spk_alloc)
 }
 
 static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			      unsigned int size, unsigned int __user *tlv)
+			      unsigned int *size, unsigned int __user *tlv)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct hdac_chmap *chmap = info->private_data;
@@ -672,11 +672,11 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	int type;
 	int spk_alloc, spk_mask;
 
-	if (size < 8)
+	if (*size < 8)
 		return -ENOMEM;
 	if (put_user(SNDRV_CTL_TLVT_CONTAINER, tlv))
 		return -EFAULT;
-	size -= 8;
+	*size -= 8;
 	dst = tlv + 2;
 
 	spk_alloc = chmap->ops.get_spk_alloc(chmap->hdac, pcm_idx);
@@ -703,7 +703,7 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 							chmap, cap, chs);
 			if (type < 0)
 				return -ENODEV;
-			if (size < 8)
+			if (*size < 8)
 				return -ENOMEM;
 
 			if (put_user(type, dst) ||
@@ -711,13 +711,13 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 				return -EFAULT;
 
 			dst += 2;
-			size -= 8;
+			*size -= 8;
 			count += 8;
 
-			if (size < chs_bytes)
+			if (*size < chs_bytes)
 				return -ENOMEM;
 
-			size -= chs_bytes;
+			*size -= chs_bytes;
 			count += chs_bytes;
 			chmap->ops.cea_alloc_to_tlv_chmap(chmap, cap,
 						tlv_chmap, chs);
@@ -731,6 +731,8 @@ static int hdmi_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	if (put_user(count, tlv + 1))
 		return -EFAULT;
 
+	*size = count + sizeof(unsigned int) * 2;
+
 	return 0;
 }
 
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 9913be8..06d87e7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1420,7 +1420,7 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_volume_put);
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
  */
 int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			  unsigned int size, unsigned int __user *_tlv)
+			  unsigned int *size, unsigned int __user *_tlv)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	hda_nid_t nid = get_amp_nid(kcontrol);
@@ -1429,7 +1429,7 @@ int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	bool min_mute = get_amp_min_mute(kcontrol);
 	u32 caps, val1, val2;
 
-	if (size < 4 * sizeof(unsigned int))
+	if (*size < 4 * sizeof(unsigned int))
 		return -ENOMEM;
 	caps = query_amp_caps(codec, nid, dir);
 	val2 = (caps & AC_AMPCAP_STEP_SIZE) >> AC_AMPCAP_STEP_SIZE_SHIFT;
@@ -1447,6 +1447,9 @@ int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 		return -EFAULT;
 	if (put_user(val2, _tlv + 3))
 		return -EFAULT;
+
+	*size = sizeof(unsigned int) * 4;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_tlv);
@@ -1737,13 +1740,14 @@ static int get_kctl_0dB_offset(struct hda_codec *codec,
 {
 	int _tlv[4];
 	const int *tlv = NULL;
+	unsigned int size = sizeof(_tlv);
 	int val = -1;
 
 	if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
 		/* FIXME: set_fs() hack for obtaining user-space TLV data */
 		mm_segment_t fs = get_fs();
 		set_fs(get_ds());
-		if (!kctl->tlv.c(kctl, 0, sizeof(_tlv), _tlv))
+		if (!kctl->tlv.c(kctl, 0, &size, _tlv))
 			tlv = _tlv;
 		set_fs(fs);
 	} else if (kctl->vd[0].access & SNDRV_CTL_ELEM_ACCESS_TLV_READ)
@@ -2207,7 +2211,7 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_ctls_put);
  * set up via HDA_BIND_VOL() macro.
  */
 int snd_hda_mixer_bind_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			   unsigned int size, unsigned int __user *tlv)
+			   unsigned int *size, unsigned int __user *tlv)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_bind_ctls *c;
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index d0e066e..35ea160 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -113,7 +113,7 @@ int snd_hda_mixer_amp_volume_get(struct snd_kcontrol *kcontrol,
 int snd_hda_mixer_amp_volume_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol);
 int snd_hda_mixer_amp_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			  unsigned int size, unsigned int __user *tlv);
+			  unsigned int *size, unsigned int __user *tlv);
 int snd_hda_mixer_amp_switch_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo);
 int snd_hda_mixer_amp_switch_get(struct snd_kcontrol *kcontrol,
@@ -218,7 +218,7 @@ int snd_hda_mixer_bind_ctls_get(struct snd_kcontrol *kcontrol,
 int snd_hda_mixer_bind_ctls_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol);
 int snd_hda_mixer_bind_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			   unsigned int size, unsigned int __user *tlv);
+			   unsigned int *size, unsigned int __user *tlv);
 
 #define HDA_BIND_VOL(xname, bindrec) \
 	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9ceb2bc..bc8f342 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3868,7 +3868,7 @@ static int ca0132_volume_put(struct snd_kcontrol *kcontrol,
 }
 
 static int ca0132_volume_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			     unsigned int size, unsigned int __user *tlv)
+			     unsigned int *size, unsigned int __user *tlv)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct ca0132_spec *spec = codec->spec;
diff --git a/sound/pci/lola/lola_mixer.c b/sound/pci/lola/lola_mixer.c
index e7fe15d..ee92c31 100644
--- a/sound/pci/lola/lola_mixer.c
+++ b/sound/pci/lola/lola_mixer.c
@@ -553,14 +553,14 @@ static int lola_analog_vol_put(struct snd_kcontrol *kcontrol,
 }
 
 static int lola_analog_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			       unsigned int size, unsigned int __user *tlv)
+			       unsigned int *size, unsigned int __user *tlv)
 {
 	struct lola *chip = snd_kcontrol_chip(kcontrol);
 	int dir = kcontrol->private_value;
 	unsigned int val1, val2;
 	struct lola_pin *pin;
 
-	if (size < 4 * sizeof(unsigned int))
+	if (*size < 4 * sizeof(unsigned int))
 		return -ENOMEM;
 	pin = &chip->pin[dir].pins[0];
 
@@ -577,6 +577,9 @@ static int lola_analog_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 		return -EFAULT;
 	if (put_user(val2, tlv + 3))
 		return -EFAULT;
+
+	*size = 4 * sizeof(unsigned int);
+
 	return 0;
 }
 
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index a513a34..b2f3aa0 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -770,20 +770,21 @@ int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
 EXPORT_SYMBOL_GPL(snd_soc_bytes_info_ext);
 
 int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
-				unsigned int size, unsigned int __user *tlv)
+				unsigned int *size, unsigned int __user *tlv)
 {
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
-	unsigned int count = size < params->max ? size : params->max;
 	int ret = -ENXIO;
 
+	*size = min_t(int, *size, params->max);
+
 	switch (op_flag) {
 	case SNDRV_CTL_TLV_OP_READ:
 		if (params->get)
-			ret = params->get(kcontrol, tlv, count);
+			ret = params->get(kcontrol, tlv, *size);
 		break;
 	case SNDRV_CTL_TLV_OP_WRITE:
 		if (params->put)
-			ret = params->put(kcontrol, tlv, count);
+			ret = params->put(kcontrol, tlv, *size);
 		break;
 	}
 	return ret;
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 2f8c388..52a47bc 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -535,17 +535,20 @@ int snd_usb_set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
  * TLV callback for mixer volume controls
  */
 int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			 unsigned int size, unsigned int __user *_tlv)
+			 unsigned int *size, unsigned int __user *_tlv)
 {
 	struct usb_mixer_elem_info *cval = kcontrol->private_data;
 	DECLARE_TLV_DB_MINMAX(scale, 0, 0);
 
-	if (size < sizeof(scale))
+	if (*size < sizeof(scale))
 		return -ENOMEM;
 	scale[2] = cval->dBmin;
 	scale[3] = cval->dBmax;
 	if (copy_to_user(_tlv, scale, sizeof(scale)))
 		return -EFAULT;
+
+	*size = sizeof(scale);
+
 	return 0;
 }
 
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 3417ef3..ce4e236 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -84,7 +84,7 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 				 int unitid);
 
 int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			  unsigned int size, unsigned int __user *_tlv);
+			  unsigned int *size, unsigned int __user *_tlv);
 
 #ifdef CONFIG_PM
 int snd_usb_mixer_suspend(struct usb_mixer_interface *mixer);
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 8e9548bc..373d077 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -136,7 +136,7 @@ static bool have_dup_chmap(struct snd_usb_substream *subs,
 }
 
 static int usb_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			     unsigned int size, unsigned int __user *tlv)
+			     unsigned int *size, unsigned int __user *tlv)
 {
 	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_substream *subs = info->private_data;
@@ -144,11 +144,11 @@ static int usb_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	unsigned int __user *dst;
 	int count = 0;
 
-	if (size < 8)
+	if (*size < 8)
 		return -ENOMEM;
 	if (put_user(SNDRV_CTL_TLVT_CONTAINER, tlv))
 		return -EFAULT;
-	size -= 8;
+	*size -= 8;
 	dst = tlv + 2;
 	list_for_each_entry(fp, &subs->fmt_list, list) {
 		int i, ch_bytes;
@@ -159,7 +159,7 @@ static int usb_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			continue;
 		/* copy the entry */
 		ch_bytes = fp->chmap->channels * 4;
-		if (size < 8 + ch_bytes)
+		if (*size < 8 + ch_bytes)
 			return -ENOMEM;
 		if (put_user(SNDRV_CTL_TLVT_CHMAP_FIXED, dst) ||
 		    put_user(ch_bytes, dst + 1))
@@ -171,10 +171,13 @@ static int usb_chmap_ctl_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 		}
 
 		count += 8 + ch_bytes;
-		size -= 8 + ch_bytes;
+		*size -= 8 + ch_bytes;
 	}
 	if (put_user(count, tlv + 1))
 		return -EFAULT;
+
+	*size = count + sizeof(unsigned int) * 2;
+
 	return 0;
 }
 
-- 
2.7.4
