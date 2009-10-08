From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 16/31] HDA patch_via.c: Remove
	via_playback_pcm_prepare/cleanup
Date: Thu, 8 Oct 2009 13:46:04 +0800
Message-ID: <16685ee0910072246u1cf1549ahe5f9ee8b8ef89472@mail.gmail.com>
References: <16685ee0910050727s5a6c744h88d0b88dc72b87ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 92356103962
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:46:05 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1481775bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:46:04 -0700 (PDT)
In-Reply-To: <16685ee0910050727s5a6c744h88d0b88dc72b87ce@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Replace via_playback_pcm_prepare/cleanup

Replaced with via_playback_multi_pcm_prepare/cleanup to support
multi-stream operations

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1020,26 +1020,6 @@
 					     hinfo);
 }

-static int via_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    unsigned int stream_tag,
-				    unsigned int format,
-				    struct snd_pcm_substream *substream)
-{
-	struct via_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
-						stream_tag, format, substream);
-}
-
-static int via_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    struct snd_pcm_substream *substream)
-{
-	struct via_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
-}
-
-
 static void playback_multi_pcm_prep_0(struct hda_codec *codec,
 				      unsigned int stream_tag,
 				      unsigned int format,
@@ -1248,7 +1228,7 @@
 };

 static struct hda_pcm_stream vt1708_pcm_analog_s16_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 8,
 	.nid = 0x10, /* NID to query formats and rates */
@@ -1259,8 +1239,8 @@
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup
 	},
 };

@@ -2058,8 +2038,8 @@
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
 	},
 };

@@ -2070,8 +2050,8 @@
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
 	},
 };

@@ -3162,8 +3142,8 @@
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup,
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
 		.close = via_pcm_open_close
 	},
 };
