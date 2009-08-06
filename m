From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Thu,  6 Aug 2009 15:55:18 +0100
Message-ID: <1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F275A24552
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 16:55:21 +0200 (CEST)
In-Reply-To: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Shen <boshen9@gmail.com>, Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Ribeiro <drwyrm@gmail.com>

* Automatically sets TDM mode for frame_width larger than 32 bits, if
  the user doesn't setup the TDM slots with set_tdm_slot().
* Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
* Makes SSCR0_MOD optional.
* Clears SSCR1_RWOT case SSCR0_MOD is set.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa-ssp.c |   92 +++++++++++++++++++++++++++--------------------
 1 files changed, 53 insertions(+), 39 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 5b9ed64..d60492e 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -452,8 +452,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	}
 
 	/* reset port settings */
-	sscr0 = ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+	sscr0 = ssp_read_reg(ssp, SSCR0) & (SSCR0_ECS | SSCR0_NCS | SSCR0_MOD |
+			SSCR0_ACS | SSCR0_DSS | SSCR0_EDSS);
 	sscr1 = SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp = 0;
 
@@ -496,7 +496,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |= SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
-		sscr0 |= SSCR0_MOD | SSCR0_PSP;
+		sscr0 |= SSCR0_PSP;
 		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
 		break;
 
@@ -532,48 +532,70 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	struct ssp_priv *priv = cpu_dai->private_data;
 	struct ssp_device *ssp = priv->dev.ssp;
 	int chn = params_channels(params);
-	u32 sscr0;
-	u32 sspsp;
+	u32 sscr0, sscr1, sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
-	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
+	int slot_width, frame_width = 0;
+
+	/* check if the user explicitly set a slot_width */
+	sscr0 = ssp_read_reg(ssp, SSCR0);
+
+	if (sscr0 & (SSCR0_EDSS | SSCR0_DSS))
+		slot_width = (sscr0 & SSCR0_DSS) +
+			(sscr0 & SSCR0_EDSS ? 17 : 1);
+	else
+		frame_width = slot_width = width * chn;
 
 	/* generate correct DMA params */
 	if (cpu_dai->dma_data)
 		kfree(cpu_dai->dma_data);
 
-	/* Network mode with one active slot (ttsa == 1) can be used
-	 * to force 16-bit frame width on the wire (for S16_LE), even
-	 * with two channels. Use 16-bit DMA transfers for this case.
-	 */
-	cpu_dai->dma_data = ssp_get_dma_params(ssp,
-			((chn == 2) && (ttsa != 1)) || (width == 32),
+	cpu_dai->dma_data = ssp_get_dma_params(ssp, slot_width > 16,
 			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
 	/* we can only change the settings if the port is not in use */
-	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
+	if (sscr0 & SSCR0_SSE)
 		return 0;
 
-	/* clear selected SSP bits */
-	sscr0 = ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	ssp_write_reg(ssp, SSCR0, sscr0);
-
-	/* bit size */
-	sscr0 = ssp_read_reg(ssp, SSCR0);
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
 #ifdef CONFIG_PXA3xx
-		if (cpu_is_pxa3xx())
-			sscr0 |= SSCR0_FPCKE;
+	if (slot_width == 16 && cpu_is_pxa3xx())
+		sscr0 |= SSCR0_FPCKE;
 #endif
-		sscr0 |= SSCR0_DataSize(16);
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(8));
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		sscr0 |= (SSCR0_EDSS | SSCR0_DataSize(16));
-		break;
+
+	if (frame_width > 0) {
+		/* Not using network mode */
+		if (frame_width > 16)
+			sscr0 |= SSCR0_EDSS | SSCR0_DataSize(frame_width - 16);
+		else
+			sscr0 |= SSCR0_DataSize(frame_width);
+
+		if (frame_width > 32) {
+			/*
+			 * Network mode is needed to support this frame width.
+			 * We assume the wire is not networked and setup a
+			 * fake network mode here. Use as many slots as needed
+			 * each with 32 bits.
+			 */
+			int slots = frame_width / 32;
+
+			sscr0 |= SSCR0_MOD;
+			sscr0 |= SSCR0_SlotsPerFrm(slots);
+
+			/*
+			 * Set active slots. Only set an active TX slot
+			 * if we are going to use it.
+			 */
+			ssp_write_reg(ssp, SSRSA, slots - 1);
+			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+				ssp_write_reg(ssp, SSTSA, slots - 1);
+		}
 	}
+
+	/* If SSCR0_MOD is set we can't use SSCR1_RWOT */
+	if (sscr0 & SSCR0_MOD) {
+		sscr1 = ssp_read_reg(ssp, SSCR1);
+		ssp_write_reg(ssp, SSCR1, sscr1 & ~SSCR1_RWOT);
+	}
+
 	ssp_write_reg(ssp, SSCR0, sscr0);
 
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -620,14 +642,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/* When we use a network mode, we always require TDM slots
-	 * - complain loudly and fail if they've not been set up yet.
-	 */
-	if ((sscr0 & SSCR0_MOD) && !ttsa) {
-		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
-		return -EINVAL;
-	}
-
 	dump_registers(ssp);
 
 	return 0;
-- 
1.6.3.3
