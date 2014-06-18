From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Kill snd_printd*() in HDMI
	debug / info prints
Date: Wed, 18 Jun 2014 16:35:31 +0200
Message-ID: <1403102132-1708-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DBCA261A0E
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 16:35:33 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B5B6DAC9C
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 14:35:32 +0000 (UTC)
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

Pass codec instance to each function that still prints info and debug
outputs via snd_printd*().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_eld.c    | 46 ++++++++++++++++++++++------------------------
 sound/pci/hda/hda_local.h  |  4 ++--
 sound/pci/hda/patch_hdmi.c | 11 ++++++-----
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 46690a7f48f6..e1cd34d9011d 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -167,7 +167,8 @@ static unsigned int hdmi_get_eld_data(struct hda_codec *codec, hda_nid_t nid,
 	(buf[byte] >> (lowbit)) & ((1 << (bits)) - 1);	\
 })
 
-static void hdmi_update_short_audio_desc(struct cea_sad *a,
+static void hdmi_update_short_audio_desc(struct hda_codec *codec,
+					 struct cea_sad *a,
 					 const unsigned char *buf)
 {
 	int i;
@@ -188,8 +189,7 @@ static void hdmi_update_short_audio_desc(struct cea_sad *a,
 	a->format = GRAB_BITS(buf, 0, 3, 4);
 	switch (a->format) {
 	case AUDIO_CODING_TYPE_REF_STREAM_HEADER:
-		snd_printd(KERN_INFO
-				"HDMI: audio coding type 0 not expected\n");
+		codec_info(codec, "HDMI: audio coding type 0 not expected\n");
 		break;
 
 	case AUDIO_CODING_TYPE_LPCM:
@@ -233,9 +233,9 @@ static void hdmi_update_short_audio_desc(struct cea_sad *a,
 		a->format = GRAB_BITS(buf, 2, 3, 5);
 		if (a->format == AUDIO_CODING_XTYPE_HE_REF_CT ||
 		    a->format >= AUDIO_CODING_XTYPE_FIRST_RESERVED) {
-			snd_printd(KERN_INFO
-				"HDMI: audio coding xtype %d not expected\n",
-				a->format);
+			codec_info(codec,
+				   "HDMI: audio coding xtype %d not expected\n",
+				   a->format);
 			a->format = 0;
 		} else
 			a->format += AUDIO_CODING_TYPE_HE_AAC -
@@ -247,7 +247,7 @@ static void hdmi_update_short_audio_desc(struct cea_sad *a,
 /*
  * Be careful, ELD buf could be totally rubbish!
  */
-int snd_hdmi_parse_eld(struct parsed_hdmi_eld *e,
+int snd_hdmi_parse_eld(struct hda_codec *codec, struct parsed_hdmi_eld *e,
 			  const unsigned char *buf, int size)
 {
 	int mnl;
@@ -256,8 +256,7 @@ int snd_hdmi_parse_eld(struct parsed_hdmi_eld *e,
 	e->eld_ver = GRAB_BITS(buf, 0, 3, 5);
 	if (e->eld_ver != ELD_VER_CEA_861D &&
 	    e->eld_ver != ELD_VER_PARTIAL) {
-		snd_printd(KERN_INFO "HDMI: Unknown ELD version %d\n",
-								e->eld_ver);
+		codec_info(codec, "HDMI: Unknown ELD version %d\n", e->eld_ver);
 		goto out_fail;
 	}
 
@@ -280,20 +279,20 @@ int snd_hdmi_parse_eld(struct parsed_hdmi_eld *e,
 	e->product_id	  = get_unaligned_le16(buf + 18);
 
 	if (mnl > ELD_MAX_MNL) {
-		snd_printd(KERN_INFO "HDMI: MNL is reserved value %d\n", mnl);
+		codec_info(codec, "HDMI: MNL is reserved value %d\n", mnl);
 		goto out_fail;
 	} else if (ELD_FIXED_BYTES + mnl > size) {
-		snd_printd(KERN_INFO "HDMI: out of range MNL %d\n", mnl);
+		codec_info(codec, "HDMI: out of range MNL %d\n", mnl);
 		goto out_fail;
 	} else
 		strlcpy(e->monitor_name, buf + ELD_FIXED_BYTES, mnl + 1);
 
 	for (i = 0; i < e->sad_count; i++) {
 		if (ELD_FIXED_BYTES + mnl + 3 * (i + 1) > size) {
-			snd_printd(KERN_INFO "HDMI: out of range SAD %d\n", i);
+			codec_info(codec, "HDMI: out of range SAD %d\n", i);
 			goto out_fail;
 		}
-		hdmi_update_short_audio_desc(e->sad + i,
+		hdmi_update_short_audio_desc(codec, e->sad + i,
 					buf + ELD_FIXED_BYTES + mnl + 3 * i);
 	}
 
@@ -394,7 +393,8 @@ static void hdmi_print_pcm_rates(int pcm, char *buf, int buflen)
 
 #define SND_PRINT_RATES_ADVISED_BUFSIZE	80
 
-static void hdmi_show_short_audio_desc(struct cea_sad *a)
+static void hdmi_show_short_audio_desc(struct hda_codec *codec,
+				       struct cea_sad *a)
 {
 	char buf[SND_PRINT_RATES_ADVISED_BUFSIZE];
 	char buf2[8 + SND_PRINT_BITS_ADVISED_BUFSIZE] = ", bits =";
@@ -412,12 +412,10 @@ static void hdmi_show_short_audio_desc(struct cea_sad *a)
 	else
 		buf2[0] = '\0';
 
-	_snd_printd(SND_PR_VERBOSE, "HDMI: supports coding type %s:"
-			" channels = %d, rates =%s%s\n",
-			cea_audio_coding_type_names[a->format],
-			a->channels,
-			buf,
-			buf2);
+	codec_dbg(codec,
+		  "HDMI: supports coding type %s: channels = %d, rates =%s%s\n",
+		  cea_audio_coding_type_names[a->format],
+		  a->channels, buf, buf2);
 }
 
 void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
@@ -432,22 +430,22 @@ void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen)
 	buf[j] = '\0';	/* necessary when j == 0 */
 }
 
-void snd_hdmi_show_eld(struct parsed_hdmi_eld *e)
+void snd_hdmi_show_eld(struct hda_codec *codec, struct parsed_hdmi_eld *e)
 {
 	int i;
 
-	_snd_printd(SND_PR_VERBOSE, "HDMI: detected monitor %s at connection type %s\n",
+	codec_dbg(codec, "HDMI: detected monitor %s at connection type %s\n",
 			e->monitor_name,
 			eld_connection_type_names[e->conn_type]);
 
 	if (e->spk_alloc) {
 		char buf[SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE];
 		snd_print_channel_allocation(e->spk_alloc, buf, sizeof(buf));
-		_snd_printd(SND_PR_VERBOSE, "HDMI: available speakers:%s\n", buf);
+		codec_dbg(codec, "HDMI: available speakers:%s\n", buf);
 	}
 
 	for (i = 0; i < e->sad_count; i++)
-		hdmi_show_short_audio_desc(e->sad + i);
+		hdmi_show_short_audio_desc(codec, e->sad + i);
 }
 
 #ifdef CONFIG_PROC_FS
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index e51d15529215..7820fd2d9ba8 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -738,9 +738,9 @@ struct hdmi_eld {
 int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
 int snd_hdmi_get_eld(struct hda_codec *codec, hda_nid_t nid,
 		     unsigned char *buf, int *eld_size);
-int snd_hdmi_parse_eld(struct parsed_hdmi_eld *e,
+int snd_hdmi_parse_eld(struct hda_codec *codec, struct parsed_hdmi_eld *e,
 		       const unsigned char *buf, int size);
-void snd_hdmi_show_eld(struct parsed_hdmi_eld *e);
+void snd_hdmi_show_eld(struct hda_codec *codec, struct parsed_hdmi_eld *e);
 void snd_hdmi_eld_update_pcm_info(struct parsed_hdmi_eld *e,
 			      struct hda_pcm_stream *hinfo);
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b4218a19df22..39f86fad0330 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -648,7 +648,8 @@ static int get_channel_allocation_order(int ca)
  *
  * TODO: it could select the wrong CA from multiple candidates.
 */
-static int hdmi_channel_allocation(struct hdmi_eld *eld, int channels)
+static int hdmi_channel_allocation(struct hda_codec *codec,
+				   struct hdmi_eld *eld, int channels)
 {
 	int i;
 	int ca = 0;
@@ -694,7 +695,7 @@ static int hdmi_channel_allocation(struct hdmi_eld *eld, int channels)
 	}
 
 	snd_print_channel_allocation(eld->info.spk_alloc, buf, sizeof(buf));
-	snd_printdd("HDMI: select CA 0x%x for %d-channel allocation: %s\n",
+	codec_dbg(codec, "HDMI: select CA 0x%x for %d-channel allocation: %s\n",
 		    ca, channels, buf);
 
 	return ca;
@@ -1135,7 +1136,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	if (!non_pcm && per_pin->chmap_set)
 		ca = hdmi_manual_channel_allocation(channels, per_pin->chmap);
 	else
-		ca = hdmi_channel_allocation(eld, channels);
+		ca = hdmi_channel_allocation(codec, eld, channels);
 	if (ca < 0)
 		ca = 0;
 
@@ -1561,13 +1562,13 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 			eld->eld_valid = false;
 		else {
 			memset(&eld->info, 0, sizeof(struct parsed_hdmi_eld));
-			if (snd_hdmi_parse_eld(&eld->info, eld->eld_buffer,
+			if (snd_hdmi_parse_eld(codec, &eld->info, eld->eld_buffer,
 						    eld->eld_size) < 0)
 				eld->eld_valid = false;
 		}
 
 		if (eld->eld_valid) {
-			snd_hdmi_show_eld(&eld->info);
+			snd_hdmi_show_eld(codec, &eld->info);
 			update_eld = true;
 		}
 		else if (repoll) {
-- 
1.9.3
