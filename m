From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 2/3] ASoC: davinci-mcasp: Channel count
	constraints for multi-serializer case
Date: Thu, 23 Apr 2015 16:16:05 +0300
Message-ID: <f200c8ad9f0399270a8c320ae3e4e2d0b7cacf76.1429794271.git.jsarha@ti.com>
References: <cover.1429794271.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 5081E261AF0
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 15:16:24 +0200 (CEST)
In-Reply-To: <cover.1429794271.git.jsarha@ti.com>
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
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Set channel count constraints for multiple serializers case. On McASP
the active channels mask is the same for all the serializers. With the
current implementation this means that if more than one serializers is
used, all TDM slots have to be active on all serializers. The patch
sets the channel count constraints according to number of RX and TX
serializers.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 63 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index a01c6db..f841707 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -107,6 +107,7 @@ struct davinci_mcasp {
 #endif
 
 	struct davinci_mcasp_ruledata ruledata[2];
+	struct snd_pcm_hw_constraint_list chconstr[2];
 };
 
 static inline void mcasp_set_bits(struct davinci_mcasp *mcasp, u32 offset,
@@ -1119,6 +1120,11 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				     SNDRV_PCM_HW_PARAM_CHANNELS,
 				     2, max_channels);
 
+	if (mcasp->chconstr[substream->stream].count)
+		snd_pcm_hw_constraint_list(substream->runtime,
+					   0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &mcasp->chconstr[substream->stream]);
+
 	/*
 	 * If we rely on implicit BCLK divider setting we should
 	 * set constraints based on what we can provide.
@@ -1498,6 +1504,59 @@ nodata:
 	return  pdata;
 }
 
+/* All serializers must have equal number of channels */
+static int davinci_mcasp_ch_constraint(struct davinci_mcasp *mcasp,
+				       struct snd_pcm_hw_constraint_list *cl,
+				       int serializers)
+{
+	unsigned int *list;
+	int i, count = 0;
+
+	if (serializers <= 1)
+		return 0;
+
+	list = devm_kzalloc(mcasp->dev, sizeof(unsigned int) *
+			    (mcasp->tdm_slots + serializers - 2),
+			    GFP_KERNEL);
+	if (!list)
+		return -ENOMEM;
+
+	for (i = 2; i <= mcasp->tdm_slots; i++)
+		list[count++] = i;
+
+	for (i = 2; i <= serializers; i++)
+		list[count++] = i*mcasp->tdm_slots;
+
+	cl->count = count;
+	cl->list = list;
+
+	return 0;
+}
+
+
+static int davinci_mcasp_init_ch_constraints(struct davinci_mcasp *mcasp)
+{
+	int rx_serializers = 0, tx_serializers = 0, ret, i;
+
+	for (i = 0; i < mcasp->num_serializer; i++)
+		if (mcasp->serial_dir[i] == TX_MODE)
+			tx_serializers++;
+		else if (mcasp->serial_dir[i] == RX_MODE)
+			rx_serializers++;
+
+	ret = davinci_mcasp_ch_constraint(mcasp, &mcasp->chconstr[
+						  SNDRV_PCM_STREAM_PLAYBACK],
+					  tx_serializers);
+	if (ret)
+		return ret;
+
+	ret = davinci_mcasp_ch_constraint(mcasp, &mcasp->chconstr[
+						  SNDRV_PCM_STREAM_CAPTURE],
+					  rx_serializers);
+
+	return ret;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -1681,6 +1740,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		mcasp->fifo_base = DAVINCI_MCASP_V3_AFIFO_BASE;
 	}
 
+	ret = davinci_mcasp_init_ch_constraints(mcasp);
+	if (ret)
+		goto err;
+
 	dev_set_drvdata(&pdev->dev, mcasp);
 
 	mcasp_reparent_fck(pdev);
-- 
1.9.1
