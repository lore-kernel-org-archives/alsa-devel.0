From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Add support for FIFO
	usage caused delay reporting
Date: Fri, 31 Aug 2018 11:24:56 +0300
Message-ID: <20180831082456.5091-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by alsa0.perex.cz (Postfix) with ESMTP id B5E35267778
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 10:24:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

McASP have write and read FIFO, each 64 words deep.

>From the WFIFOS/RFIFOS registers we can read the amount of data currently
in the FIFO which can be directly reported as delay.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index f7f546bdd312..1f8f4f3929f2 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1062,6 +1062,42 @@ static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
 	return error_ppm;
 }
 
+static inline u32 davinci_mcasp_tx_delay(struct davinci_mcasp *mcasp)
+{
+	if (!mcasp->txnumevt)
+		return 0;
+
+	return mcasp_get_reg(mcasp, mcasp->fifo_base + MCASP_WFIFOSTS_OFFSET);
+}
+
+static inline u32 davinci_mcasp_rx_delay(struct davinci_mcasp *mcasp)
+{
+	if (!mcasp->rxnumevt)
+		return 0;
+
+	return mcasp_get_reg(mcasp, mcasp->fifo_base + MCASP_RFIFOSTS_OFFSET);
+}
+
+static snd_pcm_sframes_t davinci_mcasp_delay(
+			struct snd_pcm_substream *substream,
+			struct snd_soc_dai *cpu_dai)
+{
+	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(cpu_dai);
+	u32 fifo_use;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		fifo_use = davinci_mcasp_tx_delay(mcasp);
+	else
+		fifo_use = davinci_mcasp_rx_delay(mcasp);
+
+	/*
+	 * Divide the used locations with the channel count to get the
+	 * FIFO usage in samples (don't care about partial samples in the
+	 * buffer).
+	 */
+	return fifo_use / substream->runtime->channels;
+}
+
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					struct snd_pcm_hw_params *params,
 					struct snd_soc_dai *cpu_dai)
@@ -1386,6 +1422,7 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.startup	= davinci_mcasp_startup,
 	.shutdown	= davinci_mcasp_shutdown,
 	.trigger	= davinci_mcasp_trigger,
+	.delay		= davinci_mcasp_delay,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
 	.set_clkdiv	= davinci_mcasp_set_clkdiv,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
