From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/9] ALSA: hda - Add PCM capture hook to
	hda_gen_spec
Date: Thu, 17 Jan 2013 17:54:53 +0100
Message-ID: <1358441694-32004-9-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2548A265376
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id DDAA6A51D9
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:54:59 +0100 (CET)
In-Reply-To: <1358441694-32004-1-git-send-email-tiwai@suse.de>
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

Not only PCM playback, a hook for PCM capture would be required for
power controls in codec drivers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_generic.h |  6 ++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index fc3f241..f946714 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3815,6 +3815,16 @@ static void call_pcm_playback_hook(struct hda_pcm_stream *hinfo,
 		spec->pcm_playback_hook(hinfo, codec, substream, action);
 }
 
+static void call_pcm_capture_hook(struct hda_pcm_stream *hinfo,
+				  struct hda_codec *codec,
+				  struct snd_pcm_substream *substream,
+				  int action)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	if (spec->pcm_capture_hook)
+		spec->pcm_capture_hook(hinfo, codec, substream, action);
+}
+
 /*
  * Analog playback callbacks
  */
@@ -3882,6 +3892,44 @@ static int playback_pcm_close(struct hda_pcm_stream *hinfo,
 	return 0;
 }
 
+static int capture_pcm_open(struct hda_pcm_stream *hinfo,
+			    struct hda_codec *codec,
+			    struct snd_pcm_substream *substream)
+{
+	call_pcm_capture_hook(hinfo, codec, substream, HDA_GEN_PCM_ACT_OPEN);
+	return 0;
+}
+
+static int capture_pcm_prepare(struct hda_pcm_stream *hinfo,
+			       struct hda_codec *codec,
+			       unsigned int stream_tag,
+			       unsigned int format,
+			       struct snd_pcm_substream *substream)
+{
+	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
+	call_pcm_capture_hook(hinfo, codec, substream,
+			      HDA_GEN_PCM_ACT_PREPARE);
+	return 0;
+}
+
+static int capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
+			       struct hda_codec *codec,
+			       struct snd_pcm_substream *substream)
+{
+	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
+	call_pcm_capture_hook(hinfo, codec, substream,
+			      HDA_GEN_PCM_ACT_CLEANUP);
+	return 0;
+}
+
+static int capture_pcm_close(struct hda_pcm_stream *hinfo,
+			     struct hda_codec *codec,
+			     struct snd_pcm_substream *substream)
+{
+	call_pcm_capture_hook(hinfo, codec, substream, HDA_GEN_PCM_ACT_CLOSE);
+	return 0;
+}
+
 static int alt_playback_pcm_open(struct hda_pcm_stream *hinfo,
 				 struct hda_codec *codec,
 				 struct snd_pcm_substream *substream)
@@ -3976,6 +4024,9 @@ static int dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
 /*
  * Analog capture
  */
+#define alt_capture_pcm_open	capture_pcm_open
+#define alt_capture_pcm_close	capture_pcm_close
+
 static int alt_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 				   struct hda_codec *codec,
 				   unsigned int stream_tag,
@@ -3986,6 +4037,8 @@ static int alt_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 
 	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number + 1],
 				   stream_tag, 0, format);
+	call_pcm_capture_hook(hinfo, codec, substream,
+			      HDA_GEN_PCM_ACT_PREPARE);
 	return 0;
 }
 
@@ -3997,6 +4050,8 @@ static int alt_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
 
 	snd_hda_codec_cleanup_stream(codec,
 				     spec->adc_nids[substream->number + 1]);
+	call_pcm_capture_hook(hinfo, codec, substream,
+			      HDA_GEN_PCM_ACT_CLEANUP);
 	return 0;
 }
 
@@ -4020,6 +4075,12 @@ static const struct hda_pcm_stream pcm_analog_capture = {
 	.channels_min = 2,
 	.channels_max = 2,
 	/* NID is set in build_pcms */
+	.ops = {
+		.open = capture_pcm_open,
+		.close = capture_pcm_close,
+		.prepare = capture_pcm_prepare,
+		.cleanup = capture_pcm_cleanup
+	},
 };
 
 static const struct hda_pcm_stream pcm_analog_alt_playback = {
@@ -4041,6 +4102,8 @@ static const struct hda_pcm_stream pcm_analog_alt_capture = {
 	.channels_max = 2,
 	/* NID is set in build_pcms */
 	.ops = {
+		.open = alt_capture_pcm_open,
+		.close = alt_capture_pcm_close,
 		.prepare = alt_capture_pcm_prepare,
 		.cleanup = alt_capture_pcm_cleanup
 	},
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index a0486b1..7b14e9c 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -233,11 +233,15 @@ struct hda_gen_spec {
 	void (*automute_hook)(struct hda_codec *codec);
 	void (*cap_sync_hook)(struct hda_codec *codec);
 
-	/* PCM playback hook */
+	/* PCM hooks */
 	void (*pcm_playback_hook)(struct hda_pcm_stream *hinfo,
 				  struct hda_codec *codec,
 				  struct snd_pcm_substream *substream,
 				  int action);
+	void (*pcm_capture_hook)(struct hda_pcm_stream *hinfo,
+				 struct hda_codec *codec,
+				 struct snd_pcm_substream *substream,
+				 int action);
 
 	/* automute / autoswitch hooks */
 	void (*hp_automute_hook)(struct hda_codec *codec,
-- 
1.8.1
