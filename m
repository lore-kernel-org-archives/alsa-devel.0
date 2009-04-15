From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: OMAP: Add DSP_A mode support for
	mcbsp
Date: Wed, 15 Apr 2009 15:38:56 +0300
Message-ID: <1239799136-28729-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1239799136-28729-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239799136-28729-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id C80BD1038CF
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 14:39:23 +0200 (CEST)
In-Reply-To: <1239799136-28729-2-git-send-email-peter.ujfalusi@nokia.com>
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

DSP_A mode is similar to the DSP_B, but the MSB is delayed with
one bclk (appears after the FS pulse and not under it).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 5857c3c..4d6ef0b 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -287,6 +287,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		regs->srgr2	|= FPER(wlen * channels - 1);
 		regs->srgr1	|= FWID(wlen - 1);
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
 	case SND_SOC_DAIFMT_DSP_B:
 		regs->srgr2	|= FPER(wlen * channels - 1);
 		regs->srgr1	|= FWID(0);
@@ -331,6 +332,13 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		/* 1-bit data delay */
+		regs->rcr2      |= RDATDLY(1);
+		regs->xcr2      |= XDATDLY(1);
+		/* Invert FS polarity configuration */
+		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
+		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
-- 
1.6.2.3
