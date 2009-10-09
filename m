From: <LoganLi@viatech.com.cn>
Subject: [PATCH 6/30] ALSA: HDA VIA: Add low current mode for
	power saving.
Date: Fri, 9 Oct 2009 18:40:14 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C33@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id D4D46103AAC
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:09 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Add low current mode for power saving.

For VT1708B, VT1708S and VT1702, enter low current mode if no analog
stream is opened and all aa path mute.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |   41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -783,6 +783,10 @@
 				 struct snd_pcm_substream *substream)
 {
 	struct via_spec *spec = codec->spec;
+	int idle = substream->pstr->substream_opened == 1
+		&& substream->ref_count == 0;
+
+	analog_low_current_mode(codec, idle);
 	return snd_hda_multi_out_analog_open(codec, &spec->multiout,
substream,
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
@@ -2311,6 +2320,17 @@
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
@@ -2319,7 +2339,8 @@
 	.ops = {
 		.open = via_playback_pcm_open,
 		.prepare = via_playback_multi_pcm_prepare,
-		.cleanup = via_playback_multi_pcm_cleanup
+		.cleanup = via_playback_multi_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };
 
@@ -2341,8 +2362,10 @@
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
 
@@ -2799,7 +2822,8 @@
 	.ops = {
 		.open = via_playback_pcm_open,
 		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.cleanup = via_playback_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };
 
@@ -2809,8 +2833,10 @@
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
 
@@ -3235,7 +3261,8 @@
 	.ops = {
 		.open = via_playback_pcm_open,
 		.prepare = via_playback_multi_pcm_prepare,
-		.cleanup = via_playback_multi_pcm_cleanup
+		.cleanup = via_playback_multi_pcm_cleanup,
+		.close = via_pcm_open_close
 	},
 };
 
@@ -3245,8 +3272,10 @@
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
