From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/6] ASoC: OMAP mcbsp: Add DSP_A support
Date: Mon,  6 Apr 2009 15:19:27 +0300
Message-ID: <1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A392824359
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:19:43 +0200 (CEST)
In-Reply-To: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
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

Add SND_SOC_DAIFMT_DSP_A support for omap-mcbsp.
The configuration for DSP_A and DSP_B is the same.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 9c09b94..d88e4cd 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -282,6 +282,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		regs->srgr1	|= FWID(wlen - 1);
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
 		regs->srgr2	|= FPER(wlen * channels - 1);
 		regs->srgr1	|= FWID(wlen * channels - 2);
 		break;
@@ -325,6 +326,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->xcr2	|= XDATDLY(1);
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
-- 
1.6.2.2
