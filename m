From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove legacy_dai_naming from
	snd_soc_register_dais()" to the asoc tree
Date: Wed,  9 May 2018 10:41:54 +0100 (BST)
Message-ID: <20180509094154.BAC9944007A@finisterre.ee.mobilebroadband>
References: <87tvukb7ra.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B1F04267742
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:04 +0200 (CEST)
In-Reply-To: <87tvukb7ra.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove legacy_dai_naming from snd_soc_register_dais()

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

>From 0e7b25c673ec916dee8d927fc8de5806d900cba8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:23:01 +0000
Subject: [PATCH] ASoC: soc-core: remove legacy_dai_naming from
 snd_soc_register_dais()

We can get legacy dai name flag from component driver.
Thus, there is no need to have its parameter on snd_soc_register_dais().
Let's remove unneeded parameter

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2d3abb3f1231..3d56f1fe5914 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2783,8 +2783,7 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
  *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
-	struct snd_soc_dai_driver *dai_drv, size_t count,
-	bool legacy_dai_naming)
+				 struct snd_soc_dai_driver *dai_drv, size_t count)
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
@@ -2796,7 +2795,7 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	for (i = 0; i < count; i++) {
 
 		dai = soc_add_dai(component, dai_drv + i,
-				count == 1 && legacy_dai_naming);
+				  count == 1 && !component->driver->non_legacy_dai_naming);
 		if (dai == NULL) {
 			ret = -ENOMEM;
 			goto err;
@@ -3046,8 +3045,7 @@ int snd_soc_add_component(struct device *dev,
 		}
 	}
 
-	ret = snd_soc_register_dais(component, dai_drv, num_dai,
-				    !component_driver->non_legacy_dai_naming);
+	ret = snd_soc_register_dais(component, dai_drv, num_dai);
 	if (ret < 0) {
 		dev_err(dev, "ASoC: Failed to register DAIs: %d\n", ret);
 		goto err_cleanup;
-- 
2.17.0
