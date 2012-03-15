From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] ASoC: pxa2xx-i2s: Add
	clk_prepare/clk_unprepare calls
Date: Thu, 15 Mar 2012 19:16:12 +0100
Message-ID: <1331835372.14662.8.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9CDA0104614
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 19:16:17 +0100 (CET)
Received: by eaak11 with SMTP id k11so1843805eaa.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 11:16:14 -0700 (PDT)
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
Cc: MarkBrown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This patch adds clk_prepare/clk_unprepare calls to the pxa2xx-i2s
driver by using the helper functions clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 609abd5..453b092 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -165,7 +165,7 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct pxa2xx_pcm_dma_params *dma_data;
 
 	BUG_ON(IS_ERR(clk_i2s));
-	clk_enable(clk_i2s);
+	clk_prepare_enable(clk_i2s);
 	clk_ena = 1;
 	pxa_i2s_wait();
 
@@ -258,7 +258,7 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
 		SACR0 &= ~SACR0_ENB;
 		pxa_i2s_wait();
 		if (clk_ena) {
-			clk_disable(clk_i2s);
+			clk_disable_unprepare(clk_i2s);
 			clk_ena = 0;
 		}
 	}
-- 
1.7.9.1
