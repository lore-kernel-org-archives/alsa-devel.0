From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 17/21] ASoC: simplify the SSP DMA parameters
	settings by run-time generation
Date: Thu, 23 Apr 2009 20:55:51 +0100
Message-ID: <1240516555-22249-17-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 80C111038A7
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:04 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

From: Eric Miao <eric.miao@marvell.com>

The SSP DMA parameters can actually be easily generated at run-time since
they are almost similar except for the FIFO width and direction. Another
benefit is the re-use of information from 'struct ssp_device', like SSDR
physical FIFO address and DRCMR register index for both directions.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Reviewed-by: pHilipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |  203 ++++++++++-------------------------------------
 1 files changed, 43 insertions(+), 160 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b9b61dd..fb8cacc 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -50,139 +50,6 @@ struct ssp_priv {
 #endif
 };
 
-#define PXA2xx_SSP1_BASE	0x41000000
-#define PXA27x_SSP2_BASE	0x41700000
-#define PXA27x_SSP3_BASE	0x41900000
-#define PXA3xx_SSP4_BASE	0x41a00000
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_out = {
-	.name			= "SSP1 PCM Mono out",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(14),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_mono_in = {
-	.name			= "SSP1 PCM Mono in",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(13),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_out = {
-	.name			= "SSP1 PCM Stereo out",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(14),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp1_pcm_stereo_in = {
-	.name			= "SSP1 PCM Stereo in",
-	.dev_addr		= PXA2xx_SSP1_BASE + SSDR,
-	.drcmr			= &DRCMR(13),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_out = {
-	.name			= "SSP2 PCM Mono out",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(16),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_mono_in = {
-	.name			= "SSP2 PCM Mono in",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(15),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_out = {
-	.name			= "SSP2 PCM Stereo out",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(16),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp2_pcm_stereo_in = {
-	.name			= "SSP2 PCM Stereo in",
-	.dev_addr		= PXA27x_SSP2_BASE + SSDR,
-	.drcmr			= &DRCMR(15),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_out = {
-	.name			= "SSP3 PCM Mono out",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_mono_in = {
-	.name			= "SSP3 PCM Mono in",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_out = {
-	.name			= "SSP3 PCM Stereo out",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp3_pcm_stereo_in = {
-	.name			= "SSP3 PCM Stereo in",
-	.dev_addr		= PXA27x_SSP3_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_out = {
-	.name			= "SSP4 PCM Mono out",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_mono_in = {
-	.name			= "SSP4 PCM Mono in",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH2,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_out = {
-	.name			= "SSP4 PCM Stereo out",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(67),
-	.dcmd			= DCMD_INCSRCADDR | DCMD_FLOWTRG |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
-static struct pxa2xx_pcm_dma_params pxa_ssp4_pcm_stereo_in = {
-	.name			= "SSP4 PCM Stereo in",
-	.dev_addr		= PXA3xx_SSP4_BASE + SSDR,
-	.drcmr			= &DRCMR(66),
-	.dcmd			= DCMD_INCTRGADDR | DCMD_FLOWSRC |
-				  DCMD_BURST16 | DCMD_WIDTH4,
-};
-
 static void dump_registers(struct ssp_device *ssp)
 {
 	dev_dbg(&ssp->pdev->dev, "SSCR0 0x%08x SSCR1 0x%08x SSTO 0x%08x\n",
@@ -194,25 +61,33 @@ static void dump_registers(struct ssp_device *ssp)
 		 ssp_read_reg(ssp, SSACD));
 }
 
-static struct pxa2xx_pcm_dma_params *ssp_dma_params[4][4] = {
-	{
-		&pxa_ssp1_pcm_mono_out, &pxa_ssp1_pcm_mono_in,
-		&pxa_ssp1_pcm_stereo_out, &pxa_ssp1_pcm_stereo_in,
-	},
-	{
-		&pxa_ssp2_pcm_mono_out, &pxa_ssp2_pcm_mono_in,
-		&pxa_ssp2_pcm_stereo_out, &pxa_ssp2_pcm_stereo_in,
-	},
-	{
-		&pxa_ssp3_pcm_mono_out, &pxa_ssp3_pcm_mono_in,
-		&pxa_ssp3_pcm_stereo_out, &pxa_ssp3_pcm_stereo_in,
-	},
-	{
-		&pxa_ssp4_pcm_mono_out, &pxa_ssp4_pcm_mono_in,
-		&pxa_ssp4_pcm_stereo_out, &pxa_ssp4_pcm_stereo_in,
-	},
+struct pxa2xx_pcm_dma_data {
+	struct pxa2xx_pcm_dma_params params;
+	char name[20];
 };
 
+static struct pxa2xx_pcm_dma_params *
+ssp_get_dma_params(struct ssp_device *ssp, int stereo, int out)
+{
+	struct pxa2xx_pcm_dma_data *dma;
+
+	dma = kzalloc(sizeof(struct pxa2xx_pcm_dma_data), GFP_KERNEL);
+	if (dma == NULL)
+		return NULL;
+
+	snprintf(dma->name, 20, "SSP%d PCM %s %s", ssp->port_id,
+			stereo ? "Stereo" : "Mono", out ? "out" : "in");
+
+	dma->params.name = dma->name;
+	dma->params.drcmr = &DRCMR(out ? ssp->drcmr_tx : ssp->drcmr_rx);
+	dma->params.dcmd = (out ? (DCMD_INCSRCADDR | DCMD_FLOWTRG) :
+				  (DCMD_INCTRGADDR | DCMD_FLOWSRC)) |
+			(stereo ? DCMD_WIDTH4 : DCMD_WIDTH2) | DCMD_BURST16;
+	dma->params.dev_addr = ssp->phys_base + SSDR;
+
+	return &dma->params;
+}
+
 static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
@@ -227,6 +102,11 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 		clk_enable(priv->dev.ssp->clk);
 		ssp_disable(&priv->dev);
 	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
 	return ret;
 }
 
@@ -241,6 +121,11 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 		ssp_disable(&priv->dev);
 		clk_disable(priv->dev.ssp->clk);
 	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
 }
 
 #ifdef CONFIG_PM
@@ -653,25 +538,23 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct ssp_priv *priv = cpu_dai->private_data;
 	struct ssp_device *ssp = priv->dev.ssp;
-	int dma = 0, chn = params_channels(params);
+	int chn = params_channels(params);
 	u32 sscr0;
 	u32 sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
 
-	/* select correct DMA params */
-	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
-		dma = 1; /* capture DMA offset is 1,3 */
+	/* generate correct DMA params */
+	if (cpu_dai->dma_data)
+		kfree(cpu_dai->dma_data);
+
 	/* Network mode with one active slot (ttsa == 1) can be used
 	 * to force 16-bit frame width on the wire (for S16_LE), even
 	 * with two channels. Use 16-bit DMA transfers for this case.
 	 */
-	if (((chn == 2) && (ttsa != 1)) || (width == 32))
-		dma += 2; /* 32-bit DMA offset is 2, 16-bit is 0 */
-
-	cpu_dai->dma_data = ssp_dma_params[cpu_dai->id][dma];
-
-	dev_dbg(&ssp->pdev->dev, "pxa_ssp_hw_params: dma %d\n", dma);
+	cpu_dai->dma_data = ssp_get_dma_params(ssp,
+			((chn == 2) && (ttsa != 1)) || (width == 32),
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	/* we can only change the settings if the port is not in use */
 	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
-- 
1.5.6.3
