From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 4/6] ASoC: generic-dmaengine-pcm: Check DMA
	residue granularity
Date: Sat, 11 Jan 2014 14:02:19 +0100
Message-ID: <1389445341-17227-5-git-send-email-lars@metafoo.de>
References: <1389445341-17227-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C9DD261A1C
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 14:02:03 +0100 (CET)
In-Reply-To: <1389445341-17227-1-git-send-email-lars@metafoo.de>
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
No changes since v2
Changes since v1:
	* Add support for auto-detecting the NO_RESIDUE flag to the compat path
---
 sound/soc/soc-generic-dmaengine-pcm.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 4e2bed8..560a778 100644
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
@@ -187,6 +189,21 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 						 dma_data->filter_data);
 }
 
+static bool dmaengine_pcm_can_report_residue(struct dma_chan *chan)
+{
+	struct dma_slave_caps dma_caps;
+	int ret;
+
+	ret = dma_get_slave_caps(chan, &dma_caps);
+	if (ret != 0)
+		return true;
+
+	if (dma_caps.residue_granularity == DMA_RESIDUE_GRANULARITY_DESCRIPTOR)
+		return false;
+
+	return true;
+}
+
 static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct dmaengine_pcm *pcm = soc_platform_to_pcm(rtd->platform);
@@ -239,6 +256,16 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 				max_buffer_size);
 		if (ret)
 			goto err_free;
+
+		/*
+		 * This will only return false if we know for sure that at least
+		 * one channel does not support residue reporting. If the DMA
+		 * driver does not implement the slave_caps API we rely having
+		 * the NO_RESIDUE flag set manually in case residue reporting is
+		 * not supported.
+		 */
+		if (!dmaengine_pcm_can_report_residue(pcm->chan[i]))
+			pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE;
 	}
 
 	return 0;
-- 
1.8.0
