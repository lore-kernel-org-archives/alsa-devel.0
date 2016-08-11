From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v8 2/5] ASoC: hdmi-codec: Use HDMI notifications to add jack
 support
Date: Thu, 11 Aug 2016 11:20:24 +0200
Message-ID: <1470907227-899-3-git-send-email-p.zabel@pengutronix.de>
References: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1470907227-899-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Use HDMI connection / disconnection notifications to update an ALSA
jack object. Also make a copy of the ELD block after every change.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since v7:
 - Lock ELD mutex while copying ELD in hdmi_eld_ctl_get
---
 include/sound/hdmi-codec.h    |  6 +++
 sound/soc/codecs/Kconfig      |  1 +
 sound/soc/codecs/hdmi-codec.c | 88 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 530c57b..0fd2e38 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -98,6 +98,12 @@ struct hdmi_codec_pdata {
 	void *data;
 };
 
+struct snd_soc_codec;
+struct snd_soc_jack;
+
+int hdmi_codec_set_jack_detect(struct snd_soc_codec *codec,
+			       struct snd_soc_jack *jack);
+
 #define HDMI_CODEC_DRV_NAME "hdmi-audio-codec"
 
 #endif /* __HDMI_CODEC_H__ */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 1cd6ab3..f8c5e3e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -508,6 +508,7 @@ config SND_SOC_HDMI_CODEC
 	select SND_PCM_ELD
 	select SND_PCM_IEC958
 	select HDMI
+	select HDMI_NOTIFIERS
 
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f27d115..973892b 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -12,9 +12,12 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
  * General Public License for more details.
  */
+#include <linux/hdmi-notifier.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/string.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -27,11 +30,16 @@
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
 	struct snd_soc_dai_driver *daidrv;
+	struct snd_soc_jack *jack;
 	struct hdmi_codec_daifmt daifmt[2];
 	struct mutex current_stream_lock;
 	struct snd_pcm_substream *current_stream;
 	struct snd_pcm_hw_constraint_list ratec;
+	struct mutex eld_lock;
 	uint8_t eld[MAX_ELD_BYTES];
+	struct device *dev;
+	struct notifier_block nb;
+	unsigned int jack_status;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -65,7 +73,9 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
 
+	mutex_lock(&hcp->eld_lock);
 	memcpy(ucontrol->value.bytes.data, hcp->eld, sizeof(hcp->eld));
+	mutex_unlock(&hcp->eld_lock);
 
 	return 0;
 }
@@ -103,7 +113,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	int ret = 0;
+	int ret;
 
 	dev_dbg(dai->dev, "%s()\n", __func__);
 
@@ -122,17 +132,15 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	}
 
 	if (hcp->hcd.ops->get_eld) {
+		mutex_lock(&hcp->eld_lock);
 		ret = hcp->hcd.ops->get_eld(dai->dev->parent, hcp->hcd.data,
 					    hcp->eld, sizeof(hcp->eld));
-
-		if (!ret) {
+		if (!ret)
 			ret = snd_pcm_hw_constraint_eld(substream->runtime,
 							hcp->eld);
-			if (ret)
-				return ret;
-		}
+		mutex_unlock(&hcp->eld_lock);
 	}
-	return 0;
+	return ret;
 }
 
 static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
@@ -355,6 +363,63 @@ static struct snd_soc_codec_driver hdmi_codec = {
 	.num_dapm_routes = ARRAY_SIZE(hdmi_routes),
 };
 
+static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
+				   unsigned int jack_status)
+{
+	if (!hcp->jack)
+		return;
+
+	if (jack_status != hcp->jack_status) {
+		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
+		hcp->jack_status = jack_status;
+	}
+}
+
+static int hdmi_codec_notify(struct notifier_block *nb, unsigned long event,
+			     void *data)
+{
+	struct hdmi_codec_priv *hcp = container_of(nb, struct hdmi_codec_priv,
+						   nb);
+	union hdmi_event *event_block = data;
+
+	if (hcp->dev->parent != event_block->base.source)
+		return NOTIFY_OK;
+
+	if (!hcp->jack)
+		return NOTIFY_OK;
+
+	switch (event) {
+	case HDMI_CONNECTED:
+		hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
+		break;
+	case HDMI_DISCONNECTED:
+		hdmi_codec_jack_report(hcp, 0);
+		break;
+	case HDMI_NEW_ELD:
+		hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
+		mutex_lock(&hcp->eld_lock);
+		memcpy(hcp->eld, event_block->eld.eld, sizeof(hcp->eld));
+		mutex_unlock(&hcp->eld_lock);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+int hdmi_codec_set_jack_detect(struct snd_soc_codec *codec,
+			       struct snd_soc_jack *jack)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_codec_get_drvdata(codec);
+
+	hcp->jack = jack;
+	hcp->nb.notifier_call = hdmi_codec_notify;
+
+	hdmi_register_notifier(&hcp->nb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
+
 static int hdmi_codec_probe(struct platform_device *pdev)
 {
 	struct hdmi_codec_pdata *hcd = pdev->dev.platform_data;
@@ -383,6 +448,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 	hcp->hcd = *hcd;
 	mutex_init(&hcp->current_stream_lock);
+	mutex_init(&hcp->eld_lock);
 
 	hcp->daidrv = devm_kzalloc(dev, dai_count * sizeof(*hcp->daidrv),
 				   GFP_KERNEL);
@@ -399,6 +465,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 	if (hcd->spdif)
 		hcp->daidrv[i] = hdmi_spdif_dai;
 
+	dev_set_drvdata(dev, hcp);
+
 	ret = snd_soc_register_codec(dev, &hdmi_codec, hcp->daidrv,
 				     dai_count);
 	if (ret) {
@@ -407,12 +475,16 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dev_set_drvdata(dev, hcp);
+	hcp->dev = dev;
+
 	return 0;
 }
 
 static int hdmi_codec_remove(struct platform_device *pdev)
 {
+	struct hdmi_codec_priv *hcp = platform_get_drvdata(pdev);
+
+	hdmi_unregister_notifier(&hcp->nb);
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
-- 
2.8.1
