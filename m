From: <LoganLi@viatech.com.cn>
Subject: [PATCH 16/30] ALSA: HDA VIA: Replace
	via_playback_pcm_prepare/cleanup
Date: Fri, 9 Oct 2009 18:40:46 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C3D@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id A34A7103A88
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:40 +0200 (CEST)
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
Subject: ALSA: HDA VIA: Replace via_playback_pcm_prepare/cleanup

Replaced with via_playback_multi_pcm_prepare/cleanup to support
multi-stream operations

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |   40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -1022,28 +1022,6 @@
 					     hinfo);
 }
 
-static int via_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    unsigned int stream_tag,
-				    unsigned int format,
-				    struct snd_pcm_substream *substream)
-{
-	struct via_spec *spec = codec->spec;
-	vt1708_start_hp_work(spec);
-	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
-						stream_tag, format,
substream);
-}
-
-static int via_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
-				    struct hda_codec *codec,
-				    struct snd_pcm_substream *substream)
-{
-	struct via_spec *spec = codec->spec;
-	vt1708_stop_hp_work(spec);
-	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
-}
-
-
 static void playback_multi_pcm_prep_0(struct hda_codec *codec,
 				      unsigned int stream_tag,
 				      unsigned int format,
@@ -1252,7 +1230,7 @@
 };
 
 static struct hda_pcm_stream vt1708_pcm_analog_s16_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 8,
 	.nid = 0x10, /* NID to query formats and rates */
@@ -1263,8 +1241,8 @@
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup
 	},
 };
 
@@ -2061,8 +2039,8 @@
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
 	},
 };
 
@@ -2073,8 +2051,8 @@
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup,
 	},
 };
 
@@ -3165,8 +3143,8 @@
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
