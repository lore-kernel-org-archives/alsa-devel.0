From: mengdong.lin@linux.intel.com
Subject: [PATCH v2]ASoC: topology: Fix setting of stream rates,
	rate_min and rate_max
Date: Mon, 22 Feb 2016 16:29:19 +0800
Message-ID: <1456129759-24017-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A67260789
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 09:28:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: lars@metafoo.de, vinod.koul@intel.com, hardik.t.shah@intel.com, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Directly set a stream's rates, rate_min and rate_max from the topology
info. Also define set_stream_info to wrap setting of the stream info.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 0eb01e8..726cea7 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1575,6 +1575,18 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	return 0;
 }
 
+static void set_stream_info(struct snd_soc_pcm_stream *stream,
+	struct snd_soc_tplg_stream_caps *caps)
+{
+	stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+	stream->channels_min = caps->channels_min;
+	stream->channels_max = caps->channels_max;
+	stream->rates = caps->rates;
+	stream->rate_min = caps->rate_min;
+	stream->rate_max = caps->rate_max;
+	stream->formats = caps->formats;
+}
+
 static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
@@ -1593,25 +1605,13 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	if (pcm->playback) {
 		stream = &dai_drv->playback;
 		caps = &pcm->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
-
-		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
-		stream->channels_min = caps->channels_min;
-		stream->channels_max = caps->channels_max;
-		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
-							caps->rate_max);
-		stream->formats = caps->formats;
+		set_stream_info(stream, caps);
 	}
 
 	if (pcm->capture) {
 		stream = &dai_drv->capture;
 		caps = &pcm->caps[SND_SOC_TPLG_STREAM_CAPTURE];
-
-		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
-		stream->channels_min = caps->channels_min;
-		stream->channels_max = caps->channels_max;
-		stream->rates = snd_pcm_rate_range_to_bits(caps->rate_min,
-							caps->rate_max);
-		stream->formats = caps->formats;
+		set_stream_info(stream, caps);
 	}
 
 	/* pass control to component driver for optional further init */
-- 
2.5.0
