From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 3/3] ELD proc interface for HDMI sinks
Date: Tue, 18 Nov 2008 11:47:53 +0800
Message-ID: <20081118042642.594505496@linux.intel.com>
References: <20081118034750.445933681@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DF7F24466
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 05:26:55 +0100 (CET)
Content-Disposition: inline; filename=alsa-eld-proc.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Create /proc/asound/card<card_no>/eld#<codec_no> to reflect the audio
configurations and capabilities of the attached HDMI sink.

Some notes:

- Shall we show an empty file if the ELD content is not valid?
  Well it's not that simple. There could be partially populated ELD,
  and there may be malformed ELD provided by buggy drivers/monitors.
  So expose ELD as it is. 

- The ELD retrieval routines rely on the Intel HDA interface,
  others are/could be universal and independent ones.

- How do we name the proc file?
  If there are going to be two HDMI pins per codec, then the current naming
  scheme (eld#<codec no>) will fail. Luckily the user space dependencies should
  be minimal, so it would be trivial to do the rename if that happens.

- The ELD proc file content is designed to be easy for scripts and human reading.
  Its lines all have the pattern:
	  <item_name>\t[\t]*<item_value>
  where <item_name> is a keyword in c language, while <item_value> could be any
  contents, including white spaces. <item_value> could also be a null value.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_eld.c         |   74 ++++++++++++++++++++++++++++++
 sound/pci/hda/hda_local.h       |    9 +++
 sound/pci/hda/patch_intelhdmi.c |    2 
 3 files changed, 85 insertions(+)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
@@ -446,6 +446,8 @@ static int patch_intel_hdmi(struct hda_c
 	codec->spec = spec;
 	codec->patch_ops = intel_hdmi_patch_ops;
 
+	snd_hda_eld_proc_new(codec, &spec->sink);
+
 	return 0;
 }
 
--- sound-2.6.orig/sound/pci/hda/hda_eld.c
+++ sound-2.6/sound/pci/hda/hda_eld.c
@@ -452,3 +452,77 @@ void snd_hdmi_show_eld(struct sink_eld *
 	for (i = 0; i < e->sad_count; i++)
 		hdmi_show_short_audio_desc(e->sad + i);
 }
+
+#ifdef CONFIG_PROC_FS
+
+static void hdmi_print_sad_info(int i, struct cea_sad *a,
+				struct snd_info_buffer *buffer)
+{
+	char buf[80];
+
+	snd_iprintf(buffer, "sad%d_coding_type\t[0x%x] %s\n",
+			i, a->format, cea_audio_coding_type_names[a->format]);
+	snd_iprintf(buffer, "sad%d_channels\t\t%d\n", i, a->channels);
+
+	snd_print_pcm_rates(a->rates, buf, sizeof(buf));
+	snd_iprintf(buffer, "sad%d_sampling_rates\t[0x%x] %s\n",
+			i, a->rates, buf);
+
+	if (a->format == AUDIO_CODING_TYPE_LPCM)
+		snd_iprintf(buffer, "sad%d_sample_bits\t0x%x\n",
+							i, a->sample_bits);
+
+	if (a->max_bitrate)
+		snd_iprintf(buffer, "sad%d_max_bitrate\t%d\n",
+							i, a->max_bitrate);
+
+	if (a->profile)
+		snd_iprintf(buffer, "sad%d_profile\t\t%d\n", i, a->profile);
+}
+
+static void hdmi_print_eld_info(struct snd_info_entry *entry,
+				struct snd_info_buffer *buffer)
+{
+	struct sink_eld *e = entry->private_data;
+	char buf[HDMI_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
+	int i;
+
+	snd_iprintf(buffer, "monitor name\t\t%s\n", e->monitor_name);
+	snd_iprintf(buffer, "connection_type\t\t%s\n",
+				eld_connection_type_names[e->conn_type]);
+	snd_iprintf(buffer, "eld_version\t\t[0x%x] %s\n", e->eld_ver,
+					eld_versoin_names[e->eld_ver]);
+	snd_iprintf(buffer, "edid_version\t\t[0x%x] %s\n", e->cea_edid_ver,
+				cea_edid_version_names[e->cea_edid_ver]);
+	snd_iprintf(buffer, "manufacture_id\t\t0x%x\n", e->manufacture_id);
+	snd_iprintf(buffer, "product_id\t\t0x%x\n", e->product_id);
+	snd_iprintf(buffer, "port_id\t\t\t0x%llx\n", (long long)e->port_id);
+	snd_iprintf(buffer, "support_hdcp\t\t%d\n", e->support_hdcp);
+	snd_iprintf(buffer, "support_ai\t\t%d\n", e->support_ai);
+	snd_iprintf(buffer, "audio_sync_delay\t%d\n", e->aud_synch_delay);
+
+	hdmi_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
+	snd_iprintf(buffer, "speakers\t\t[0x%x] %s\n", e->spk_alloc, buf);
+
+	snd_iprintf(buffer, "sad_count\t\t%d\n", e->sad_count);
+
+	for (i = 0; i < e->sad_count; i++)
+		hdmi_print_sad_info(i, e->sad + i, buffer);
+}
+
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld)
+{
+	char name[32];
+	struct snd_info_entry *entry;
+	int err;
+
+	snprintf(name, sizeof(name), "eld#%d", codec->addr);
+	err = snd_card_proc_new(codec->bus->card, name, &entry);
+	if (err < 0)
+		return err;
+
+	snd_info_set_text_ops(entry, eld, hdmi_print_eld_info);
+	return 0;
+}
+
+#endif
--- sound-2.6.orig/sound/pci/hda/hda_local.h
+++ sound-2.6/sound/pci/hda/hda_local.h
@@ -484,4 +484,13 @@ int snd_hdmi_get_eld_size(struct hda_cod
 int snd_hdmi_get_eld(struct sink_eld *, struct hda_codec *, hda_nid_t);
 void snd_hdmi_show_eld(struct sink_eld *eld);
 
+#ifdef CONFIG_PROC_FS
+int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld);
+#else
+inline int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld)
+{
+	return 0;
+}
+#endif
+
 #endif /* __SOUND_HDA_LOCAL_H */

-- 
