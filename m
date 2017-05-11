From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 03/26] ALSA: hda - Remove the generic bind
	ctl helpers
Date: Thu, 11 May 2017 23:09:02 +0200
Message-ID: <20170511210925.18208-4-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0A05266FD9
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:30 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 59DD1AEB2
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 21:09:30 +0000 (UTC)
In-Reply-To: <20170511210925.18208-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now all the users of this workaround code is gone, and we can finally
remove the legacy codes from the core HD-audio module.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 124 ----------------------------------------------
 sound/pci/hda/hda_local.h |  44 ----------------
 2 files changed, 168 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 29f243679a21..187a9c717fb5 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2117,130 +2117,6 @@ int snd_hda_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_switch_put);
 
-/**
- * snd_hda_mixer_bind_ctls_info - Info callback for a generic bound control
- * @kcontrol: referred ctl element
- * @uinfo: pointer to get/store the data
- *
- * The control element is supposed to have the private_value field
- * set up via HDA_BIND_VOL() or HDA_BIND_SW() macros.
- */
-int snd_hda_mixer_bind_ctls_info(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hda_bind_ctls *c;
-	int err;
-
-	mutex_lock(&codec->control_mutex);
-	c = (struct hda_bind_ctls *)kcontrol->private_value;
-	kcontrol->private_value = *c->values;
-	err = c->ops->info(kcontrol, uinfo);
-	kcontrol->private_value = (long)c;
-	mutex_unlock(&codec->control_mutex);
-	return err;
-}
-EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_ctls_info);
-
-/**
- * snd_hda_mixer_bind_ctls_get - Get callback for a generic bound control
- * @kcontrol: ctl element
- * @ucontrol: pointer to get/store the data
- *
- * The control element is supposed to have the private_value field
- * set up via HDA_BIND_VOL() or HDA_BIND_SW() macros.
- */
-int snd_hda_mixer_bind_ctls_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hda_bind_ctls *c;
-	int err;
-
-	mutex_lock(&codec->control_mutex);
-	c = (struct hda_bind_ctls *)kcontrol->private_value;
-	kcontrol->private_value = *c->values;
-	err = c->ops->get(kcontrol, ucontrol);
-	kcontrol->private_value = (long)c;
-	mutex_unlock(&codec->control_mutex);
-	return err;
-}
-EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_ctls_get);
-
-/**
- * snd_hda_mixer_bind_ctls_put - Put callback for a generic bound control
- * @kcontrol: ctl element
- * @ucontrol: pointer to get/store the data
- *
- * The control element is supposed to have the private_value field
- * set up via HDA_BIND_VOL() or HDA_BIND_SW() macros.
- */
-int snd_hda_mixer_bind_ctls_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hda_bind_ctls *c;
-	unsigned long *vals;
-	int err = 0, change = 0;
-
-	mutex_lock(&codec->control_mutex);
-	c = (struct hda_bind_ctls *)kcontrol->private_value;
-	for (vals = c->values; *vals; vals++) {
-		kcontrol->private_value = *vals;
-		err = c->ops->put(kcontrol, ucontrol);
-		if (err < 0)
-			break;
-		change |= err;
-	}
-	kcontrol->private_value = (long)c;
-	mutex_unlock(&codec->control_mutex);
-	return err < 0 ? err : change;
-}
-EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_ctls_put);
-
-/**
- * snd_hda_mixer_bind_tlv - TLV callback for a generic bound control
- * @kcontrol: ctl element
- * @op_flag: operation flag
- * @size: byte size of input TLV
- * @tlv: TLV data
- *
- * The control element is supposed to have the private_value field
- * set up via HDA_BIND_VOL() macro.
- */
-int snd_hda_mixer_bind_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			   unsigned int size, unsigned int __user *tlv)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hda_bind_ctls *c;
-	int err;
-
-	mutex_lock(&codec->control_mutex);
-	c = (struct hda_bind_ctls *)kcontrol->private_value;
-	kcontrol->private_value = *c->values;
-	err = c->ops->tlv(kcontrol, op_flag, size, tlv);
-	kcontrol->private_value = (long)c;
-	mutex_unlock(&codec->control_mutex);
-	return err;
-}
-EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_tlv);
-
-struct hda_ctl_ops snd_hda_bind_vol = {
-	.info = snd_hda_mixer_amp_volume_info,
-	.get = snd_hda_mixer_amp_volume_get,
-	.put = snd_hda_mixer_amp_volume_put,
-	.tlv = snd_hda_mixer_amp_tlv
-};
-EXPORT_SYMBOL_GPL(snd_hda_bind_vol);
-
-struct hda_ctl_ops snd_hda_bind_sw = {
-	.info = snd_hda_mixer_amp_switch_info,
-	.get = snd_hda_mixer_amp_switch_get,
-	.put = snd_hda_mixer_amp_switch_put,
-	.tlv = snd_hda_mixer_amp_tlv
-};
-EXPORT_SYMBOL_GPL(snd_hda_bind_sw);
-
 /*
  * SPDIF out controls
  */
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index b73339199a8b..5b5c324c99b9 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -178,50 +178,6 @@ void snd_hda_sync_vmaster_hook(struct hda_vmaster_mute_hook *hook);
 #define HDA_AMP_UNMUTE	0x00
 #define HDA_AMP_VOLMASK	0x7f
 
-/* more generic bound controls */
-struct hda_ctl_ops {
-	snd_kcontrol_info_t *info;
-	snd_kcontrol_get_t *get;
-	snd_kcontrol_put_t *put;
-	snd_kcontrol_tlv_rw_t *tlv;
-};
-
-extern struct hda_ctl_ops snd_hda_bind_vol;	/* for bind-volume with TLV */
-extern struct hda_ctl_ops snd_hda_bind_sw;	/* for bind-switch */
-
-struct hda_bind_ctls {
-	struct hda_ctl_ops *ops;
-	unsigned long values[];
-};
-
-int snd_hda_mixer_bind_ctls_info(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_info *uinfo);
-int snd_hda_mixer_bind_ctls_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol);
-int snd_hda_mixer_bind_ctls_put(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol);
-int snd_hda_mixer_bind_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			   unsigned int size, unsigned int __user *tlv);
-
-#define HDA_BIND_VOL(xname, bindrec) \
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
-	  .name = xname, \
-	  .access = SNDRV_CTL_ELEM_ACCESS_READWRITE |\
-			  SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-			  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK,\
-	  .info = snd_hda_mixer_bind_ctls_info,\
-	  .get =  snd_hda_mixer_bind_ctls_get,\
-	  .put = snd_hda_mixer_bind_ctls_put,\
-	  .tlv = { .c = snd_hda_mixer_bind_tlv },\
-	  .private_value = (long) (bindrec) }
-#define HDA_BIND_SW(xname, bindrec) \
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER,\
-	  .name = xname, \
-	  .info = snd_hda_mixer_bind_ctls_info,\
-	  .get =  snd_hda_mixer_bind_ctls_get,\
-	  .put = snd_hda_mixer_bind_ctls_put,\
-	  .private_value = (long) (bindrec) }
-
 /*
  * SPDIF I/O
  */
-- 
2.12.2
