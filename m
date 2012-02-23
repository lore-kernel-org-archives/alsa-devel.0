From: Javier Martin <javier.martin@vista-silicon.com>
Subject: [PATCH] ASoC: i.MX SSI: Fix DSP_A format.
Date: Thu, 23 Feb 2012 15:43:18 +0100
Message-ID: <1330008198-31142-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7109A244A7
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 15:43:30 +0100 (CET)
Received: by wgbdt11 with SMTP id dt11so5960362wgb.2
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 06:43:28 -0800 (PST)
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
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, Javier Martin <javier.martin@vista-silicon.com>, axel.lin@gmail.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

According to i.MX27 Reference Manual (p 1593) TXBIT0 bit selects
whether the most significant or the less significant part of the
data word written to the FIFO is transmitted.

As DSP_A is the same as DSP_B with a data offset of 1 bit, it
doesn't make any sense to remove TXBIT0 bit here.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
---
 sound/soc/imx/imx-ssi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 01d1f74..b6adbed 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -112,7 +112,7 @@ static int imx_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* data on rising edge of bclk, frame high 1clk before data */
-		strcr |= SSI_STCR_TFSL | SSI_STCR_TEFS;
+		strcr |= SSI_STCR_TFSL | SSI_STCR_TXBIT0 | SSI_STCR_TEFS;
 		break;
 	}
 
-- 
1.7.0.4
