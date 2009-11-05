From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH V2] ASoC - Add support for upto 16 channels on
	OMAP MCBSP
Date: Thu, 05 Nov 2009 21:00:08 +0000
Message-ID: <1257454808.3576.397.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 50F422441B
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 22:00:11 +0100 (CET)
Received: by ewy21 with SMTP id 21so1101513ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 13:00:10 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <gg@slimlogic.co.uk>

This patch increases the number of supported audio channels from 4
to 16 and has been sponsored by Shotspotter Inc. It also fixes a
FSYNC rate calculation bug when McBSP is FSYNC master.

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/omap/omap-mcbsp.c |   59 ++++++++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3341f49..3ea4a00 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -49,6 +49,8 @@ struct omap_mcbsp_data {
 	 */
 	int				active;
 	int				configured;
+	unsigned int			in_freq;
+	int				clk_div;
 };
 
 #define to_mcbsp(priv)	container_of((priv), struct omap_mcbsp_data, bus_id)
@@ -257,7 +259,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
 	int wlen, channels, wpf, sync_mode = OMAP_DMA_SYNC_ELEMENT;
 	unsigned long port;
-	unsigned int format;
+	unsigned int format, div, framesize;
 
 	if (cpu_class_is_omap1()) {
 		dma = omap1_dma_reqs[bus_id][substream->stream];
@@ -294,28 +296,19 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 
 	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 	wpf = channels = params_channels(params);
-	switch (channels) {
-	case 2:
-		if (format == SND_SOC_DAIFMT_I2S) {
-			/* Use dual-phase frames */
-			regs->rcr2	|= RPHASE;
-			regs->xcr2	|= XPHASE;
-			/* Set 1 word per (McBSP) frame for phase1 and phase2 */
-			wpf--;
-			regs->rcr2	|= RFRLEN2(wpf - 1);
-			regs->xcr2	|= XFRLEN2(wpf - 1);
-		}
-	case 1:
-	case 4:
-		/* Set word per (McBSP) frame for phase1 */
-		regs->rcr1	|= RFRLEN1(wpf - 1);
-		regs->xcr1	|= XFRLEN1(wpf - 1);
-		break;
-	default:
-		/* Unsupported number of channels */
-		return -EINVAL;
+	if (channels == 2 && format == SND_SOC_DAIFMT_I2S) {
+		/* Use dual-phase frames */
+		regs->rcr2	|= RPHASE;
+		regs->xcr2	|= XPHASE;
+		/* Set 1 word per (McBSP) frame for phase1 and phase2 */
+		wpf--;
+		regs->rcr2	|= RFRLEN2(wpf - 1);
+		regs->xcr2	|= XFRLEN2(wpf - 1);
 	}
 
+	regs->rcr1	|= RFRLEN1(wpf - 1);
+	regs->xcr1	|= XFRLEN1(wpf - 1);
+
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		/* Set word lengths */
@@ -330,15 +323,26 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* In McBSP master modes, FRAME (i.e. sample rate) is generated
+	 * by _counting_ BCLKs. Calculate frame size in BCLKs */
+	div = mcbsp_data->clk_div ? mcbsp_data->clk_div : 1;
+	framesize = (mcbsp_data->in_freq / div) / params_rate(params);
+
+	if (framesize < wlen * channels) {
+		printk(KERN_ERR "%s: not enough bandwidth for desired rate and channels\n",
+				__func__);
+		return -EINVAL;
+	}
+
 	/* Set FS period and length in terms of bit clock periods */
 	switch (format) {
 	case SND_SOC_DAIFMT_I2S:
-		regs->srgr2	|= FPER(wlen * channels - 1);
-		regs->srgr1	|= FWID(wlen - 1);
+		regs->srgr2	|= FPER(framesize - 1);
+		regs->srgr1	|= FWID((framesize >> 1) - 1);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 	case SND_SOC_DAIFMT_DSP_B:
-		regs->srgr2	|= FPER(wlen * channels - 1);
+		regs->srgr2	|= FPER(framesize - 1);
 		regs->srgr1	|= FWID(0);
 		break;
 	}
@@ -454,6 +458,7 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
 	if (div_id != OMAP_MCBSP_CLKGDV)
 		return -ENODEV;
 
+	mcbsp_data->clk_div = div;
 	regs->srgr1	|= CLKGDV(div - 1);
 
 	return 0;
@@ -554,6 +559,8 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int err = 0;
 
+	mcbsp_data->in_freq = freq;
+
 	switch (clk_id) {
 	case OMAP_MCBSP_SYSCLK_CLK:
 		regs->srgr2	|= CLKSM;
@@ -598,13 +605,13 @@ static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
 	.id = (link_id),					\
 	.playback = {						\
 		.channels_min = 1,				\
-		.channels_max = 4,				\
+		.channels_max = 16,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
 	.capture = {						\
 		.channels_min = 1,				\
-		.channels_max = 4,				\
+		.channels_max = 16,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
-- 
1.6.3.3
