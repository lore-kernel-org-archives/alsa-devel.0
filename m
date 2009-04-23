From: Eric Miao <eric.y.miao@gmail.com>
Subject: [RFC PATCH 5/5] ASoC: simplify the SSP DMA parameters settings by
	run-time generation
Date: Thu, 23 Apr 2009 13:08:51 +0800
Message-ID: <f17812d70904222208i79604f3evb9950d6351377a83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <bshen9@marvell.com>
List-Id: alsa-devel@alsa-project.org

The SSP DMA parameters can actually be easily generated at run-time since
they are almost similar except for the FIFO width and direction. Another
benefit is the re-use of information from 'struct ssp_device', like SSDR
physical FIFO address and DRCMR register index for both directions.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 sound/soc/pxa/pxa-ssp.c |  206 ++++++++++-------------------------------------
 1 files changed, 43 insertions(+), 163 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 2ce4fb6..fb7235b 100644
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
@@ -225,6 +100,11 @@ static int pxa_ssp_startup(struct
snd_pcm_substream *substream,
 		clk_enable(priv->ssp->clk);
 		ssp_disable(priv->ssp);
 	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
 	return ret;
 }

@@ -239,6 +119,11 @@ static void pxa_ssp_shutdown(struct
snd_pcm_substream *substream,
 		ssp_disable(priv->ssp);
 		clk_disable(priv->ssp->clk);
 	}
+
+	if (cpu_dai->dma_data) {
+		kfree(cpu_dai->dma_data);
+		cpu_dai->dma_data = NULL;
+	}
 }

 #ifdef CONFIG_PM
@@ -611,25 +496,20 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct ssp_priv *priv = cpu_dai->private_data;
 	struct ssp_device *ssp = priv->ssp;
-	int dma = 0, chn = params_channels(params);
+	int chn = params_channels(params);
 	u32 sscr0;
 	u32 sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;

-	/* select correct DMA params */
-	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
-		dma = 1; /* capture DMA offset is 1,3 */
-	/* Network mode with one active slot (ttsa == 1) can be used
-	 * to force 16-bit frame width on the wire (for S16_LE), even
-	 * with two channels. Use 16-bit DMA transfers for this case.
-	 */
-	if (((chn == 2) && (ttsa != 1)) || (width == 32))
-		dma += 2; /* 32-bit DMA offset is 2, 16-bit is 0 */
-
-	cpu_dai->dma_data = ssp_dma_params[cpu_dai->id][dma];
+	printk("%s\n", __func__);
+	/* generate correct DMA params */
+	if (cpu_dai->dma_data)
+		kfree(cpu_dai->dma_data);

-	dev_dbg(&ssp->pdev->dev, "pxa_ssp_hw_params: dma %d\n", dma);
+	cpu_dai->dma_data = ssp_get_dma_params(ssp,
+			((chn == 2) && (ttsa != 1)) || (width == 32),
+			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);

 	/* we can only change the settings if the port is not in use */
 	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
-- 
1.6.0.4

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
