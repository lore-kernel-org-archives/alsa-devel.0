From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/6] ASoC: OMAP mcbsp: Add 4 channel support
Date: Mon,  6 Apr 2009 15:19:28 +0300
Message-ID: <1239020372-8457-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4560A2436D
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:20:00 +0200 (CEST)
In-Reply-To: <1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Add 4 channel support (with DSP_A format) to omap-mcbsp.
This mode is used by the twl4030 codec, when it is configured
in Option2 mode.

Also fixes the DSP_B mode, since it has to have single-phase
configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d88e4cd..eca50cc 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -216,6 +216,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
 	int wlen, channels;
 	unsigned long port;
+	unsigned int format;
 
 	if (cpu_class_is_omap1()) {
 		dma = omap1_dma_reqs[bus_id][substream->stream];
@@ -243,12 +244,22 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
+	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 	channels = params_channels(params);
 	switch (channels) {
 	case 2:
-		/* Use dual-phase frames */
-		regs->rcr2	|= RPHASE;
-		regs->xcr2	|= XPHASE;
+	case 4:
+		if (format == SND_SOC_DAIFMT_DSP_A ||
+		    format == SND_SOC_DAIFMT_DSP_B) {
+			/* Use single-phase frames */
+			regs->rcr1	|= RFRLEN1(channels - 1);
+			regs->xcr1	|= XFRLEN1(channels - 1);
+			break;
+		} else {
+			/* Use dual-phase frames */
+			regs->rcr2	|= RPHASE;
+			regs->xcr2	|= XPHASE;
+		}
 	case 1:
 		/* Set 1 word per (McBSP) frame */
 		regs->rcr2	|= RFRLEN2(1 - 1);
@@ -276,7 +287,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* Set FS period and length in terms of bit clock periods */
-	switch (mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	switch (format) {
 	case SND_SOC_DAIFMT_I2S:
 		regs->srgr2	|= FPER(wlen * 2 - 1);
 		regs->srgr1	|= FWID(wlen - 1);
@@ -490,13 +501,13 @@ static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
 	.id = (link_id),					\
 	.playback = {						\
 		.channels_min = 1,				\
-		.channels_max = 2,				\
+		.channels_max = 4,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
 	.capture = {						\
 		.channels_min = 1,				\
-		.channels_max = 2,				\
+		.channels_max = 4,				\
 		.rates = OMAP_MCBSP_RATES,			\
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
 	},							\
-- 
1.6.2.2
