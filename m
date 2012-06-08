From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 1/4] ASoC: when initializing CPU DAI,
	don't duplicate any CODEC init
Date: Fri,  8 Jun 2012 12:34:20 -0600
Message-ID: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B545C103EC0
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 20:34:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

If the CPU-side of a DAI link is a CODEC rather than a standalone DAI,
the codec initialization will call try_module_get() and create the DAI
widgets. Ensure that this isn't duplicated when the CPU DAI itself is
probed, if the CPU DAI is part of a CODEC.

Note that this is not a complete fix on its own, since there's no
guarantee that the CODEC itself will be initialized - currently that only
happens if the CODEC is also used as the CODEC-side of a DAI link, and
that initialization may happen before or after the DAIs within the CODEC
are initialized. However, such a scenario doesn't necessarily currently
work, and I don't think this change alone makes it any worse. This is
fixed in a couple patches time.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3d803f3..448d4a7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -983,7 +983,9 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 		}
 		cpu_dai->probed = 0;
 		list_del(&cpu_dai->card_list);
-		module_put(cpu_dai->dev->driver->owner);
+
+		if (!cpu_dai->codec)
+			module_put(cpu_dai->dev->driver->owner);
 	}
 }
 
@@ -1257,11 +1259,13 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 	/* probe the cpu_dai */
 	if (!cpu_dai->probed &&
 			cpu_dai->driver->probe_order == order) {
-		cpu_dai->dapm.card = card;
-		if (!try_module_get(cpu_dai->dev->driver->owner))
-			return -ENODEV;
+		if (!cpu_dai->codec) {
+			cpu_dai->dapm.card = card;
+			if (!try_module_get(cpu_dai->dev->driver->owner))
+				return -ENODEV;
 
-		snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
+			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
+		}
 
 		if (cpu_dai->driver->probe) {
 			ret = cpu_dai->driver->probe(cpu_dai);
-- 
1.7.0.4
