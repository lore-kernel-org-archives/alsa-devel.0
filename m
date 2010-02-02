From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: fix PXA SSP port resume
Date: Tue,  2 Feb 2010 11:32:55 +0800
Message-ID: <1265081575-24583-1-git-send-email-daniel@caiaq.de>
References: <20100129140001.GB4768@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D28624443
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 04:33:23 +0100 (CET)
In-Reply-To: <20100129140001.GB4768@rakim.wolfsonmicro.main>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Unconditionally save the register states in resume and restore them
again at resume time. Register contents are not preserved over suspend,
and the driver takes false assumptions about them otherwise.

The clock must be enabled to access the register block.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3bd7712..e69397f 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -135,10 +135,11 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 	struct ssp_priv *priv = cpu_dai->private_data;
 
 	if (!cpu_dai->active)
-		return 0;
+		clk_enable(priv->dev.ssp->clk);
 
 	ssp_save_state(&priv->dev, &priv->state);
 	clk_disable(priv->dev.ssp->clk);
+
 	return 0;
 }
 
@@ -146,12 +147,13 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
 
-	if (!cpu_dai->active)
-		return 0;
-
 	clk_enable(priv->dev.ssp->clk);
 	ssp_restore_state(&priv->dev, &priv->state);
-	ssp_enable(&priv->dev);
+
+	if (cpu_dai->active)
+		ssp_enable(&priv->dev);
+	else
+		clk_disable(priv->dev.ssp->clk);
 
 	return 0;
 }
-- 
1.6.3.3
