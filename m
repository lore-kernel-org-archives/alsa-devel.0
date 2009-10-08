From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 6/31] HDA patch_via.c: Add low current mode
	for power saving.
Date: Thu, 8 Oct 2009 13:42:46 +0800
Message-ID: <16685ee0910072242j40f0f288mc68e8e88fa706728@mail.gmail.com>
References: <16685ee0910050725q167007f3h66b403b484692f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 35672103904
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:42:47 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so2081232fge.2
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:42:46 -0700 (PDT)
In-Reply-To: <16685ee0910050725q167007f3h66b403b484692f76@mail.gmail.com>
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

[ALSA] HDA VIA: Add low current mode for power saving.

For VT1708B, VT1708S and VT1702, enter low current mode if no analog
stream is opened and all aa path mute.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -783,6 +783,10 @@
 				 struct snd_pcm_substream *substream)
 {
 	struct via_spec *spec = codec->spec;
+	int idle = substream->pstr->substream_opened == 1
+		&& substream->ref_count == 0;
+
+	analog_low_current_mode(codec, idle);
 	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
 					     hinfo);
 }
@@ -1089,6 +1093,11 @@
 		if (err < 0)
 			return err;
 	}
+
+	/* init power states */
+	set_jack_power_state(codec);
+	analog_low_current_mode(codec, 1);
+
 	via_free_kctls(codec); /* no longer needed */
 	return 0;
 }
@@ -2312,6 +2321,17 @@
 	{ }
 };

+static int via_pcm_open_close(struct hda_pcm_stream *hinfo,
+			      struct hda_codec *codec,
+			      struct snd_pcm_substream *substream)
+{
+	int idle = substream->pstr->substream_opened == 1
+		&& substream->ref_count == 0;
+
+	analog_low_current_mode(codec, idle);
+	return 0;
+}
+
 static struct hda_pcm_stream vt1708B_8ch_pcm_analog_playback = {
 	.substreams = 2,
 	.channels_min = 2,
@@ -2320,7 +2340,8 @@
 	.ops = {
 		.open = via_playback_pcm_open,
 		.prepare = via_playback_multi_pcm_prepare,
-		.cleanup = via_playback_multi_pcm_cleanup
+		.cleanup = via_playback_multi_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };

@@ -2342,8 +2363,10 @@
 	.channels_max = 2,
 	.nid = 0x13, /* NID to query formats and rates */
 	.ops = {
+		.open = via_pcm_open_close,
 		.prepare = via_capture_pcm_prepare,
-		.cleanup = via_capture_pcm_cleanup
+		.cleanup = via_capture_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };

@@ -2800,7 +2823,8 @@
 	.ops = {
 		.open = via_playback_pcm_open,
 		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.cleanup = via_playback_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };

@@ -2810,8 +2834,10 @@
 	.channels_max = 2,
 	.nid = 0x13, /* NID to query formats and rates */
 	.ops = {
+		.open = via_pcm_open_close,
 		.prepare = via_capture_pcm_prepare,
-		.cleanup = via_capture_pcm_cleanup
+		.cleanup = via_capture_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };

@@ -3236,7 +3262,8 @@
 	.ops = {
 		.open = via_playback_pcm_open,
 		.prepare = via_playback_multi_pcm_prepare,
-		.cleanup = via_playback_multi_pcm_cleanup
+		.cleanup = via_playback_multi_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };

@@ -3246,8 +3273,10 @@
 	.channels_max = 2,
 	.nid = 0x12, /* NID to query formats and rates */
 	.ops = {
+		.open = via_pcm_open_close,
 		.prepare = via_capture_pcm_prepare,
-		.cleanup = via_capture_pcm_cleanup
+		.cleanup = via_capture_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };
