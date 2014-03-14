From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 3/4] ASoC: davinci-mcasp: Constraint on the
	period and buffer size based on FIFO usage
Date: Fri, 14 Mar 2014 16:42:47 +0200
Message-ID: <1394808168-32608-4-git-send-email-peter.ujfalusi@ti.com>
References: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BE65265383
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 15:43:00 +0100 (CET)
In-Reply-To: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

We need to place constraint on the period and buffer size if the read
or write AFIFO is enabled and it is configured for more than one word
otherwise the DMA will fail in buffer configuration where the sizes
are not aligned with the requested FIFO configuration.

Some application (like mplayer) needs the constraint placed on the
buffer size as well. If only period size is constrained they might
fail to figure out the allowed buffer configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a01ae97c90aa..3ca6e8c4568a 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -720,6 +720,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+	int afifo_numevt;
 
 	if (mcasp->version == MCASP_VERSION_4)
 		snd_soc_dai_set_dma_data(dai, substream,
@@ -727,6 +728,21 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	else
 		snd_soc_dai_set_dma_data(dai, substream, mcasp->dma_params);
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		afifo_numevt = mcasp->txnumevt;
+	else
+		afifo_numevt = mcasp->rxnumevt;
+
+	if (afifo_numevt > 1) {
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   afifo_numevt);
+
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					   afifo_numevt);
+	}
+
 	return 0;
 }
 
-- 
1.9.0
