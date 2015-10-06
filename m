From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 03/18] ALSA: hda: move hda_eld to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:40 +0100
Message-ID: <1444144075-28963-4-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DFB5265745
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:08:41 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Mover this driver to use newly moved snd_hdac_read/write_codec() and
snd_hdac_check_power_state APIs.

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_eld.c | 65 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 563984dd2562..3df0ef45c93d 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -150,7 +150,7 @@ static unsigned int hdmi_get_eld_data(struct hda_codec *codec, hda_nid_t nid,
 {
 	unsigned int val;
 
-	val = snd_hda_codec_read(codec, nid, 0,
+	val = snd_hdac_codec_read(&codec->core, nid, 0,
 					AC_VERB_GET_HDMI_ELDD, byte_index);
 #ifdef BE_PARANOID
 	codec_info(codec, "HDMI: ELD data byte %d: 0x%x\n", byte_index, val);
@@ -312,7 +312,7 @@ out_fail:
 
 int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid)
 {
-	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_HDMI_DIP_SIZE,
+	return snd_hdac_codec_read(&codec->core, nid, 0, AC_VERB_GET_HDMI_DIP_SIZE,
 						 AC_DIPSIZE_ELD_BUF);
 }
 
@@ -675,7 +675,8 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 
 	/* ATI/AMD does not have ELD, emulate it */
 
-	spkalloc = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SPEAKER_ALLOCATION, 0);
+	spkalloc = snd_hdac_codec_read(&codec->core, nid, 0,
+				       ATI_VERB_GET_SPEAKER_ALLOCATION, 0);
 
 	if (spkalloc <= 0) {
 		codec_info(codec, "HDMI ATI/AMD: no speaker allocation for ELD\n");
@@ -699,24 +700,44 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 	if (rev3_or_later) {
 		int sink_info;
 
-		snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_SINK_INFO_INDEX, ATI_INFO_IDX_PORT_ID_LOW);
-		sink_info = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SINK_INFO_DATA, 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     ATI_VERB_SET_SINK_INFO_INDEX,
+				     ATI_INFO_IDX_PORT_ID_LOW);
+		sink_info = snd_hdac_codec_read(&codec->core, nid, 0,
+						ATI_VERB_GET_SINK_INFO_DATA,
+						0);
 		put_unaligned_le32(sink_info, buf + 8);
 
-		snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_SINK_INFO_INDEX, ATI_INFO_IDX_PORT_ID_HIGH);
-		sink_info = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SINK_INFO_DATA, 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     ATI_VERB_SET_SINK_INFO_INDEX,
+				     ATI_INFO_IDX_PORT_ID_HIGH);
+		sink_info = snd_hdac_codec_read(&codec->core, nid, 0,
+						ATI_VERB_GET_SINK_INFO_DATA,
+						0);
 		put_unaligned_le32(sink_info, buf + 12);
 
-		snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_SINK_INFO_INDEX, ATI_INFO_IDX_MANUFACTURER_ID);
-		sink_info = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SINK_INFO_DATA, 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     ATI_VERB_SET_SINK_INFO_INDEX,
+				     ATI_INFO_IDX_MANUFACTURER_ID);
+		sink_info = snd_hdac_codec_read(&codec->core, nid, 0,
+						ATI_VERB_GET_SINK_INFO_DATA,
+						0);
 		put_unaligned_le16(sink_info, buf + 16);
 
-		snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_SINK_INFO_INDEX, ATI_INFO_IDX_PRODUCT_ID);
-		sink_info = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SINK_INFO_DATA, 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     ATI_VERB_SET_SINK_INFO_INDEX,
+				     ATI_INFO_IDX_PRODUCT_ID);
+		sink_info = snd_hdac_codec_read(&codec->core, nid, 0,
+						ATI_VERB_GET_SINK_INFO_DATA,
+						0);
 		put_unaligned_le16(sink_info, buf + 18);
 
-		snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_SINK_INFO_INDEX, ATI_INFO_IDX_SINK_DESC_LEN);
-		sink_desc_len = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SINK_INFO_DATA, 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     ATI_VERB_SET_SINK_INFO_INDEX,
+				     ATI_INFO_IDX_SINK_DESC_LEN);
+		sink_desc_len = snd_hdac_codec_read(&codec->core, nid, 0,
+						    ATI_VERB_GET_SINK_INFO_DATA,
+						    0);
 
 		if (sink_desc_len > ELD_MAX_MNL) {
 			codec_info(codec, "HDMI ATI/AMD: Truncating HDMI sink description with length %d\n",
@@ -727,8 +748,12 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 		buf[4] |= sink_desc_len;
 
 		for (i = 0; i < sink_desc_len; i++) {
-			snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_SINK_INFO_INDEX, ATI_INFO_IDX_SINK_DESC_FIRST + i);
-			buf[pos++] = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_SINK_INFO_DATA, 0);
+			snd_hdac_codec_write(&codec->core, nid, 0,
+					     ATI_VERB_SET_SINK_INFO_INDEX,
+					     ATI_INFO_IDX_SINK_DESC_FIRST + i);
+			buf[pos++] = snd_hdac_codec_read(&codec->core, nid, 0,
+							 ATI_VERB_GET_SINK_INFO_DATA,
+							 0);
 		}
 	}
 
@@ -736,8 +761,11 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 		if (i == AUDIO_CODING_TYPE_SACD || i == AUDIO_CODING_TYPE_DST)
 			continue; /* not handled by ATI/AMD */
 
-		snd_hda_codec_write(codec, nid, 0, ATI_VERB_SET_AUDIO_DESCRIPTOR, i << 3);
-		ati_sad = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_AUDIO_DESCRIPTOR, 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     ATI_VERB_SET_AUDIO_DESCRIPTOR, i << 3);
+		ati_sad = snd_hdac_codec_read(&codec->core, nid, 0,
+					      ATI_VERB_GET_AUDIO_DESCRIPTOR,
+					      0);
 
 		if (ati_sad <= 0)
 			continue;
@@ -778,7 +806,8 @@ int snd_hdmi_get_eld_ati(struct hda_codec *codec, hda_nid_t nid,
 	 *  [1..250]   msecs = x*2  (max 500ms with x = 250 = 0xfa)
 	 *  [251..255] reserved
 	 */
-	aud_synch = snd_hda_codec_read(codec, nid, 0, ATI_VERB_GET_AUDIO_VIDEO_DELAY, 0);
+	aud_synch = snd_hdac_codec_read(&codec->core, nid, 0,
+					ATI_VERB_GET_AUDIO_VIDEO_DELAY, 0);
 	if ((aud_synch & ATI_DELAY_VIDEO_LATENCY) && (aud_synch & ATI_DELAY_AUDIO_LATENCY)) {
 		int video_latency_hdmi = (aud_synch & ATI_DELAY_VIDEO_LATENCY);
 		int audio_latency_hdmi = (aud_synch & ATI_DELAY_AUDIO_LATENCY) >> 8;
-- 
2.4.3
