From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: Add resource managed
	snd_dmaengine_pcm_register()
Date: Sun, 24 Nov 2013 14:20:57 +0100
Message-ID: <1385299262-24304-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-164.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E88F261676
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:20:38 +0100 (CET)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

For many drivers using the generic dmaengine PCM driver one of the few (or the
only) things left to do in the drivers remove function is to unregister the PCM
device. This patch adds a resource managed version of snd_dmaengine_pcm_register()
which makes it possible to simplify the remove function as well as the error
path in the probe function for those drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h         |  4 ++++
 sound/soc/soc-generic-dmaengine-pcm.c | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 1501731..4ef986c 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -140,6 +140,10 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	unsigned int flags);
 void snd_dmaengine_pcm_unregister(struct device *dev);
 
+int devm_snd_dmaengine_pcm_register(struct device *dev,
+	const struct snd_dmaengine_pcm_config *config,
+	unsigned int flags);
+
 int snd_dmaengine_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct dma_slave_config *slave_config);
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index cbc9c96..20690c0 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -366,4 +366,40 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
 
+static void devm_dmaengine_pcm_release(struct device *dev, void *res)
+{
+	snd_dmaengine_pcm_unregister(*(struct device **)res);
+}
+
+/**
+ * devm_snd_dmaengine_pcm_register - resource managed dmaengine PCM registration
+ * @dev: The parent device for the PCM device
+ * @config: Platform specific PCM configuration
+ * @flags: Platform specific quirks
+ *
+ * Register a dmaengine based PCM device with automatic unregistration when the
+ * device is unregistered.
+ */
+int devm_snd_dmaengine_pcm_register(struct device *dev,
+	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
+{
+	struct device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_dmaengine_pcm_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = snd_dmaengine_pcm_register(dev, config, flags);
+	if (ret == 0) {
+		*ptr = dev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_snd_dmaengine_pcm_register);
+
 MODULE_LICENSE("GPL");
-- 
1.8.0
