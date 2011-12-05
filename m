From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/5] ASoC: Use core pm_runtime callbacks for
	siu_dai
Date: Mon,  5 Dec 2011 00:01:30 +0000
Message-ID: <1323043291-6797-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9944A1039E0
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 01:01:36 +0100 (CET)
In-Reply-To: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Now that the core holds a pm_runtime reference to the device while the
link is active there is no need for the driver to do so.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/sh/siu_dai.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 11c6085..52d4c17 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -112,9 +112,6 @@ static void siu_dai_start(struct siu_port *port_info)
 
 	dev_dbg(port_info->pcm->card->dev, "%s\n", __func__);
 
-	/* Turn on SIU clock */
-	pm_runtime_get_sync(info->dev);
-
 	/* Issue software reset to siu */
 	siu_write32(base + SIU_SRCTL, 0);
 
@@ -158,9 +155,6 @@ static void siu_dai_stop(struct siu_port *port_info)
 
 	/* SIU software reset */
 	siu_write32(base + SIU_SRCTL, 0);
-
-	/* Turn off SIU clock */
-	pm_runtime_put_sync(info->dev);
 }
 
 static void siu_dai_spbAselect(struct siu_port *port_info)
-- 
1.7.7.3
