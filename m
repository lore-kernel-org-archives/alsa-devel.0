From: Li Bo <liboat@gmail.com>
Subject: [PATCH 16/31] HDA patch_via.c: Remove
	via_playback_pcm_prepare/cleanup
Date: Mon, 5 Oct 2009 22:27:30 +0800
Message-ID: <16685ee0910050727s5a6c744h88d0b88dc72b87ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 56FEC103899
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:27:31 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so10052327bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:27:31 -0700 (PDT)
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

[ALSA] HDA VIA: Remove via_playback_pcm_prepare/cleanup

replaced with via_playback_multi_pcm_prepare/cleanup to support
multi-stream operations

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:10:49.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:10:59.000000000 +0800
@@ -989,26 +989,6 @@
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
@@ -1217,7 +1197,7 @@
 };

 static struct hda_pcm_stream vt1708_pcm_analog_s16_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 8,
 	.nid = 0x10, /* NID to query formats and rates */
@@ -1228,8 +1208,8 @@
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup
 	},
 };

@@ -2023,8 +2003,8 @@
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
 	},
 };

@@ -2035,8 +2015,8 @@
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
 	},
 };

@@ -3127,8 +3107,8 @@
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
