From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Make HSW/BDW pointer debug verbose
Date: Thu, 16 Oct 2014 15:29:17 +0100
Message-ID: <1413469757-6200-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1413469757-6200-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B6FE72605EE
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 16:29:38 +0200 (CEST)
In-Reply-To: <1413469757-6200-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Improve the debug SNR by making the positional pointer debug more verbose.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 9a51987..2dc72a2 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -552,7 +552,7 @@ static u32 hsw_notify_pointer(struct sst_hsw_stream *stream, void *data)
 	pos = frames_to_bytes(runtime,
 		(runtime->control->appl_ptr % runtime->buffer_size));
 
-	dev_dbg(rtd->dev, "PCM: App pointer %d bytes\n", pos);
+	dev_vdbg(rtd->dev, "PCM: App pointer %d bytes\n", pos);
 
 	/* let alsa know we have play a period */
 	snd_pcm_period_elapsed(substream);
@@ -574,7 +574,7 @@ static snd_pcm_uframes_t hsw_pcm_pointer(struct snd_pcm_substream *substream)
 	offset = bytes_to_frames(runtime, position);
 	ppos = sst_hsw_get_dsp_presentation_position(hsw, pcm_data->stream);
 
-	dev_dbg(rtd->dev, "PCM: DMA pointer %du bytes, pos %llu\n",
+	dev_vdbg(rtd->dev, "PCM: DMA pointer %du bytes, pos %llu\n",
 		position, ppos);
 	return offset;
 }
-- 
1.9.1
