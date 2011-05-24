From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - fix module reference counting for
	CPU DAIs
Date: Tue, 24 May 2011 13:57:43 +0100
Message-ID: <1306241863-3985-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id ABBE8103809
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 14:57:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently CODEC and platform drivers have their module reference count
incremented soc_probe_dai_link() whilst CPU DAI drivers have their reference
count incremented in soc_bind_dai_link().

CPU DAIs should have their reference count incremented in soc_probe_dai_link()
just like the CODEC and platform drivers.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5968745..f051e85 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1306,10 +1306,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	/* no, then find CPU DAI from registered DAIs*/
 	list_for_each_entry(cpu_dai, &dai_list, list) {
 		if (!strcmp(cpu_dai->name, dai_link->cpu_dai_name)) {
-
-			if (!try_module_get(cpu_dai->dev->driver->owner))
-				return -ENODEV;
-
 			rtd->cpu_dai = cpu_dai;
 			goto find_codec;
 		}
@@ -1621,12 +1617,17 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	rtd->pmdown_time = pmdown_time;
 
 	/* probe the cpu_dai */
+
 	if (!cpu_dai->probed) {
+		if (!try_module_get(cpu_dai->dev->driver->owner))
+			return -ENODEV;
+
 		if (cpu_dai->driver->probe) {
 			ret = cpu_dai->driver->probe(cpu_dai);
 			if (ret < 0) {
 				printk(KERN_ERR "asoc: failed to probe CPU DAI %s\n",
 						cpu_dai->name);
+				module_put(cpu_dai->dev->driver->owner);
 				return ret;
 			}
 		}
-- 
1.7.4.1
