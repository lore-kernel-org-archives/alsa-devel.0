From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2] ASoC: omap-mcbsp: Add support for Left
	Justified format
Date: Fri, 19 Mar 2010 12:27:31 +0200
Message-ID: <1268994451-23682-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id E36C4243AC
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 11:27:38 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Basic support for Left Justified coding for OMAP McBSP.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 2952fb0..0199e95 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -331,7 +331,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 
 	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 	wpf = channels = params_channels(params);
-	if (channels == 2 && format == SND_SOC_DAIFMT_I2S) {
+	if (channels == 2 && (format == SND_SOC_DAIFMT_I2S ||
+			      format == SND_SOC_DAIFMT_LEFT_J)) {
 		/* Use dual-phase frames */
 		regs->rcr2	|= RPHASE;
 		regs->xcr2	|= XPHASE;
@@ -376,6 +377,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	/* Set FS period and length in terms of bit clock periods */
 	switch (format) {
 	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
 		regs->srgr2	|= FPER(framesize - 1);
 		regs->srgr1	|= FWID((framesize >> 1) - 1);
 		break;
@@ -427,6 +429,14 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		/* 0-bit data delay */
+		regs->rcr2	|= RDATDLY(0);
+		regs->xcr2	|= XDATDLY(0);
+		regs->spcr1	|= RJUST(2);
+		/* Invert FS polarity configuration */
+		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
+		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* 1-bit data delay */
 		regs->rcr2      |= RDATDLY(1);
-- 
1.7.0.2
