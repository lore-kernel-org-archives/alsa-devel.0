From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: generic-dmaengine-pcm: Check DMA
	residue granularity
Date: Sun,  8 Dec 2013 17:18:09 +0100
Message-ID: <1386519489-1935-4-git-send-email-lars@metafoo.de>
References: <1386519489-1935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-151.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A494261B21
 for <alsa-devel@alsa-project.org>; Sun,  8 Dec 2013 17:17:29 +0100 (CET)
In-Reply-To: <1386519489-1935-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The dmaengine framework now exposes the granularity with which it is able to
report the transfer residue for a certain DMA channel. Check the granularity in
the generic dmaengine PCM driver and
	a) Set the SNDRV_PCM_INFO_BATCH if the granularity is per period or worse.
	b) Fallback to the (race condition prone) period counting if the driver does
	not support any residue reporting.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 37 +++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 87e8635..7bdee7b 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -144,6 +144,8 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	if (ret == 0) {
 		if (dma_caps.cmd_pause)
 			hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
+		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
+			hw.info |= SNDRV_PCM_INFO_BATCH;
 	}
 
 	return snd_soc_set_runtime_hwparams(substream, &hw);
@@ -282,6 +284,27 @@ static const struct snd_soc_platform_driver dmaengine_no_residue_pcm_platform =
 	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 };
 
+static bool dmaengine_pcm_can_report_residue(struct dmaengine_pcm *pcm)
+{
+	struct dma_slave_caps dma_caps;
+	int ret;
+	int i;
+
+	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
+		if (!pcm->chan[i])
+			continue;
+
+		ret = dma_get_slave_caps(pcm->chan[i], &dma_caps);
+		if (ret != 0)
+			continue;
+
+		if (dma_caps.residue_granularity == DMA_RESIDUE_GRANULARITY_DESCRIPTOR)
+			return false;
+	}
+
+	return true;
+}
+
 static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = "tx",
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
@@ -323,11 +346,21 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	if (!pcm)
 		return -ENOMEM;
 
+	dmaengine_pcm_request_chan_of(pcm, dev);
+
+	/*
+	 * This will only return false if we know for sure that at least one
+	 * channel does not support residue reporting. If the compat path is
+	 * used for requesting the channels or the dma driver does not implement
+	 * the slave_caps API we rely on the caller to set the NO_RESIDUE flag
+	 * in case residue reporting is not supported.
+	 */
+	if (!dmaengine_pcm_can_report_residue(pcm))
+		flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE;
+
 	pcm->config = config;
 	pcm->flags = flags;
 
-	dmaengine_pcm_request_chan_of(pcm, dev);
-
 	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		return snd_soc_add_platform(dev, &pcm->platform,
 				&dmaengine_no_residue_pcm_platform);
-- 
1.8.0
