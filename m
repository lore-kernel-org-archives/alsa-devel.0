From: Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH 1/2] ALSA: hda/ca0132 - setup/cleanup streams
Date: Wed, 19 Feb 2014 14:27:07 +0800
Message-ID: <1392791227-16810-1-git-send-email-hychao@chromium.org>
References: <s5hppmztbvl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f202.google.com (mail-ig0-f202.google.com
 [209.85.213.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 261152652C1
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 07:27:15 +0100 (CET)
Received: by mail-ig0-f202.google.com with SMTP id uq10so84734igb.1
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 22:27:15 -0800 (PST)
In-Reply-To: <s5hppmztbvl.wl%tiwai@suse.de>
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
 sound/pci/hda/patch_ca0132.c | 66 +++++---------------------------------------
 1 file changed, 7 insertions(+), 59 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 54d1479..0aa72ee 100644
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
@@ -2726,7 +2672,7 @@ static int ca0132_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 {
 	struct ca0132_spec *spec = codec->spec;
 
-	ca0132_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
+	snd_hda_codec_setup_stream(codec, spec->dacs[0], stream_tag, 0, format);
 
 	return 0;
 }
@@ -2745,7 +2691,7 @@ static int ca0132_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
 		msleep(50);
 
-	ca0132_cleanup_stream(codec, spec->dacs[0]);
+	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
 
 	return 0;
 }
@@ -2824,8 +2770,8 @@ static int ca0132_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 {
 	struct ca0132_spec *spec = codec->spec;
 
-	ca0132_setup_stream(codec, spec->adcs[substream->number],
-			    stream_tag, 0, format);
+	snd_hda_codec_setup_stream(codec, spec->adcs[substream->number],
+				   stream_tag, 0, format);
 
 	return 0;
 }
@@ -2839,7 +2785,7 @@ static int ca0132_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	if (spec->dsp_state == DSP_DOWNLOADING)
 		return 0;
 
-	ca0132_cleanup_stream(codec, hinfo->nid);
+	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
 	return 0;
 }
 
@@ -4742,6 +4688,8 @@ static int patch_ca0132(struct hda_codec *codec)
 		return err;
 
 	codec->patch_ops = ca0132_patch_ops;
+	codec->pcm_format_first = 1;
+	codec->no_sticky_stream = 1;
 
 	return 0;
 }
-- 
1.8.3.2
