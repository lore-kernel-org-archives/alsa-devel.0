From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hda - Move mutex from hda_eld to
	per_pin in HDMI codec driver
Date: Thu, 17 Oct 2013 18:32:34 +0200
Message-ID: <1382027554-12370-3-git-send-email-tiwai@suse.de>
References: <1382027554-12370-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE8702602F3
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 18:29:36 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B186FA59BE
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 18:29:36 +0200 (CEST)
In-Reply-To: <1382027554-12370-1-git-send-email-tiwai@suse.de>
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

Since the lock is used primarily in patch_hdmi.c, it's better to move
it in the local struct instead of exporting in hda_eld.  The only
functions requiring the lock in hda_eld.c are proc accessors.  So in
this patch, the proc entry and its creation/deletion/accessors are
moved into patch_hdmi.c, together with the mutex lock to pin_spec
struct.

The former proc info functions are exported so that they can be called
from patch_hdmi.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_eld.c    |  48 +++-----------------
 sound/pci/hda/hda_local.h  |  22 ++-------
 sound/pci/hda/patch_hdmi.c | 108 ++++++++++++++++++++++++++++++++++++---------
 3 files changed, 97 insertions(+), 81 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index d0d7ac1..f62356c 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -478,10 +478,9 @@ static void hdmi_print_sad_info(int i, struct cea_sad *a,
 		snd_iprintf(buffer, "sad%d_profile\t\t%d\n", i, a->profile);
 }
 
-static void hdmi_print_eld_info(struct snd_info_entry *entry,
-				struct snd_info_buffer *buffer)
+void snd_hdmi_print_eld_info(struct hdmi_eld *eld,
+			     struct snd_info_buffer *buffer)
 {
-	struct hdmi_eld *eld = entry->private_data;
 	struct parsed_hdmi_eld *e = &eld->info;
 	char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 	int i;
@@ -500,13 +499,10 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
 		[4 ... 7] = "reserved"
 	};
 
-	mutex_lock(&eld->lock);
 	snd_iprintf(buffer, "monitor_present\t\t%d\n", eld->monitor_present);
 	snd_iprintf(buffer, "eld_valid\t\t%d\n", eld->eld_valid);
-	if (!eld->eld_valid) {
-		mutex_unlock(&eld->lock);
+	if (!eld->eld_valid)
 		return;
-	}
 	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
 	snd_iprintf(buffer, "connection_type\t\t%s\n",
 				eld_connection_type_names[e->conn_type]);
@@ -528,13 +524,11 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
 
 	for (i = 0; i < e->sad_count; i++)
 		hdmi_print_sad_info(i, e->sad + i, buffer);
-	mutex_unlock(&eld->lock);
 }
 
-static void hdmi_write_eld_info(struct snd_info_entry *entry,
-				struct snd_info_buffer *buffer)
+void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
+			     struct snd_info_buffer *buffer)
 {
-	struct hdmi_eld *eld = entry->private_data;
 	struct parsed_hdmi_eld *e = &eld->info;
 	char line[64];
 	char name[64];
@@ -542,7 +536,6 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
 	long long val;
 	unsigned int n;
 
-	mutex_lock(&eld->lock);
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%s %llx", name, &val) != 2)
 			continue;
@@ -594,38 +587,7 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
 				e->sad_count = n + 1;
 		}
 	}
-	mutex_unlock(&eld->lock);
-}
-
-
-int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld,
-			 int index)
-{
-	char name[32];
-	struct snd_info_entry *entry;
-	int err;
-
-	snprintf(name, sizeof(name), "eld#%d.%d", codec->addr, index);
-	err = snd_card_proc_new(codec->bus->card, name, &entry);
-	if (err < 0)
-		return err;
-
-	snd_info_set_text_ops(entry, eld, hdmi_print_eld_info);
-	entry->c.text.write = hdmi_write_eld_info;
-	entry->mode |= S_IWUSR;
-	eld->proc_entry = entry;
-
-	return 0;
-}
-
-void snd_hda_eld_proc_free(struct hda_codec *codec, struct hdmi_eld *eld)
-{
-	if (!codec->bus->shutdown && eld->proc_entry) {
-		snd_device_free(codec->bus->card, eld->proc_entry);
-		eld->proc_entry = NULL;
-	}
 }
