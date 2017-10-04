From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: add component lookup
	functions" to the asoc tree
Date: Wed, 04 Oct 2017 12:27:46 +0100
Message-ID: <E1dzhq6-0004CG-2S@debutante>
References: <87shhappnj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 316C3266B20
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 13:27:51 +0200 (CEST)
In-Reply-To: <87shhappnj.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: add component lookup functions

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

>From 7dd5d0d954611c05a38bdf843054c639f45ce08b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Oct 2017 05:09:52 +0000
Subject: [PATCH] ASoC: soc-core: add component lookup functions

ALSA SoC platform/codec will be replaced to component soon.
This means 1 device might have multiple components. But current
unregister component function only checks "dev" to find it.
This means, unexpected component might be unregistered by current
function.
But, it is no problem if driver registered only 1 component.

To prepare avoid this issue, this patch adds new component
lookup function. it finds component by "dev" and "driver name".

Here, the reason why it uses "driver name" is that "component name"
was created by fmt_single_name() and difficult to use it from driver.
Driver of course knows its "driver name", thus, using it is more easy.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d776cdee30d7..11ca867033bd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -475,6 +475,8 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
+struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
+						   const char *driver_name);
 int snd_soc_cache_init(struct snd_soc_codec *codec);
 int snd_soc_cache_exit(struct snd_soc_codec *codec);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fb3435121172..6ec127346e9c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3481,6 +3481,32 @@ void snd_soc_unregister_component(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
+struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
+						   const char *driver_name)
+{
+	struct snd_soc_component *component;
+	struct snd_soc_component *ret;
+
+	ret = NULL;
+	mutex_lock(&client_mutex);
+	list_for_each_entry(component, &component_list, list) {
+		if (dev != component->dev)
+			continue;
+
+		if (driver_name &&
+		    (driver_name != component->driver->name) &&
+		    (strcmp(component->driver->name, driver_name) != 0))
+			continue;
+
+		ret = component;
+		break;
+	}
+	mutex_unlock(&client_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_lookup_component);
+
 static int snd_soc_platform_drv_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_platform *platform = snd_soc_component_to_platform(component);
-- 
2.14.1
