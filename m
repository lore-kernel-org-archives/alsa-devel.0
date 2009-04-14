From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B mode
Date: Tue, 14 Apr 2009 10:45:30 +0300
Message-ID: <1239695131-30367-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 660EE24481
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 09:45:37 +0200 (CEST)
In-Reply-To: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
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

Use correct DSP_B mode configuration for omap-mcbsp.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 9c09b94..4440bab 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -283,7 +283,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		regs->srgr2	|= FPER(wlen * channels - 1);
-		regs->srgr1	|= FWID(wlen * channels - 2);
+		regs->srgr1	|= FWID(0);
 		break;
 	}
 
-- 
1.6.2.2
