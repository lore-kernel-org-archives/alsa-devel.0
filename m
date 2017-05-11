From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 02/26] ALSA: hda - Move bind-mixer switch
	codes to generic parser
Date: Thu, 11 May 2017 23:09:01 +0200
Message-ID: <20170511210925.18208-3-tiwai@suse.de>
References: <20170511210925.18208-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F6B5266FD4
 for <alsa-devel@alsa-project.org>; Thu, 11 May 2017 23:09:30 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 52791AEB1
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

The generic parser is the only user of the bind-mixer controls, so we
can move the code there and clean up the core helper.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c   | 66 ---------------------------------------------
 sound/pci/hda/hda_generic.c | 46 +++++++++++++++++++++++++++++--
 sound/pci/hda/hda_local.h   | 17 ------------
 3 files changed, 44 insertions(+), 85 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 70bb365a08d2..29f243679a21 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2117,72 +2117,6 @@ int snd_hda_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_switch_put);
 
-/*
- * bound volume controls
- *
- * bind multiple volumes (# indices, from 0)
- */
-
-#define AMP_VAL_IDX_SHIFT	19
-#define AMP_VAL_IDX_MASK	(0x0f<<19)
-
-/**
- * snd_hda_mixer_bind_switch_get - Get callback for a bound volume control
- * @kcontrol: ctl element
- * @ucontrol: pointer to get/store the data
- *
- * The control element is supposed to have the private_value field
- * set up via HDA_BIND_MUTE*() macros.
- */
-int snd_hda_mixer_bind_switch_get(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned long pval;
-	int err;
-
-	mutex_lock(&codec->control_mutex);
-	pval = kcontrol->private_value;
-	kcontrol->private_value = pval & ~AMP_VAL_IDX_MASK; /* index 0 */
-	err = snd_hda_mixer_amp_switch_get(kcontrol, ucontrol);
-	kcontrol->private_value = pval;
-	mutex_unlock(&codec->control_mutex);
-	return err;
-}
-EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_switch_get);
-
-/**
- * snd_hda_mixer_bind_switch_put - Put callback for a bound volume control
- * @kcontrol: ctl element
- * @ucontrol: pointer to get/store the data
- *
- * The control element is supposed to have the private_value field
- * set up via HDA_BIND_MUTE*() macros.
- */
-int snd_hda_mixer_bind_switch_put(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	unsigned long pval;
-	int i, indices, err = 0, change = 0;
-
-	mutex_lock(&codec->control_mutex);
-	pval = kcontrol->private_value;
-	indices = (pval & AMP_VAL_IDX_MASK) >> AMP_VAL_IDX_SHIFT;
-	for (i = 0; i < indices; i++) {
-		kcontrol->private_value = (pval & ~AMP_VAL_IDX_MASK) |
-			(i << AMP_VAL_IDX_SHIFT);
-		err = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
-		if (err < 0)
-			break;
-		change |= err;
-	}
-	kcontrol->private_value = pval;
-	mutex_unlock(&codec->control_mutex);
-	return err < 0 ? err : change;
-}
-EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_switch_put);
-
 /**
  * snd_hda_mixer_bind_ctls_info - Info callback for a generic bound control
  * @kcontrol: referred ctl element
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 2842c82363c0..557ecfcad158 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -948,6 +948,8 @@ static void resume_path_from_idx(struct hda_codec *codec, int path_idx)
 
 static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol);
+static int hda_gen_bind_mute_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol);
 static int hda_gen_bind_mute_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol);
 
@@ -970,7 +972,7 @@ static const struct snd_kcontrol_new control_templates[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.info = snd_hda_mixer_amp_switch_info,
-		.get = snd_hda_mixer_bind_switch_get,
+		.get = hda_gen_bind_mute_get,
 		.put = hda_gen_bind_mute_put, /* replaced */
 		.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0),
 	},
@@ -1101,11 +1103,51 @@ static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
 	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
 }
 
+/*
+ * Bound mute controls
+ */
+#define AMP_VAL_IDX_SHIFT	19
+#define AMP_VAL_IDX_MASK	(0x0f<<19)
+
+static int hda_gen_bind_mute_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned long pval;
+	int err;
+
+	mutex_lock(&codec->control_mutex);
+	pval = kcontrol->private_value;
+	kcontrol->private_value = pval & ~AMP_VAL_IDX_MASK; /* index 0 */
+	err = snd_hda_mixer_amp_switch_get(kcontrol, ucontrol);
+	kcontrol->private_value = pval;
+	mutex_unlock(&codec->control_mutex);
+	return err;
+}
+
 static int hda_gen_bind_mute_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned long pval;
+	int i, indices, err = 0, change = 0;
+
 	sync_auto_mute_bits(kcontrol, ucontrol);
-	return snd_hda_mixer_bind_switch_put(kcontrol, ucontrol);
+
+	mutex_lock(&codec->control_mutex);
+	pval = kcontrol->private_value;
+	indices = (pval & AMP_VAL_IDX_MASK) >> AMP_VAL_IDX_SHIFT;
+	for (i = 0; i < indices; i++) {
+		kcontrol->private_value = (pval & ~AMP_VAL_IDX_MASK) |
+			(i << AMP_VAL_IDX_SHIFT);
+		err = snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
+		if (err < 0)
+			break;
+		change |= err;
+	}
+	kcontrol->private_value = pval;
+	mutex_unlock(&codec->control_mutex);
+	return err < 0 ? err : change;
 }
 
 /* any ctl assigned to the path with the given index? */
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index d0e066e4c985..b73339199a8b 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -178,23 +178,6 @@ void snd_hda_sync_vmaster_hook(struct hda_vmaster_mute_hook *hook);
 #define HDA_AMP_UNMUTE	0x00
 #define HDA_AMP_VOLMASK	0x7f
 
-/* mono switch binding multiple inputs */
-#define HDA_BIND_MUTE_MONO(xname, nid, channel, indices, direction) \
-	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
-	  .info = snd_hda_mixer_amp_switch_info, \
-	  .get = snd_hda_mixer_bind_switch_get, \
-	  .put = snd_hda_mixer_bind_switch_put, \
-	  .private_value = HDA_COMPOSE_AMP_VAL(nid, channel, indices, direction) }
-
-/* stereo switch binding multiple inputs */
-#define HDA_BIND_MUTE(xname,nid,indices,dir) \
-	HDA_BIND_MUTE_MONO(xname,nid,3,indices,dir)
-
-int snd_hda_mixer_bind_switch_get(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol);
-int snd_hda_mixer_bind_switch_put(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol);
-
 /* more generic bound controls */
 struct hda_ctl_ops {
 	snd_kcontrol_info_t *info;
-- 
2.12.2
