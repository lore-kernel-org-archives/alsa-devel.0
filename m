From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 099/112] ALSA: hda - Add pcm_playback_hook to
	hda_gen_spec
Date: Tue,  8 Jan 2013 12:39:32 +0100
Message-ID: <1357645185-7645-100-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CCB626522F
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 00D22A5396
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

The new hook which is called at each PCM playback ops.
It can be used to control the codec-specific power-saving feature in
each codec driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 65 +++++++++++++++++++++++++++++++++++++++++----
 sound/pci/hda/hda_generic.h | 14 ++++++++++
 2 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 15b742a..a041032 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3259,6 +3259,16 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_build_controls);
  * PCM definitions
  */
 
+static void call_pcm_playback_hook(struct hda_pcm_stream *hinfo,
+				   struct hda_codec *codec,
+				   struct snd_pcm_substream *substream,
+				   int action)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	if (spec->pcm_playback_hook)
+		spec->pcm_playback_hook(hinfo, codec, substream, action);
+}
+
 /*
  * Analog playback callbacks
  */
@@ -3273,8 +3283,11 @@ static int playback_pcm_open(struct hda_pcm_stream *hinfo,
 	err = snd_hda_multi_out_analog_open(codec,
 					    &spec->multiout, substream,
 					     hinfo);
-	if (!err)
+	if (!err) {
 		spec->active_streams |= 1 << STREAM_MULTI_OUT;
+		call_pcm_playback_hook(hinfo, codec, substream,
+				       HDA_GEN_PCM_ACT_OPEN);
+	}
 	mutex_unlock(&spec->pcm_mutex);
 	return err;
 }
@@ -3286,8 +3299,14 @@ static int playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 				struct snd_pcm_substream *substream)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
-						stream_tag, format, substream);
+	int err;
+
+	err = snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
+					       stream_tag, format, substream);
+	if (!err)
+		call_pcm_playback_hook(hinfo, codec, substream,
+				       HDA_GEN_PCM_ACT_PREPARE);
+	return err;
 }
 
 static int playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
@@ -3295,7 +3314,13 @@ static int playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 				struct snd_pcm_substream *substream)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
+	int err;
+
+	err = snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
+	if (!err)
+		call_pcm_playback_hook(hinfo, codec, substream,
+				       HDA_GEN_PCM_ACT_CLEANUP);
+	return err;
 }
 
 static int playback_pcm_close(struct hda_pcm_stream *hinfo,
@@ -3305,6 +3330,8 @@ static int playback_pcm_close(struct hda_pcm_stream *hinfo,
 	struct hda_gen_spec *spec = codec->spec;
 	mutex_lock(&spec->pcm_mutex);
 	spec->active_streams &= ~(1 << STREAM_MULTI_OUT);
+	call_pcm_playback_hook(hinfo, codec, substream,
+			       HDA_GEN_PCM_ACT_CLOSE);
 	mutex_unlock(&spec->pcm_mutex);
 	return 0;
 }
@@ -3321,6 +3348,8 @@ static int alt_playback_pcm_open(struct hda_pcm_stream *hinfo,
 		err = -EBUSY;
 	else
 		spec->active_streams |= 1 << STREAM_INDEP_HP;
+	call_pcm_playback_hook(hinfo, codec, substream,
+			       HDA_GEN_PCM_ACT_OPEN);
 	mutex_unlock(&spec->pcm_mutex);
 	return err;
 }
@@ -3332,10 +3361,34 @@ static int alt_playback_pcm_close(struct hda_pcm_stream *hinfo,
 	struct hda_gen_spec *spec = codec->spec;
 	mutex_lock(&spec->pcm_mutex);
 	spec->active_streams &= ~(1 << STREAM_INDEP_HP);
+	call_pcm_playback_hook(hinfo, codec, substream,
+			       HDA_GEN_PCM_ACT_CLOSE);
 	mutex_unlock(&spec->pcm_mutex);
 	return 0;
 }
 
+static int alt_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+				    struct hda_codec *codec,
+				    unsigned int stream_tag,
+				    unsigned int format,
+				    struct snd_pcm_substream *substream)
+{
+	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
+	call_pcm_playback_hook(hinfo, codec, substream,
+			       HDA_GEN_PCM_ACT_PREPARE);
+	return 0;
+}
+
+static int alt_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				    struct hda_codec *codec,
+				    struct snd_pcm_substream *substream)
+{
+	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
+	call_pcm_playback_hook(hinfo, codec, substream,
+			       HDA_GEN_PCM_ACT_CLEANUP);
+	return 0;
+}
+
 /*
  * Digital out
  */
@@ -3430,7 +3483,9 @@ static const struct hda_pcm_stream pcm_analog_alt_playback = {
 	/* NID is set in build_pcms */
 	.ops = {
 		.open = alt_playback_pcm_open,
-		.close = alt_playback_pcm_close
+		.close = alt_playback_pcm_close,
+		.prepare = alt_playback_pcm_prepare,
+		.cleanup = alt_playback_pcm_cleanup
 	},
 };
 
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 4c0d9ad..7e84c22 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -69,6 +69,14 @@ struct automic_entry {
 /* active stream id */
 enum { STREAM_MULTI_OUT, STREAM_INDEP_HP };
 
+/* PCM hook action */
+enum {
+	HDA_GEN_PCM_ACT_OPEN,
+	HDA_GEN_PCM_ACT_PREPARE,
+	HDA_GEN_PCM_ACT_CLEANUP,
+	HDA_GEN_PCM_ACT_CLOSE,
+};
+
 struct hda_gen_spec {
 	char stream_name_analog[32];	/* analog PCM stream */
 	const struct hda_pcm_stream *stream_analog_playback;
@@ -191,6 +199,12 @@ struct hda_gen_spec {
 	void (*automute_hook)(struct hda_codec *codec);
 	void (*cap_sync_hook)(struct hda_codec *codec);
 
+	/* PCM playback hook */
+	void (*pcm_playback_hook)(struct hda_pcm_stream *hinfo,
+				  struct hda_codec *codec,
+				  struct snd_pcm_substream *substream,
+				  int action);
+
 	/* automute / autoswitch hooks */
 	void (*hp_automute_hook)(struct hda_codec *codec,
 				 struct hda_jack_tbl *tbl);
-- 
1.8.0.1
