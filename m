From: jeeja.kp@intel.com
Subject: [PATCH 10/10] ASoC: Intel: Skylake: Report position in
	pointer query
Date: Fri,  3 Jun 2016 18:29:43 +0530
Message-ID: <1464958783-19344-11-git-send-email-jeeja.kp@intel.com>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C2374266605
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 14:56:36 +0200 (CEST)
In-Reply-To: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
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
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Don't update the runtime_delay in pointer query, delay need to
reported as part of soc driver ops delay function. The delay
value overwritten by ASoC core so this is dummy code and hence
removing it.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 64 +++------------------------------------
 1 file changed, 4 insertions(+), 60 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 1590bef..6e05bf8 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1026,51 +1026,11 @@ static int skl_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/* calculate runtime delay from LPIB */
-static int skl_get_delay_from_lpib(struct hdac_ext_bus *ebus,
-				struct hdac_ext_stream *sstream,
-				unsigned int pos)
-{
-	struct hdac_bus *bus = ebus_to_hbus(ebus);
-	struct hdac_stream *hstream = hdac_stream(sstream);
-	struct snd_pcm_substream *substream = hstream->substream;
-	int stream = substream->stream;
-	unsigned int lpib_pos = snd_hdac_stream_get_pos_lpib(hstream);
-	int delay;
-
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		delay = pos - lpib_pos;
-	else
-		delay = lpib_pos - pos;
-
-	if (delay < 0) {
-		if (delay >= hstream->delay_negative_threshold)
-			delay = 0;
-		else
-			delay += hstream->bufsize;
-	}
-
-	if (hstream->bufsize == delay)
-		delay = 0;
-
-	if (delay >= hstream->period_bytes) {
-		dev_info(bus->dev,
-			 "Unstable LPIB (%d >= %d); disabling LPIB delay counting\n",
-			 delay, hstream->period_bytes);
-		delay = 0;
-	}
-
-	return bytes_to_frames(substream->runtime, delay);
-}
-
-static unsigned int skl_get_position(struct hdac_ext_stream *hstream,
-					int codec_delay)
+static snd_pcm_uframes_t skl_platform_pcm_pointer
+			(struct snd_pcm_substream *substream)
 {
-	struct hdac_stream *hstr = hdac_stream(hstream);
-	struct snd_pcm_substream *substream = hstr->substream;
-	struct hdac_ext_bus *ebus;
+	struct hdac_ext_stream *hstream = get_hdac_ext_stream(substream);
 	unsigned int pos;
-	int delay;
 
 	/* use the position buffer as default */
 	pos = snd_hdac_stream_get_pos_posbuf(hdac_stream(hstream));
@@ -1078,23 +1038,7 @@ static unsigned int skl_get_position(struct hdac_ext_stream *hstream,
 	if (pos >= hdac_stream(hstream)->bufsize)
 		pos = 0;
 
-	if (substream->runtime) {
-		ebus = get_bus_ctx(substream);
-		delay = skl_get_delay_from_lpib(ebus, hstream, pos)
-						 + codec_delay;
-		substream->runtime->delay += delay;
-	}
-
-	return pos;
-}
-
-static snd_pcm_uframes_t skl_platform_pcm_pointer
-			(struct snd_pcm_substream *substream)
-{
-	struct hdac_ext_stream *hstream = get_hdac_ext_stream(substream);
-
-	return bytes_to_frames(substream->runtime,
-			       skl_get_position(hstream, 0));
+	return bytes_to_frames(substream->runtime, pos);
 }
 
 static u64 skl_adjust_codec_delay(struct snd_pcm_substream *substream,
-- 
2.5.0