-
 #endif /* CONFIG_PROC_FS */
 
 /* update PCM info based on ELD */
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index a71bf34..46cddd4 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -752,10 +752,6 @@ struct hdmi_eld {
 	int	eld_size;
 	char    eld_buffer[ELD_MAX_SIZE];
 	struct parsed_hdmi_eld info;
-	struct mutex lock;
-#ifdef CONFIG_PROC_FS
-	struct snd_info_entry *proc_entry;
-#endif
 };
 
 int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
@@ -768,20 +764,10 @@ void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_eld *e,
 			      struct hda_pcm_stream *hinfo);
 
 #ifdef CONFIG_PROC_FS
-int snd_hda_eld_proc_new(struct hda_codec *codec, struct hdmi_eld *eld,
-			 int index);
-void snd_hda_eld_proc_free(struct hda_codec *codec, struct hdmi_eld *eld);
-#else
-static inline int snd_hda_eld_proc_new(struct hda_codec *codec,
-				       struct hdmi_eld *eld,
-				       int index)
-{
-	return 0;
-}
-static inline void snd_hda_eld_proc_free(struct hda_codec *codec,
-					 struct hdmi_eld *eld)
-{
-}
+void snd_hdmi_print_eld_info(struct hdmi_eld *eld,
+			     struct snd_info_buffer *buffer);
+void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
+			     struct snd_info_buffer *buffer);
 #endif
 
 #define SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE 80
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c2bad95..804adb8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -67,6 +67,7 @@ struct hdmi_spec_per_pin {
 
 	struct hda_codec *codec;
 	struct hdmi_eld sink_eld;
+	struct mutex lock;
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
 	int repoll_count;
@@ -76,6 +77,9 @@ struct hdmi_spec_per_pin {
 	bool chmap_set;		/* channel-map override by ALSA API? */
 	unsigned char chmap[8]; /* ALSA API channel-map */
 	char pcm_name[8];	/* filled in build_pcm callbacks */
+#ifdef CONFIG_PROC_FS
+	struct snd_info_entry *proc_entry;
+#endif
 };
 
 struct hdmi_spec {
@@ -349,17 +353,19 @@ static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin;
 	struct hdmi_eld *eld;
 	int pin_idx;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 
 	pin_idx = kcontrol->private_value;
-	eld = &get_pin(spec, pin_idx)->sink_eld;
+	per_pin = get_pin(spec, pin_idx);
+	eld = &per_pin->sink_eld;
 
-	mutex_lock(&eld->lock);
+	mutex_lock(&per_pin->lock);
 	uinfo->count = eld->eld_valid ? eld->eld_size : 0;
-	mutex_unlock(&eld->lock);
+	mutex_unlock(&per_pin->lock);
 
 	return 0;
 }
@@ -369,15 +375,17 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin;
 	struct hdmi_eld *eld;
 	int pin_idx;
 
 	pin_idx = kcontrol->private_value;
-	eld = &get_pin(spec, pin_idx)->sink_eld;
+	per_pin = get_pin(spec, pin_idx);
+	eld = &per_pin->sink_eld;
 
-	mutex_lock(&eld->lock);
+	mutex_lock(&per_pin->lock);
 	if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data)) {
-		mutex_unlock(&eld->lock);
+		mutex_unlock(&per_pin->lock);
 		snd_BUG();
 		return -EINVAL;
 	}
@@ -387,7 +395,7 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	if (eld->eld_valid)
 		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
 		       eld->eld_size);
-	mutex_unlock(&eld->lock);
+	mutex_unlock(&per_pin->lock);
 
 	return 0;
 }
@@ -478,6 +486,68 @@ static void hdmi_set_channel_count(struct hda_codec *codec,
 				    AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
 }
 
