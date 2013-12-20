From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: Add resource managed devm_snd_soc_register_codec()
Date: Fri, 20 Dec 2013 17:56:47 +0800
Message-ID: <1387533407-15623-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Adds a resource managed version of snd_soc_register_codec() which makes
it possible to simplify the remove function as well as the error path
for codec drivers.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc.h    |  3 +++
 sound/soc/soc-devres.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5a049d9..60d6c67 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -378,6 +378,9 @@ int snd_soc_register_codec(struct device *dev,
 		const struct snd_soc_codec_driver *codec_drv,
 		struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_codec(struct device *dev);
+int devm_snd_soc_register_codec(struct device *dev,
+		const struct snd_soc_codec_driver *codec_drv,
+		struct snd_soc_dai_driver *dai_drv, int num_dai);
 int snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index 7ac745d..3c8552f 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -125,3 +125,41 @@ int devm_snd_dmaengine_pcm_register(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_snd_dmaengine_pcm_register);
 
 #endif
+
+static void devm_codec_release(struct device *dev, void *res)
+{
+	snd_soc_unregister_codec(*(struct device **)res);
+}
+
+/**
+ * devm_snd_soc_register_codec - resource managed codec registration
+ * @codec_drv: codec to register
+ * @dai_drv: DAI to register
+ * @num_dai: Number of DAIs
+ *
+ * Register a codec with automatic unregistration when the device is
+ * unregistered.
+ */
+int devm_snd_soc_register_codec(struct device *dev,
+		const struct snd_soc_codec_driver *codec_drv,
+		struct snd_soc_dai_driver *dai_drv,
+		int num_dai)
+{
+	struct device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_codec_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = snd_soc_register_codec(dev, codec_drv, dai_drv, num_dai);
+	if (ret == 0) {
+		*ptr = dev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_snd_soc_register_codec);
-- 
1.8.4
