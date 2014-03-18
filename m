From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/3] ASoC: davinci-mcasp: Constraint on the
	period and buffer size based on FIFO usage
Date: Tue, 18 Mar 2014 15:20:35 +0200
Message-ID: <1395148837-20850-2-git-send-email-peter.ujfalusi@ti.com>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C9752608D0
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 14:20:46 +0100 (CET)
In-Reply-To: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
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

We need to place constraint on the period if the read or write AFIFO
is enabled and it is configured for more than one word otherwise
the DMA will fail in buffer configuration where the sizes are not
aligned with the requested FIFO configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a01ae97c90aa..df067a836c4d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -720,6 +720,7 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
+	int afifo_numevt;
 
 	if (mcasp->version == MCASP_VERSION_4)
 		snd_soc_dai_set_dma_data(dai, substream,
@@ -727,6 +728,16 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 	else
 		snd_soc_dai_set_dma_data(dai, substream, mcasp->dma_params);
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		afifo_numevt = mcasp->txnumevt;
+	else
+		afifo_numevt = mcasp->rxnumevt;
+
+	if (afifo_numevt > 1)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   afifo_numevt);
+
 	return 0;
 }
 
-- 
1.9.0