+/*
+ * ELD proc files
+ */
+
+#ifdef CONFIG_PROC_FS
+static void print_eld_info(struct snd_info_entry *entry,
+			   struct snd_info_buffer *buffer)
+{
+	struct hdmi_spec_per_pin *per_pin = entry->private_data;
+
+	mutex_lock(&per_pin->lock);
+	snd_hdmi_print_eld_info(&per_pin->sink_eld, buffer);
+	mutex_unlock(&per_pin->lock);
+}
+
+static void write_eld_info(struct snd_info_entry *entry,
+			   struct snd_info_buffer *buffer)
+{
+	struct hdmi_spec_per_pin *per_pin = entry->private_data;
+
+	mutex_lock(&per_pin->lock);
+	snd_hdmi_write_eld_info(&per_pin->sink_eld, buffer);
+	mutex_unlock(&per_pin->lock);
+}
+
+static int eld_proc_new(struct hdmi_spec_per_pin *per_pin, int index)
+{
+	char name[32];
+	struct hda_codec *codec = per_pin->codec;
+	struct snd_info_entry *entry;
+	int err;
+
+	snprintf(name, sizeof(name), "eld#%d.%d", codec->addr, index);
+	err = snd_card_proc_new(codec->bus->card, name, &entry);
+	if (err < 0)
+		return err;
+
+	snd_info_set_text_ops(entry, per_pin, print_eld_info);
+	entry->c.text.write = write_eld_info;
+	entry->mode |= S_IWUSR;
+	per_pin->proc_entry = entry;
+
+	return 0;
+}
+
+static void eld_proc_free(struct hdmi_spec_per_pin *per_pin)
+{
+	if (!per_pin->codec->bus->shutdown && per_pin->proc_entry) {
+		snd_device_free(per_pin->codec->bus->card, per_pin->proc_entry);
+		per_pin->proc_entry = NULL;
+	}
+}
+#else
+static inline int snd_hda_eld_proc_new(struct hdmi_spec_per_pin *per_pin,
+				       int index)
+{
+	return 0;
+}
+static inline void snd_hda_eld_proc_free(struct hdmi_spec_per_pin *per_pin)
+{
+}
+#endif
 
 /*
  * Channel mapping routines
@@ -1342,7 +1412,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	bool update_eld = false;
 	bool eld_changed = false;
 
-	mutex_lock(&pin_eld->lock);
+	mutex_lock(&per_pin->lock);
 	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
 	if (pin_eld->monitor_present)
 		eld->eld_valid  = !!(present & AC_PINSENSE_ELDV);
@@ -1406,7 +1476,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 			       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
 			       &per_pin->eld_ctl->id);
  unlock:
-	mutex_unlock(&pin_eld->lock);
+	mutex_unlock(&per_pin->lock);
 }
 
 static void hdmi_repoll_eld(struct work_struct *work)
@@ -1577,12 +1647,12 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	bool non_pcm;
 
 	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
-	mutex_lock(&per_pin->sink_eld.lock);
+	mutex_lock(&per_pin->lock);
 	per_pin->channels = substream->runtime->channels;
 	per_pin->setup = true;
 
 	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
-	mutex_unlock(&per_pin->sink_eld.lock);
+	mutex_unlock(&per_pin->lock);
 
 	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
 }
@@ -1621,13 +1691,13 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 
 		snd_hda_spdif_ctls_unassign(codec, pin_idx);
 
-		mutex_lock(&per_pin->sink_eld.lock);
+		mutex_lock(&per_pin->lock);
 		per_pin->chmap_set = false;
 		memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
 
 		per_pin->setup = false;
 		per_pin->channels = 0;
-		mutex_unlock(&per_pin->sink_eld.lock);
+		mutex_unlock(&per_pin->lock);
 	}
 
 	return 0;
@@ -1756,12 +1826,12 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	ca = hdmi_manual_channel_allocation(ARRAY_SIZE(chmap), chmap);
 	if (ca < 0)
 		return -EINVAL;
-	mutex_lock(&per_pin->sink_eld.lock);
+	mutex_lock(&per_pin->lock);
 	per_pin->chmap_set = true;
 	memcpy(per_pin->chmap, chmap, sizeof(chmap));
 	if (prepared)
 		hdmi_setup_audio_infoframe(codec, per_pin, per_pin->non_pcm);
-	mutex_unlock(&per_pin->sink_eld.lock);
+	mutex_unlock(&per_pin->lock);
 
 	return 0;
 }
@@ -1878,12 +1948,11 @@ static int generic_hdmi_init_per_pins(struct hda_codec *codec)
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-		struct hdmi_eld *eld = &per_pin->sink_eld;
 
 		per_pin->codec = codec;
-		mutex_init(&eld->lock);
+		mutex_init(&per_pin->lock);
 		INIT_DELAYED_WORK(&per_pin->work, hdmi_repoll_eld);
-		snd_hda_eld_proc_new(codec, eld, pin_idx);
+		eld_proc_new(per_pin, pin_idx);
 	}
 	return 0;
 }
@@ -1924,10 +1993,9 @@ static void generic_hdmi_free(struct hda_codec *codec)
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
-		struct hdmi_eld *eld = &per_pin->sink_eld;
 
 		cancel_delayed_work(&per_pin->work);
-		snd_hda_eld_proc_free(codec, eld);
+		eld_proc_free(per_pin);
 	}
 
 	flush_workqueue(codec->bus->workq);
-- 
1.8.4
