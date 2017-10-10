From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add snd_soc_add_component()"
	to the asoc tree
Date: Tue, 10 Oct 2017 10:19:42 +0100
Message-ID: <E1e1qhS-0003YE-RJ@debutante>
References: <87val3m1m3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 723AE26727C
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 11:19:50 +0200 (CEST)
In-Reply-To: <87val3m1m3.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: add snd_soc_add_component()

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

>From e0dac41b8c21d41534b04d520c1927c2b0ac9b5e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Oct 2017 05:10:17 +0000
Subject: [PATCH] ASoC: soc-core: add snd_soc_add_component()

ALSA SoC platform/codec will be replaced to component soon.
But, some function exist in "platform" doesn't exist in "component".
Current soc-core has snd_soc_register_component(), but
doesn't have snd_soc_add_component() like snd_soc_add_platform().
This patch adds it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  5 +++++
 sound/soc/soc-core.c | 34 +++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 996bdbc125a5..580da1e4f141 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -468,6 +468,11 @@ int snd_soc_register_codec(struct device *dev,
 		const struct snd_soc_codec_driver *codec_drv,
 		struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_codec(struct device *dev);
+int snd_soc_add_component(struct device *dev,
+		struct snd_soc_component *component,
+		const struct snd_soc_component_driver *component_driver,
+		struct snd_soc_dai_driver *dai_drv,
+		int num_dai);
 int snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fee4b0ef5566..3a1c3b44de5e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3371,20 +3371,14 @@ static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
 	list_del(&component->list);
 }
 
-int snd_soc_register_component(struct device *dev,
-			       const struct snd_soc_component_driver *component_driver,
-			       struct snd_soc_dai_driver *dai_drv,
-			       int num_dai)
+int snd_soc_add_component(struct device *dev,
+			struct snd_soc_component *component,
+			const struct snd_soc_component_driver *component_driver,
+			struct snd_soc_dai_driver *dai_drv,
+			int num_dai)
 {
-	struct snd_soc_component *component;
 	int ret;
 
-	component = kzalloc(sizeof(*component), GFP_KERNEL);
-	if (!component) {
-		dev_err(dev, "ASoC: Failed to allocate memory\n");
-		return -ENOMEM;
-	}
-
 	ret = snd_soc_component_initialize(component, component_driver, dev);
 	if (ret)
 		goto err_free;
@@ -3408,6 +3402,24 @@ int snd_soc_register_component(struct device *dev,
 	kfree(component);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(snd_soc_add_component);
+
+int snd_soc_register_component(struct device *dev,
+			const struct snd_soc_component_driver *component_driver,
+			struct snd_soc_dai_driver *dai_drv,
+			int num_dai)
+{
+	struct snd_soc_component *component;
+
+	component = kzalloc(sizeof(*component), GFP_KERNEL);
+	if (!component) {
+		dev_err(dev, "ASoC: Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	return snd_soc_add_component(dev, component, component_driver,
+				     dai_drv, num_dai);
+}
 EXPORT_SYMBOL_GPL(snd_soc_register_component);
 
 /**
-- 
2.14.1
