From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda: fix some klockwork scan warnings
Date: Thu, 16 Jun 2016 11:13:25 +0800
Message-ID: <1466046805-42594-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 15C662668B8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2016 05:15:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This patch fixes some warnings from klockwork.

These warnings are not the real issues. The patch
adds the sanity check.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/hda/hdmi_chmap.c     | 28 +++++++++++++++++++++++++---
 sound/pci/hda/hda_codec.c  |  8 +++++++-
 sound/pci/hda/patch_hdmi.c |  5 +++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index c6c75e7..81acc20 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -353,7 +353,8 @@ static void hdmi_std_setup_channel_mapping(struct hdac_chmap *chmap,
 		int hdmi_slot = 0;
 		/* fill actual channel mappings in ALSA channel (i) order */
 		for (i = 0; i < ch_alloc->channels; i++) {
-			while (!ch_alloc->speakers[7 - hdmi_slot] && !WARN_ON(hdmi_slot >= 8))
+			while (!WARN_ON(hdmi_slot >= 8) &&
+			       !ch_alloc->speakers[7 - hdmi_slot])
 				hdmi_slot++; /* skip zero slots */
 
 			hdmi_channel_mapping[ca][i] = (i << 4) | hdmi_slot++;
@@ -430,6 +431,12 @@ static int to_cea_slot(int ordered_ca, unsigned char pos)
 	int mask = snd_hdac_chmap_to_spk_mask(pos);
 	int i;
 
+	/* Add sanity check to pass klockwork check.
+	 * This should never happen.
+	 */
+	if (ordered_ca >= ARRAY_SIZE(channel_allocations))
+		return -1;
+
 	if (mask) {
 		for (i = 0; i < 8; i++) {
 			if (channel_allocations[ordered_ca].speakers[7 - i] == mask)
@@ -456,7 +463,15 @@ EXPORT_SYMBOL_GPL(snd_hdac_spk_to_chmap);
 /* from CEA slot to ALSA API channel position */
 static int from_cea_slot(int ordered_ca, unsigned char slot)
 {
-	int mask = channel_allocations[ordered_ca].speakers[7 - slot];
+	int mask;
+
+	/* Add sanity check to pass klockwork check.
+	 * This should never happen.
+	 */
+	if (slot >= 8)
+		return 0;
+
+	mask = channel_allocations[ordered_ca].speakers[7 - slot];
 
 	return snd_hdac_spk_to_chmap(mask);
 }
@@ -523,7 +538,8 @@ static void hdmi_setup_fake_chmap(unsigned char *map, int ca)
 	int ordered_ca = get_channel_allocation_order(ca);
 
 	for (i = 0; i < 8; i++) {
-		if (i < channel_allocations[ordered_ca].channels)
+		if (ordered_ca < ARRAY_SIZE(channel_allocations) &&
+		    i < channel_allocations[ordered_ca].channels)
 			map[i] = from_cea_slot(ordered_ca, hdmi_channel_mapping[ca][i] & 0x0f);
 		else
 			map[i] = 0;
@@ -551,6 +567,12 @@ int snd_hdac_get_active_channels(int ca)
 {
 	int ordered_ca = get_channel_allocation_order(ca);
 
+	/* Add sanity check to pass klockwork check.
+	 * This should never happen.
+	 */
+	if (ordered_ca >= ARRAY_SIZE(channel_allocations))
+		ordered_ca = 0;
+
 	return channel_allocations[ordered_ca].channels;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_get_active_channels);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8374188..9913be8 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3584,6 +3584,12 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 	bool reset;
 
 	spdif = snd_hda_spdif_out_of_nid(codec, nid);
+	/* Add sanity check to pass klockwork check.
+	 * This should never happen.
+	 */
+	if (WARN_ON(spdif == NULL))
+		return;
+
 	curr_fmt = snd_hda_codec_read(codec, nid, 0,
 				      AC_VERB_GET_STREAM_FORMAT, 0);
 	reset = codec->spdif_status_reset &&
@@ -3768,7 +3774,7 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 	spdif = snd_hda_spdif_out_of_nid(codec, mout->dig_out_nid);
 	if (mout->dig_out_nid && mout->share_spdif &&
 	    mout->dig_out_used != HDA_DIG_EXCLUSIVE) {
-		if (chs == 2 &&
+		if (chs == 2 && spdif != NULL &&
 		    snd_hda_is_supported_format(codec, mout->dig_out_nid,
 						format) &&
 		    !(spdif->status & IEC958_AES0_NONAUDIO)) {
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d0d5ad8..56e5204 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1680,6 +1680,11 @@ static bool check_non_pcm_per_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 
 	mutex_lock(&codec->spdif_mutex);
 	spdif = snd_hda_spdif_out_of_nid(codec, cvt_nid);
+	/* Add sanity check to pass klockwork check.
+	 * This should never happen.
+	 */
+	if (WARN_ON(spdif == NULL))
+		return true;
 	non_pcm = !!(spdif->status & IEC958_AES0_NONAUDIO);
 	mutex_unlock(&codec->spdif_mutex);
 	return non_pcm;
-- 
1.9.1
