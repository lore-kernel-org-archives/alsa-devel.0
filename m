From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 4/7] ALSA: hda - hdmi: Fix unused slots being
	enabled in manual and non-PCM mappings
Date: Sat,  5 Oct 2013 02:25:41 +0300
Message-ID: <1380929144-24944-5-git-send-email-anssi.hannula@iki.fi>
References: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id C68D426170F
 for <alsa-devel@alsa-project.org>; Sat,  5 Oct 2013 01:26:11 +0200 (CEST)
In-Reply-To: <1380929144-24944-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hdmi_manual_setup_channel_mapping() and hdmi_std_setup_channel_mapping
try to assign ALSA channels to HDMI channel slots and disable (i.e.
silence) other slots.

However, they try to disable a slot by using AC_VERB_SET_CHAN_SLOT with
parameter ((alsa_ch << 8) | 0xf), while the correct parameter is
((0xf << 8) | hdmi_slot), i.e. the slot should be unassigned, not the
ALSA channel.

Fix that by actually disabling the unused slots.

Note that this bug did not cause any (reported) issues because slots
incorrectly having audio are normally ignored by a receiver if the CEA
channel allocation used does not map that slot to any speaker.
Additionally, the converter channel count configuration limits the
number of actually active channels in any case.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 sound/pci/hda/patch_hdmi.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ac818cb..30cf9a9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -624,9 +624,9 @@ static void hdmi_std_setup_channel_mapping(struct hda_codec *codec,
 
 	if (non_pcm) {
 		for (i = 0; i < ch_alloc->channels; i++)
-			non_pcm_mapping[i] = i | (i << 4);
+			non_pcm_mapping[i] = (i << 4) | i;
 		for (; i < 8; i++)
-			non_pcm_mapping[i] = 0xf | (i << 4);
+			non_pcm_mapping[i] = (0xf << 4) | i;
 	}
 
 	for (i = 0; i < 8; i++) {
@@ -680,7 +680,7 @@ static int to_cea_slot(unsigned char c)
 		if (t->map == c)
 			return t->cea_slot;
 	}
-	return 0x0f;
+	return -1;
 }
 
 /* from CEA slot to ALSA API channel position */
@@ -733,14 +733,23 @@ static int hdmi_manual_setup_channel_mapping(struct hda_codec *codec,
 					     hda_nid_t pin_nid,
 					     int chs, unsigned char *map)
 {
-	int i;
-	for (i = 0; i < 8; i++) {
+	int alsa_pos, hdmi_slot;
+	int assignments[8] = {[0 ... 7] = 0xf};
+
+	for (alsa_pos = 0; alsa_pos < chs; alsa_pos++) {
+
+		hdmi_slot = to_cea_slot(map[alsa_pos]);
+
+		if (hdmi_slot < 0)
+			continue; /* unassigned channel */
+
+		assignments[hdmi_slot] = alsa_pos;
+	}
+
+	for (hdmi_slot = 0; hdmi_slot < 8; hdmi_slot++) {
 		int val, err;
-		if (i < chs)
-			val = to_cea_slot(map[i]);
-		else
-			val = 0xf;
-		val |= (i << 4);
+
+		val = (assignments[hdmi_slot] << 4) | hdmi_slot;
 		err = snd_hda_codec_write(codec, pin_nid, 0,
 					  AC_VERB_SET_HDMI_CHAN_SLOT, val);
 		if (err)
-- 
1.8.1.5
