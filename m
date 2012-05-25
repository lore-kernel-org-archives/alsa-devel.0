From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 15/15] ASoC: mxs-saif: Use
	clk_prepare_enable/clk_disable_unprepare
Date: Fri, 25 May 2012 20:14:56 -0300
Message-ID: <1337987696-31728-15-git-send-email-festevam@gmail.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E6A2C103EFC
	for <alsa-devel@alsa-project.org>;
	Sat, 26 May 2012 01:15:46 +0200 (CEST)
Received: by vbip1 with SMTP id p1so1058040vbi.38
	for <alsa-devel@alsa-project.org>; Fri, 25 May 2012 16:15:46 -0700 (PDT)
In-Reply-To: <1337987696-31728-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kernel@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Prepare the clock before enabling it.

Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: <alsa-devel@alsa-project.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-saif.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index aba71bf..15ad61a 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -482,7 +482,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		dev_dbg(cpu_dai->dev, "start\n");
 
-		clk_enable(master_saif->clk);
+		clk_prepare_enable(master_saif->clk);
 		if (!master_saif->mclk_in_use)
 			__raw_writel(BM_SAIF_CTRL_RUN,
 				master_saif->base + SAIF_CTRL + MXS_SET_ADDR);
@@ -492,7 +492,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 		 * itself clk for its internal basic logic to work.
 		 */
 		if (saif != master_saif) {
-			clk_enable(saif->clk);
+			clk_prepare_enable(saif->clk);
 			__raw_writel(BM_SAIF_CTRL_RUN,
 				saif->base + SAIF_CTRL + MXS_SET_ADDR);
 		}
@@ -534,13 +534,13 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 				master_saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 			udelay(delay);
 		}
-		clk_disable(master_saif->clk);
+		clk_disable_unprepare(master_saif->clk);
 
 		if (saif != master_saif) {
 			__raw_writel(BM_SAIF_CTRL_RUN,
 				saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 			udelay(delay);
-			clk_disable(saif->clk);
+			clk_disable_unprepare(saif->clk);
 		}
 
 		master_saif->ongoing = 0;
-- 
1.7.1
