From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/13] ASoC: Cleanup DAI module reference
	counting
Date: Tue, 19 Aug 2014 15:51:25 +0200
Message-ID: <1408456290-13945-9-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 69C6526569B
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:47 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently when a DAI has no CODEC associated to it the reference on the module
containing the DAI driver is increased when the DAI is probed and decrease when
the DAI is removed. For DAIs with CODECs the module reference count was already
incremented when the CODEC is probed. Now that all components have their module
reference count incremented when they are probed and all DAIs do have a
component it is possible to remove the module reference counting on DAI probe
and removal.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 19b3d2c..59020735 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1067,8 +1067,6 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 					cpu_dai->name, err);
 		}
 		cpu_dai->probed = 0;
-		if (!cpu_dai->codec)
-			module_put(cpu_dai->dev->driver->owner);
 	}
 }
 
@@ -1422,18 +1420,12 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	/* probe the cpu_dai */
 	if (!cpu_dai->probed &&
 			cpu_dai->driver->probe_order == order) {
-		if (!cpu_dai->codec) {
-			if (!try_module_get(cpu_dai->dev->driver->owner))
-				return -ENODEV;
-		}
-
 		if (cpu_dai->driver->probe) {
 			ret = cpu_dai->driver->probe(cpu_dai);
 			if (ret < 0) {
 				dev_err(cpu_dai->dev,
 					"ASoC: failed to probe CPU DAI %s: %d\n",
 					cpu_dai->name, ret);
-				module_put(cpu_dai->dev->driver->owner);
 				return ret;
 			}
 		}
-- 
1.8.0
