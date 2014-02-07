From: Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH 1/2] ALSA: hda/ca0132 - setup/cleanup streams
Date: Fri,  7 Feb 2014 11:35:29 +0800
Message-ID: <1391744130-15043-1-git-send-email-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f202.google.com (mail-ob0-f202.google.com
 [209.85.214.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 884A5261AAF
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 04:36:07 +0100 (CET)
Received: by mail-ob0-f202.google.com with SMTP id vb8so712595obc.5
 for <alsa-devel@alsa-project.org>; Thu, 06 Feb 2014 19:36:06 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>, Takashi Iwai <tiwai@suse.de>, Chih-Chung Chang <chihchung@chromium.org>, linux-kernel@vger.kernel.org, Hsin-Yu Chao <hychao@chromium.org>, Dylan Reid <dgreid@chromium.org>, Xi Wang <xi.wang@gmail.com>
List-Id: alsa-devel@alsa-project.org

When a HDMI stream is opened with the same stream tag
as a following opened stream to ca0132, audio will be
heard from two ports simultaneously.
Fix this issue by change to use snd_hda_codec_setup_stream
and snd_hda_codec_cleanup_stream instead, so that an
inactive stream can be marked as 'dirty' when found
with a conflict stream tag, and then get purified.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Reviewed-by: Chih-Chung Chang <chihchung@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 68 ++++++--------------------------------------
 1 file changed, 9 insertions(+), 59 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 54d1479..59104dc 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2662,60 +2662,6 @@ static bool dspload_wait_loaded(struct hda_codec *codec)
 }
 
 /*
- * PCM stuffs
- */
-static void ca0132_setup_stream(struct hda_codec *codec, hda_nid_t nid,
-				 u32 stream_tag,
-				 int channel_id, int format)
-{
-	unsigned int oldval, newval;
-
-	if (!nid)
-		return;
-
-	snd_printdd(
-		   "ca0132_setup_stream: NID=0x%x, stream=0x%x, "
-		   "channel=%d, format=0x%x\n",
-		   nid, stream_tag, channel_id, format);
-
-	/* update the format-id if changed */
-	oldval = snd_hda_codec_read(codec, nid, 0,
-				    AC_VERB_GET_STREAM_FORMAT,
-				    0);
-	if (oldval != format) {
-		msleep(20);
-		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_STREAM_FORMAT,
-				    format);
-	}
-
-	oldval = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
-	newval = (stream_tag << 4) | channel_id;
-	if (oldval != newval) {
-		snd_hda_codec_write(codec, nid, 0,
-				    AC_VERB_SET_CHANNEL_STREAMID,
-				    newval);
-	}
-}
-
-static void ca0132_cleanup_stream(struct hda_codec *codec, hda_nid_t nid)
-{
-	unsigned int val;
-
-	if (!nid)
-		return;
-
-	snd_printdd(KERN_INFO "ca0132_cleanup_stream: NID=0x%x\n", nid);
-
-	val = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
-	if (!val)
-		return;
-
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_STREAM_FORMAT, 0);
-	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CHANNEL_STREAMID, 0);
-}
-
-/*
  * PCM callbacks
  */
 static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -2726,7 +2672,9 @@ static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 {
 	struct ca0132_spec *spec = codec->spec;
 
-	ca0132_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
+	ca0132_toggle_dac_format(codec);
+
+	snd_hda_codec_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
 
 	return 0;
 }
@@ -2745,7 +2693,7 @@ static int ca0132_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
 		msleep(50);
 
-	ca0132_cleanup_stream(codec, spec->dacs[0]);
+	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
 
 	return 0;
 }
@@ -2824,8 +2772,8 @@ static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 {
 	struct ca0132_spec *spec = codec->spec;
 
-	ca0132_setup_stream(codec, spec->adcs[substream->number],
-			    stream_tag, 0, format);
+	snd_hda_codec_setup_stream(codec, spec->adcs[substream->number],
+				   stream_tag, 0, format);
 
 	return 0;
 }
@@ -2839,7 +2787,7 @@ static int ca0132_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	if (spec->dsp_state == DSP_DOWNLOADING)
 		return 0;
 
-	ca0132_cleanup_stream(codec, hinfo->nid);
+	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
 	return 0;
 }
 
@@ -4742,6 +4690,8 @@ static int patch_ca0132(struct hda_codec *codec)
 		return err;
 
 	codec->patch_ops = ca0132_patch_ops;
+	codec->pcm_format_first = 1;
+	codec->no_sticky_stream = 1;
 
 	return 0;
 }
-- 
1.9.0.rc1.175.g0b1dcb5
