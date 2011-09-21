From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH] ALSA: hdmi: expose ELD control
Date: Tue, 20 Sep 2011 20:27:53 -0500
Message-ID: <1316568473-27178-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B6A4624BCF
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 03:28:35 +0200 (CEST)
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Applications may want to read ELD information to
understand what codecs are supported on the HDMI
receiver and handle the a-v delay for better lip-sync.

ELD information is exposed in a BYTES control named
"ELD <device name>".

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/hda_eld.c    |    9 ++--
 sound/pci/hda/hda_local.h  |    2 +
 sound/pci/hda/patch_hdmi.c |   91 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 28ce17d..8f16b20 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -335,21 +335,20 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
 		snd_printd(KERN_INFO "HDMI: ELD buf size is 0, force 128\n");
 		size = 128;
 	}
-	if (size < ELD_FIXED_BYTES || size > PAGE_SIZE) {
+	if (size < ELD_FIXED_BYTES || size > ELD_MAX_SIZE || size > PAGE_SIZE) {
 		snd_printd(KERN_INFO "HDMI: invalid ELD buf size %d\n", size);
 		return -ERANGE;
 	}
 
-	buf = kmalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	/* update info */
+	eld->eld_size = size;
+	buf = eld->eld_buffer;
 
 	for (i = 0; i < size; i++)
 		buf[i] = hdmi_get_eld_byte(codec, nid, i);
 
 	ret = hdmi_update_eld(eld, buf, size);
 
-	kfree(buf);
 	return ret;
 }
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 9ed4b0d..cd579a6 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -609,6 +609,7 @@ struct cea_sad {
 };
 
 #define ELD_FIXED_BYTES	20
+#define ELD_MAX_SIZE    256
 #define ELD_MAX_MNL	16
 #define ELD_MAX_SAD	16
 
@@ -633,6 +634,7 @@ struct hdmi_eld {
 	int	spk_alloc;
 	int	sad_count;
 	struct cea_sad sad[ELD_MAX_SAD];
+	char    eld_buffer[ELD_MAX_SIZE];
 #ifdef CONFIG_PROC_FS
 	struct snd_info_entry *proc_entry;
 #endif
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 19cb72d..a5b7245 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -324,6 +324,89 @@ static int cvt_nid_to_cvt_index(struct hdmi_spec *spec, hda_nid_t cvt_nid)
 	return -EINVAL;
 }
 
+static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hdmi_spec *spec;
+	struct hdmi_spec_per_pin *per_pin;
+	struct hdmi_eld *eld;
+	int pin_nid;
+	int pin_idx;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+
+	pin_nid = kcontrol->private_value;
+	spec = codec->spec;
+
+	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
+	if (pin_idx < 0) {
+		uinfo->count = 0;
+	} else {
+		per_pin = &spec->pins[pin_idx];
+		eld = &per_pin->sink_eld;
+		uinfo->count = eld->eld_size;
+	}
+	return 0;
+}
+
+static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hdmi_spec *spec;
+	struct hdmi_spec_per_pin *per_pin;
+	struct hdmi_eld *eld;
+	int pin_nid;
+	int pin_idx;
+
+	spec = codec->spec;
+	pin_nid = kcontrol->private_value;
+
+	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
+	if (pin_idx < 0) {
+		memset(ucontrol->value.bytes.data, 0, ELD_MAX_SIZE);
+	} else {
+		per_pin = &spec->pins[pin_idx];
+		eld = &per_pin->sink_eld;
+		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
+			(eld->eld_size > ELD_MAX_SIZE) ?
+			ELD_MAX_SIZE : eld->eld_size);
+	}
+	return 0;
+}
+
+static struct snd_kcontrol_new eld_bytes_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ELD ",
+	.info = hdmi_eld_ctl_info,
+	.get = hdmi_eld_ctl_get,
+};
+
+static int hdmi_create_eld_bytes_ctl(struct hda_codec *codec, hda_nid_t nid,
+				char *name)
+{
+	struct snd_kcontrol *kctl;
+	struct hdmi_spec *spec = codec->spec;
+	int pin_idx;
+	int err;
+
+	pin_idx = pin_nid_to_pin_index(spec, nid);
+	if (pin_idx < 0)
+		return -EINVAL;
+
+	kctl = snd_ctl_new1(&eld_bytes_ctl, codec);
+	if (!kctl)
+		return -ENOMEM;
+	err = snd_hda_ctl_add(codec, nid, kctl);
+	if (err < 0)
+		return err;
+	kctl->private_value = nid;
+	strcat(kctl->id.name, name);
+
+	return 0;
+}
+
 #ifdef BE_PARANOID
 static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
 				int *packet_index, int *byte_index)
@@ -1145,6 +1228,7 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hda_pcm *info;
 		struct hda_pcm_stream *pstr;
+		int ret;
 
 		info = &spec->pcm_rec[pin_idx];
 		info->name = generic_hdmi_pcm_names[pin_idx];
@@ -1154,6 +1238,13 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 		pstr->substreams = 1;
 		pstr->ops = generic_ops;
 		/* other pstr fields are set in open */
+
+		/* add control for ELD Bytes */
+		ret = hdmi_create_eld_bytes_ctl(codec,
+						spec->pins[pin_idx].pin_nid,
+						info->name);
+		if (ret < 0)
+			return ret;
 	}
 
 	codec->num_pcms = spec->num_pins;
-- 
1.7.6.2
