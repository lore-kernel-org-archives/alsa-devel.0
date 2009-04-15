From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: OMAP: Use single-phase for DSP mode
Date: Wed, 15 Apr 2009 15:38:55 +0300
Message-ID: <1239799136-28729-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D71F01038CF
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 14:39:21 +0200 (CEST)
In-Reply-To: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Use single-phase mode for the DSP mode and keep the dual phase
mode for the I2S mode.

The mono (1 channel) mode already used single phase mode,
now it is more cleaner. There is no need to configure the
second phase, when the single phase is used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 90f4df7..5857c3c 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -214,8 +214,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
-	int wlen, channels;
+	int wlen, channels, wpf;
 	unsigned long port;
+	unsigned int format;
 
 	if (cpu_class_is_omap1()) {
 		dma = omap1_dma_reqs[bus_id][substream->stream];
@@ -243,18 +244,23 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	channels = params_channels(params);
+	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+	wpf = channels = params_channels(params);
 	switch (channels) {
 	case 2:
-		/* Use dual-phase frames */
-		regs->rcr2	|= RPHASE;
-		regs->xcr2	|= XPHASE;
+		if (format == SND_SOC_DAIFMT_I2S) {
+			/* Use dual-phase frames */
+			regs->rcr2	|= RPHASE;
+			regs->xcr2	|= XPHASE;
+			/* Set 1 word per (McBSP) frame for phase1 and phase2 */
+			wpf--;
+			regs->rcr2	|= RFRLEN2(wpf - 1);
+			regs->xcr2	|= XFRLEN2(wpf - 1);
+		}
 	case 1:
-		/* Set 1 word per (McBSP) frame */
-		regs->rcr2	|= RFRLEN2(1 - 1);
-		regs->rcr1	|= RFRLEN1(1 - 1);
-		regs->xcr2	|= XFRLEN2(1 - 1);
-		regs->xcr1	|= XFRLEN1(1 - 1);
+		/* Set word per (McBSP) frame for phase1 */
+		regs->rcr1	|= RFRLEN1(wpf - 1);
+		regs->xcr1	|= XFRLEN1(wpf - 1);
 		break;
 	default:
 		/* Unsupported number of channels */
@@ -276,9 +282,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Set FS period and length in terms of bit clock periods */
-	switch (mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	switch (format) {
 	case SND_SOC_DAIFMT_I2S:
-		regs->srgr2	|= FPER(wlen * 2 - 1);
+		regs->srgr2	|= FPER(wlen * channels - 1);
 		regs->srgr1	|= FWID(wlen - 1);
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-- 
1.6.2.3
