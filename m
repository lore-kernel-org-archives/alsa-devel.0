From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v9 1/3] ASoC: hdmi-codec: use HDMI state notifier to add jack
 support
Date: Tue, 15 Nov 2016 19:52:38 +0100
Message-ID: <1479235960-23696-2-git-send-email-p.zabel@pengutronix.de>
References: <1479235960-23696-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1479235960-23696-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Changes since v8:
 - Rebased onto the "video: add HDMI state notifier support" patch.
   Now hdmi_codec_set_jack_detect needs to be passed the HDMI notifier
   device so the correct notifier can be used.
---
 include/sound/hdmi-codec.h    |   7 +++
 sound/soc/codecs/Kconfig      |   1 +
 sound/soc/codecs/hdmi-codec.c | 107 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 530c57b..6fe5de2 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -98,6 +98,13 @@ struct hdmi_codec_pdata {
 	void *data;
 };
 
+struct snd_soc_codec;
+struct snd_soc_jack;
+
+int hdmi_codec_set_jack_detect(struct snd_soc_codec *codec,
+			       struct snd_soc_jack *jack,
+			       struct device *dev);
+
 #define HDMI_CODEC_DRV_NAME "hdmi-audio-codec"
 
 #endif /* __HDMI_CODEC_H__ */
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index c67667b..7ad5d78 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -511,6 +511,7 @@ config SND_SOC_HDMI_CODEC
 	select SND_PCM_ELD
 	select SND_PCM_IEC958
 	select HDMI
+	select HDMI_NOTIFIERS
 
 config SND_SOC_ES8328
 	tristate "Everest Semi ES8328 CODEC"
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b904492..c0a0ba9 100644
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
@@ -36,11 +39,17 @@ LIST_HEAD(hdmi_device_list);
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
+	struct hdmi_notifier *notifier;
+	struct notifier_block nb;
+	unsigned int jack_status;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -74,7 +83,9 @@ static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
 
+	mutex_lock(&hcp->eld_lock);
 	memcpy(ucontrol->value.bytes.data, hcp->eld, sizeof(hcp->eld));
+	mutex_unlock(&hcp->eld_lock);
 
 	return 0;
 }
@@ -112,7 +123,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	int ret = 0;
+	int ret;
 
 	dev_dbg(dai->dev, "%s()\n", __func__);
 
@@ -131,17 +142,15 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
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
@@ -386,6 +395,78 @@ static struct snd_soc_codec_driver hdmi_codec = {
 	},
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
+	struct hdmi_notifier *n = data;
+
+	if (!hcp->jack)
+		return NOTIFY_OK;
+
+	switch (event) {
+	case HDMI_NEW_ELD:
+		mutex_lock(&hcp->eld_lock);
+		memcpy(hcp->eld, n->eld, sizeof(hcp->eld));
+		mutex_unlock(&hcp->eld_lock);
+		/* fall through */
+	case HDMI_CONNECTED:
+		hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
+		break;
+	case HDMI_DISCONNECTED:
+		hdmi_codec_jack_report(hcp, 0);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+/**
+ * hdmi_codec_set_jack_detect - register HDMI state notifier callback
+ * @codec: the hdmi-codec instance
+ * @jack: ASoC jack to report (dis)connection events on
+ * @dev: hdmi_notifier device, usually HDMI_TX or CEC device
+ */
+int hdmi_codec_set_jack_detect(struct snd_soc_codec *codec,
+			       struct snd_soc_jack *jack,
+			       struct device *dev)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	hcp->notifier = hdmi_notifier_get(dev);
+	if (!hcp->notifier)
+		return -ENOMEM;
+
+	hcp->nb.notifier_call = hdmi_codec_notify;
+	ret = hdmi_notifier_register(hcp->notifier, &hcp->nb);
+	if (ret)
+		goto err_notifier_put;
+
+	hcp->jack = jack;
+
+	return 0;
+
+err_notifier_put:
+	hdmi_notifier_put(hcp->notifier);
+	hcp->notifier = NULL;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
+
 static int hdmi_codec_probe(struct platform_device *pdev)
 {
 	struct hdmi_codec_pdata *hcd = pdev->dev.platform_data;
@@ -441,6 +522,7 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 
 	hcp->hcd = *hcd;
 	mutex_init(&hcp->current_stream_lock);
+	mutex_init(&hcp->eld_lock);
 
 	hcp->daidrv = devm_kzalloc(dev, dai_count * sizeof(*hcp->daidrv),
 				   GFP_KERNEL);
@@ -460,6 +542,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		hcp->daidrv[i].name = hdmi_dai_name[hd->cnt++];
 	}
 
+	dev_set_drvdata(dev, hcp);
+
 	ret = snd_soc_register_codec(dev, &hdmi_codec, hcp->daidrv,
 				     dai_count);
 	if (ret) {
@@ -468,12 +552,19 @@ static int hdmi_codec_probe(struct platform_device *pdev)
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
+	if (hcp->notifier) {
+		hdmi_notifier_unregister(hcp->notifier, &hcp->nb);
+		hdmi_notifier_put(hcp->notifier);
+	}
 	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
-- 
2.10.2
