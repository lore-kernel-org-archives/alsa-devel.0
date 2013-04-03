From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH 2/2] ALSA: hda/ca0132 - Update latency based on
	DSP state.
Date: Wed,  3 Apr 2013 08:30:04 -0700
Message-ID: <1365003004-7680-2-git-send-email-dgreid@chromium.org>
References: <1365003004-7680-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f73.google.com (mail-oa0-f73.google.com
 [209.85.219.73])
 by alsa0.perex.cz (Postfix) with ESMTP id B2B2D265D70
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 17:30:16 +0200 (CEST)
Received: by mail-oa0-f73.google.com with SMTP id o6so401120oag.4
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 08:30:15 -0700 (PDT)
In-Reply-To: <1365003004-7680-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, ian_minett@creativelabs.com
List-Id: alsa-devel@alsa-project.org

The DSP in the CA0132 codec adds a variable latency to audio depending
on what processing is being done.  Add a new patch op to return that
latency for capture and playback streams.  The latency is determined
by which blocks are enabled and knowing how much latency is added by
each block.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 12eb21a..dbecb03 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -131,6 +131,13 @@ enum {
 /* Effects values size*/
 #define EFFECT_VALS_MAX_COUNT 12
 
+/* Latency introduced by DSP blocks in frames. */
+#define DSP_CAPTURE_INIT_LATENCY        0
+#define DSP_CRYSTAL_VOICE_LATENCY       124
+#define DSP_PLAYBACK_INIT_LATENCY       13
+#define DSP_PLAY_ENHANCEMENT_LATENCY    30
+#define DSP_SPEAKER_OUT_LATENCY         7
+
 struct ct_effect {
 	char name[44];
 	hda_nid_t nid;
@@ -4440,6 +4447,50 @@ static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
 	}
 }
 
+static unsigned int ca0132_get_playback_latency(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int latency = DSP_PLAYBACK_INIT_LATENCY;
+
+	/* Add latency if playback enhancement and either effect is enabled. */
+	if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID]) {
+		if ((spec->effects_switch[SURROUND - EFFECT_START_NID]) ||
+		    (spec->effects_switch[DIALOG_PLUS - EFFECT_START_NID]))
+			latency += DSP_PLAY_ENHANCEMENT_LATENCY;
+	}
+
+	/* Applying Speaker EQ adds latency as well. */
+	if (spec->cur_out_type == SPEAKER_OUT)
+		latency += DSP_SPEAKER_OUT_LATENCY;
+
+	return latency;
+}
+
+static unsigned int ca0132_get_capture_latency(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int latency = DSP_CAPTURE_INIT_LATENCY;
+
+	if (spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID])
+		latency += DSP_CRYSTAL_VOICE_LATENCY;
+
+	return latency;
+}
+
+static unsigned int ca0132_get_processing_delay(struct hda_codec *codec,
+						unsigned int stream)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return 0;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return ca0132_get_playback_latency(codec);
+
+	return ca0132_get_capture_latency(codec);
+}
+
 /*
  * Verbs tables.
  */
@@ -4617,6 +4668,7 @@ static struct hda_codec_ops ca0132_patch_ops = {
 	.init = ca0132_init,
 	.free = ca0132_free,
 	.unsol_event = ca0132_unsol_event,
+	.get_processing_delay = ca0132_get_processing_delay,
 };
 
 static void ca0132_config(struct hda_codec *codec)
-- 
1.8.1.5
