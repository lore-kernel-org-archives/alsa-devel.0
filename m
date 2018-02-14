From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove legacy_dai_naming from
	snd_soc_register_dais()" to the asoc tree
Date: Wed, 14 Feb 2018 13:29:25 +0000
Message-ID: <E1elx7l-000732-Vs@debutante>
References: <87tvukb7ra.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 380C1267B0C
 for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2018 14:29:29 +0100 (CET)
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

>From a8768c52c511e92d9c9816cecaec4bca77da8a89 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Feb 2018 02:56:36 +0000
Subject: [PATCH] ASoC: soc-core: remove legacy_dai_naming from
 snd_soc_register_dais()

We can get legacy dai name flag from component driver.
Thus, there is no need to have its parameter on snd_soc_register_dais().
Let's remove unneeded parameter

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 574048a73b1c..b928c59ea775 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3150,8 +3150,7 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
  *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
-	struct snd_soc_dai_driver *dai_drv, size_t count,
-	bool legacy_dai_naming)
+				 struct snd_soc_dai_driver *dai_drv, size_t count)
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
@@ -3163,7 +3162,7 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 	for (i = 0; i < count; i++) {
 
 		dai = soc_add_dai(component, dai_drv + i,
-				count == 1 && legacy_dai_naming);
+				  count == 1 && !component->driver->non_legacy_dai_naming);
 		if (dai == NULL) {
 			ret = -ENOMEM;
 			goto err;
@@ -3444,8 +3443,7 @@ int snd_soc_add_component(struct device *dev,
 		}
 	}
 
-	ret = snd_soc_register_dais(component, dai_drv, num_dai,
-				    !component_driver->non_legacy_dai_naming);
+	ret = snd_soc_register_dais(component, dai_drv, num_dai);
 	if (ret < 0) {
 		dev_err(dev, "ASoC: Failed to register DAIs: %d\n", ret);
 		goto err_cleanup;
-- 
2.16.1
