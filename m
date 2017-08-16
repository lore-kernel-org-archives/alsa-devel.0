From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core:
	snd_soc_unregister_component() unregister all component" to
	the asoc tree
Date: Wed, 16 Aug 2017 13:09:07 +0100
Message-ID: <E1dhx8F-0005bE-As@finisterre>
References: <8760e0jfwl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 093EF266B1C
 for <alsa-devel@alsa-project.org>; Wed, 16 Aug 2017 14:09:13 +0200 (CEST)
In-Reply-To: <8760e0jfwl.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: snd_soc_unregister_component() unregister all component

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2eccea8cdeb8fe455fc3a45b4e097f118449c3ef Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 7 Aug 2017 02:06:55 +0000
Subject: [PATCH] ASoC: soc-core: snd_soc_unregister_component() unregister all
 component

Current snd_soc_unregister_component() unregisters first found
component only which was specified by dev.
This style can't specify concrete component if system registered some
component with same dev. And system need to call this function many
times.
This patch unregister all related component by 1 call.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b1860b14b075..50c8dba54649 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3365,11 +3365,12 @@ int snd_soc_register_component(struct device *dev,
 EXPORT_SYMBOL_GPL(snd_soc_register_component);
 
 /**
- * snd_soc_unregister_component - Unregister a component from the ASoC core
+ * snd_soc_unregister_component - Unregister all related component
+ * from the ASoC core
  *
  * @dev: The device to unregister
  */
-void snd_soc_unregister_component(struct device *dev)
+static int __snd_soc_unregister_component(struct device *dev)
 {
 	struct snd_soc_component *component;
 	int found = 0;
@@ -3391,6 +3392,13 @@ void snd_soc_unregister_component(struct device *dev)
 		snd_soc_component_cleanup(component);
 		kfree(component);
 	}
+
+	return found;
+}
+
+void snd_soc_unregister_component(struct device *dev)
+{
+	while (__snd_soc_unregister_component(dev));
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
-- 
2.13.2
