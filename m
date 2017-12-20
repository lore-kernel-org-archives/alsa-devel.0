From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove dai_drv from
	snd_soc_component" to the asoc tree
Date: Wed, 20 Dec 2017 15:42:23 +0000
Message-ID: <E1eRgVj-00011b-KL@debutante>
References: <87tvwmxjnu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 64CD62677FD
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 16:42:27 +0100 (CET)
In-Reply-To: <87tvwmxjnu.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove dai_drv from snd_soc_component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 58bf4179000a37aa9b0ee9ab2796f7573c77fff0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Dec 2017 01:48:29 +0000
Subject: [PATCH] ASoC: soc-core: remove dai_drv from snd_soc_component

ALSA SoC has some duplicate parameter.
snd_soc_component::dai_drv is one of them.

Each DAI is keeping its driver as snd_soc_dai::driver,
and component has dai_list.
This means, we can reach to each DAI and its driver by using dai_link.
Thus, there is no need to keep DAI driver pointer on component.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  1 -
 sound/soc/soc-core.c | 14 ++++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1a7323238c49..871e1fabd701 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -858,7 +858,6 @@ struct snd_soc_component {
 	struct list_head card_aux_list; /* for auxiliary bound components */
 	struct list_head card_list;
 
-	struct snd_soc_dai_driver *dai_drv;
 	int num_dai;
 
 	const struct snd_soc_component_driver *driver;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0edac80df34..6a13fbcba23f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3149,7 +3149,7 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
 	if (!dai->driver->ops)
 		dai->driver->ops = &null_dai_ops;
 
-	list_add(&dai->list, &component->dai_list);
+	list_add_tail(&dai->list, &component->dai_list);
 	component->num_dai++;
 
 	dev_dbg(dev, "ASoC: Registered DAI '%s'\n", dai->name);
@@ -3176,8 +3176,6 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 
 	dev_dbg(dev, "ASoC: dai register %s #%zu\n", dev_name(dev), count);
 
-	component->dai_drv = dai_drv;
-
 	for (i = 0; i < count; i++) {
 
 		dai = soc_add_dai(component, dai_drv + i,
@@ -4354,6 +4352,7 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 							     args,
 							     dai_name);
 		} else {
+			struct snd_soc_dai *dai;
 			int id = -1;
 
 			switch (args->args_count) {
@@ -4375,7 +4374,14 @@ int snd_soc_get_dai_name(struct of_phandle_args *args,
 
 			ret = 0;
 
-			*dai_name = pos->dai_drv[id].name;
+			/* find target DAI */
+			list_for_each_entry(dai, &pos->dai_list, list) {
+				if (id == 0)
+					break;
+				id--;
+			}
+
+			*dai_name = dai->driver->name;
 			if (!*dai_name)
 				*dai_name = pos->name;
 		}
-- 
2.15.1
