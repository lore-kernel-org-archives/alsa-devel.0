From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [RFC v3 7/7] ASoC: hdmi-codec: Add ELD control
Date: Tue, 12 Jan 2016 16:38:16 +0100
Message-ID: <1452613096-8116-8-git-send-email-p.zabel@pengutronix.de>
References: <1452613096-8116-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1452613096-8116-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Exporting the ELD bytes to userspace allows an application to select
an appropriate audio format depending on the current capabilities of
the connected HDMI sink device.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 sound/soc/codecs/hdmi-codec.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 6b327e2..6cb7217 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -54,6 +54,40 @@ enum {
 	DAI_ID_SPDIF,
 };
 
+static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = sizeof(hcp->eld);
+
+	return 0;
+}
+
+static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+
+	memcpy(ucontrol->value.bytes.data, hcp->eld, sizeof(hcp->eld));
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new hdmi_controls[] = {
+	{
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "ELD",
+		.info = hdmi_eld_ctl_info,
+		.get = hdmi_eld_ctl_get,
+	},
+};
+
 static void hdmi_codec_abort(struct device *dev)
 {
 	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
@@ -327,6 +361,8 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 };
 
 static struct snd_soc_codec_driver hdmi_codec = {
+	.controls = hdmi_controls,
+	.num_controls = ARRAY_SIZE(hdmi_controls),
 	.dapm_widgets = hdmi_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
 	.dapm_routes = hdmi_routes,
-- 
2.6.4
