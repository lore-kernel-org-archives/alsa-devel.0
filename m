From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v3 4/5] ALSA: hda - hdmi: Protect ELD buffer
Date: Tue, 19 Feb 2013 11:51:13 +0100
Message-ID: <1361271074-17555-5-git-send-email-david.henningsson@canonical.com>
References: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B75E42651FC
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 11:51:10 +0100 (CET)
In-Reply-To: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Because the eld buffer can be simultaneously accessed from both
workqueue context (updating) and process context (kcontrol read),
we need to protect it with a mutex to guarantee consistency.

To avoid holding the mutex while reading the ELD info from the
codec, we introduce a temporary eld buffer.
---
 sound/pci/hda/hda_eld.c    |    8 +++++++-
 sound/pci/hda/hda_local.h  |    1 +
 sound/pci/hda/patch_hdmi.c |   44 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index aecda72..439c2e6 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -507,10 +507,13 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
 		[4 ... 7] = "reserved"
 	};
 
+	mutex_lock(&eld->lock);
 	snd_iprintf(buffer, "monitor_present\t\t%d\n", eld->monitor_present);
 	snd_iprintf(buffer, "eld_valid\t\t%d\n", eld->eld_valid);
-	if (!eld->eld_valid)
+	if (!eld->eld_valid) {
+		mutex_unlock(&eld->lock);
 		return;
+	}
 	snd_iprintf(buffer, "monitor_name\t\t%s\n", e->monitor_name);
 	snd_iprintf(buffer, "connection_type\t\t%s\n",
 				eld_connection_type_names[e->conn_type]);
@@ -532,6 +535,7 @@ static void hdmi_print_eld_info(struct snd_info_entry *entry,
 
 	for (i = 0; i < e->sad_count; i++)
 		hdmi_print_sad_info(i, e->sad + i, buffer);
+	mutex_unlock(&eld->lock);
 }
 
 static void hdmi_write_eld_info(struct snd_info_entry *entry,
@@ -545,6 +549,7 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
 	long long val;
 	unsigned int n;
 
+	mutex_lock(&eld->lock);
 	while (!snd_info_get_line(buffer, line, sizeof(line))) {
 		if (sscanf(line, "%s %llx", name, &val) != 2)
 			continue;
@@ -596,6 +601,7 @@ static void hdmi_write_eld_info(struct snd_info_entry *entry,
 				e->sad_count = n + 1;
 		}
 	}
+	mutex_unlock(&eld->lock);
 }
 
 
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 11fd5f5..1f83dc3 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -739,6 +739,7 @@ struct hdmi_eld {
 	int	eld_size;
 	char    eld_buffer[ELD_MAX_SIZE];
 	struct parsed_hdmi_eld info;
+	struct mutex lock;
 #ifdef CONFIG_PROC_FS
 	struct snd_info_entry *proc_entry;
 #endif
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 2ac6635..0e1d69d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -91,6 +91,7 @@ struct hdmi_spec {
 	struct hda_pcm pcm_rec[MAX_HDMI_PINS];
 	unsigned int channels_max; /* max over all cvts */
 
+	struct hdmi_eld temp_eld;
 	/*
 	 * Non-generic ATI/NVIDIA specific
 	 */
@@ -352,7 +353,9 @@ static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
 	pin_idx = kcontrol->private_value;
 	eld = &spec->pins[pin_idx].sink_eld;
 
+	mutex_lock(&eld->lock);
 	uinfo->count = eld->eld_valid ? eld->eld_size : 0;
+	mutex_unlock(&eld->lock);
 
 	return 0;
 }
@@ -368,7 +371,9 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	pin_idx = kcontrol->private_value;
 	eld = &spec->pins[pin_idx].sink_eld;
 
+	mutex_lock(&eld->lock);
 	if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data)) {
+		mutex_unlock(&eld->lock);
 		snd_BUG();
 		return -EINVAL;
 	}
@@ -376,6 +381,7 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	if (eld->eld_valid)
 		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
 		       eld->eld_size);
+	mutex_unlock(&eld->lock);
 
 	return 0;
 }
@@ -1162,7 +1168,9 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_codec *codec = per_pin->codec;
-	struct hdmi_eld *eld = &per_pin->sink_eld;
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_eld *eld = &spec->temp_eld;
+	struct hdmi_eld *pin_eld = &per_pin->sink_eld;
 	hda_nid_t pin_nid = per_pin->pin_nid;
 	/*
 	 * Always execute a GetPinSense verb here, even when called from
@@ -1173,28 +1181,45 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	 * the unsolicited response to avoid custom WARs.
 	 */
 	int present = snd_hda_pin_sense(codec, pin_nid);
-	bool eld_valid = false;
+	bool update_eld = false;
+	bool eld_changed = false;
 
 	memset(eld, 0, offsetof(struct hdmi_eld, eld_buffer));
 
-	eld->monitor_present	= !!(present & AC_PINSENSE_PRESENCE);
-	if (eld->monitor_present)
-		eld_valid	= !!(present & AC_PINSENSE_ELDV);
+	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
+	if (pin_eld->monitor_present)
+		eld->eld_valid  = !!(present & AC_PINSENSE_ELDV);
 
 	_snd_printd(SND_PR_VERBOSE,
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
-		codec->addr, pin_nid, eld->monitor_present, eld_valid);
+		codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
 
-	eld->eld_valid = false;
-	if (eld_valid) {
-		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
+	if (eld->eld_valid) {
+		if (!snd_hdmi_get_eld(eld, codec, pin_nid)) {
 			snd_hdmi_show_eld(&eld->info);
+			update_eld = true;
+		}
 		else if (repoll) {
 			queue_delayed_work(codec->bus->workq,
 					   &per_pin->work,
 					   msecs_to_jiffies(300));
 		}
 	}
+
+	mutex_lock(&pin_eld->lock);
+	if (pin_eld->eld_valid && !eld->eld_valid)
+		update_eld = true;
+	if (update_eld) {
+		pin_eld->eld_valid = eld->eld_valid;
+		eld_changed = memcmp(pin_eld->eld_buffer, eld->eld_buffer,
+				     eld->eld_size) != 0;
+		if (eld_changed)
+			memcpy(pin_eld->eld_buffer, eld->eld_buffer,
+			       eld->eld_size);
+		pin_eld->eld_size = eld->eld_size;
+		pin_eld->info = eld->info;
+	}
+	mutex_unlock(&pin_eld->lock);
 }
 
 static void hdmi_repoll_eld(struct work_struct *work)
@@ -1662,6 +1687,7 @@ static int generic_hdmi_init_per_pins(struct hda_codec *codec)
 		struct hdmi_eld *eld = &per_pin->sink_eld;
 
 		per_pin->codec = codec;
+		mutex_init(&eld->lock);
 		INIT_DELAYED_WORK(&per_pin->work, hdmi_repoll_eld);
 		snd_hda_eld_proc_new(codec, eld, pin_idx);
 	}
-- 
1.7.9.5
