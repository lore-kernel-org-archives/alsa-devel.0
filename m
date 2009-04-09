From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/3] ASoC: omap-mcbsp: change the DSP_B mode to
	DSP_A mode
Date: Thu,  9 Apr 2009 12:34:41 +0300
Message-ID: <1239269682-21309-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239269682-21309-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D775B24377
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 11:34:52 +0200 (CEST)
In-Reply-To: <1239269682-21309-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: jarkko.nikula@nokia.com, broonie@opensource.wolfsonmicro.com, arunks@mistralsolutions.com
List-Id: alsa-devel@alsa-project.org

The current DSP_B configuration is valid for the DSP_A format.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 9c09b94..aa41fba 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -281,7 +281,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		regs->srgr2	|= FPER(wlen * 2 - 1);
 		regs->srgr1	|= FWID(wlen - 1);
 		break;
-	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
 		regs->srgr2	|= FPER(wlen * channels - 1);
 		regs->srgr1	|= FWID(wlen * channels - 2);
 		break;
@@ -324,7 +324,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		regs->rcr2	|= RDATDLY(1);
 		regs->xcr2	|= XDATDLY(1);
 		break;
-	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
-- 
1.6.2.2
