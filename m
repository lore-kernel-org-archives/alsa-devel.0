From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Use core pm_runtime callbacks for
	omap-mcpdm
Date: Mon,  5 Dec 2011 00:01:29 +0000
Message-ID: <1323043291-6797-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BBDC1039DD
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
 sound/soc/omap/omap-mcpdm.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index b50ac60..0e25df4f 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -266,8 +266,6 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 	mutex_lock(&mcpdm->mutex);
 
 	if (!dai->active) {
-		pm_runtime_get_sync(mcpdm->dev);
-
 		/* Enable watch dog for ES above ES 1.0 to avoid saturation */
 		if (omap_rev() != OMAP4430_REV_ES1_0) {
 			u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
@@ -295,9 +293,6 @@ static void omap_mcpdm_dai_shutdown(struct snd_pcm_substream *substream,
 			omap_mcpdm_stop(mcpdm);
 			omap_mcpdm_close_streams(mcpdm);
 		}
-
-		if (!omap_mcpdm_active(mcpdm))
-			pm_runtime_put_sync(mcpdm->dev);
 	}
 
 	mutex_unlock(&mcpdm->mutex);
-- 
1.7.7.3
