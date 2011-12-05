From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: Use core pm_runtime callbacks for
	omap-dmic
Date: Mon,  5 Dec 2011 00:01:28 +0000
Message-ID: <1323043291-6797-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323043291-6797-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 631E81039B0
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
 sound/soc/omap/omap-dmic.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 9c73c0c..0855c1c 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -114,7 +114,6 @@ static int omap_dmic_dai_startup(struct snd_pcm_substream *substream,
 	mutex_lock(&dmic->mutex);
 
 	if (!dai->active) {
-		pm_runtime_get_sync(dmic->dev);
 		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
 		dmic->active = 1;
 	} else {
@@ -133,10 +132,8 @@ static void omap_dmic_dai_shutdown(struct snd_pcm_substream *substream,
 
 	mutex_lock(&dmic->mutex);
 
-	if (!dai->active) {
-		pm_runtime_put_sync(dmic->dev);
+	if (!dai->active)
 		dmic->active = 0;
-	}
 
 	mutex_unlock(&dmic->mutex);
 }
-- 
1.7.7.3
