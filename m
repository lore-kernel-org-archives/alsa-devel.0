From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 01/20] ASoC: Add resource managed
	snd_soc_register_platform()
Date: Wed, 16 Apr 2014 15:46:11 +0300
Message-ID: <1397652390-852-2-git-send-email-peter.ujfalusi@ti.com>
References: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2442D2652AC
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 14:46:39 +0200 (CEST)
In-Reply-To: <1397652390-852-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Simplify error handling and remove repetitive (and rarely executed) code
for unregistration by providing a devm_snd_soc_register_platform()
platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h    |  2 ++
 sound/soc/soc-devres.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 33965946656c..9e214ec70c8a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -375,6 +375,8 @@ int snd_soc_resume(struct device *dev);
 int snd_soc_poweroff(struct device *dev);
 int snd_soc_register_platform(struct device *dev,
 		const struct snd_soc_platform_driver *platform_drv);
+int devm_snd_soc_register_platform(struct device *dev,
+		const struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
 int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		const struct snd_soc_platform_driver *platform_drv);
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index 7ac745df1412..e94aa0277250 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -52,6 +52,40 @@ int devm_snd_soc_register_component(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_snd_soc_register_component);
 
+static void devm_platform_release(struct device *dev, void *res)
+{
+	snd_soc_unregister_platform(*(struct device **)res);
+}
+
+/**
+ * devm_snd_soc_register_platform - resource managed platform registration
+ * @dev: Device used to manage platform
+ * @platform: platform to register
+ *
+ * Register a platform driver with automatic unregistration when the device is
+ * unregistered.
+ */
+int devm_snd_soc_register_platform(struct device *dev,
+			const struct snd_soc_platform_driver *platform_drv)
+{
+	struct device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_platform_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = snd_soc_register_platform(dev, platform_drv);
+	if (ret == 0) {
+		*ptr = dev;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+
 static void devm_card_release(struct device *dev, void *res)
 {
 	snd_soc_unregister_card(*(struct snd_soc_card **)res);
-- 
1.9.2
