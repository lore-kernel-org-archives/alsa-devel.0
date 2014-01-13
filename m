From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 1/6] ASoC: core: add off-CODEC widgets list
	register/unregister
Date: Mon, 13 Jan 2014 13:53:53 +0800
Message-ID: <1389592438-13761-2-git-send-email-Li.Xiubo@freescale.com>
References: <1389592438-13761-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 911BE2617AB
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 07:51:04 +0100 (CET)
In-Reply-To: <1389592438-13761-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

This will be need for some audio card, which maybe using the simple
card and the off-CODEC widgets is needed.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc.h  | 10 ++++++++++
 sound/soc/soc-core.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 03ce45b..23f9572 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -326,6 +326,7 @@ struct snd_soc_platform_driver;
 struct snd_soc_codec;
 struct snd_soc_codec_driver;
 struct snd_soc_component;
+struct snd_soc_widgets;
 struct snd_soc_component_driver;
 struct soc_enum;
 struct snd_soc_jack;
@@ -385,6 +386,8 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *cmpnt_drv,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
+int snd_soc_register_widgets(struct snd_soc_widgets *wdg);
+void snd_soc_unregister_widgets(struct snd_soc_widgets *wdg);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec,
 				    unsigned int reg);
 int snd_soc_codec_readable_register(struct snd_soc_codec *codec,
@@ -664,6 +667,13 @@ struct snd_soc_component {
 	const struct snd_soc_component_driver *driver;
 };
 
+struct snd_soc_widgets {
+	const char *name;
+	struct list_head list;
+	const struct snd_soc_dapm_widget *widgets;
+	unsigned int cnt;
+};
+
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a128f0..9adcada 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3821,6 +3821,45 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
 
+static DEFINE_MUTEX(widgets_mutex);
+static LIST_HEAD(widgets_list);
+/**
+ * snd_soc_register_widgets - Register off codec widgets with
+ * the ASoC core
+ *
+ * @wdg: widgets to register
+ *
+ */
+int snd_soc_register_widgets(struct snd_soc_widgets *wdg)
+{
+	int ret;
+
+	if (!wdg)
+		return -EINVAL;
+
+	mutex_lock(&widgets_mutex);
+	list_add(&wdg->list, &widgets_list);
+	mutex_unlock(&widgets_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_widgets);
+
+/**
+ * snd_soc_unregister_widgets - Unregister off codec widgets with
+ * the ASoC core
+ *
+ * @wdg: widgets to unregister
+ *
+ */
+void snd_soc_unregister_widgets(struct snd_soc_widgets *wdg)
+{
+	mutex_lock(&widgets_mutex);
+	list_del(&wdg->list);
+	mutex_unlock(&widgets_mutex);
+}
+EXPORT_SYMBOL_GPL(snd_soc_unregister_widgets);
+
 /*
  * Simplify DAI link configuration by removing ".-1" from device names
  * and sanitizing names.
-- 
1.8.4
