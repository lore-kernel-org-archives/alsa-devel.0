From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: [PATCH] ASoC: ADAU7002: Add optional delay before start of capture
Date: Tue, 8 Jan 2019 10:24:40 +0000
Message-ID: <1546942924-9428-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:ANALOG DEVICES INC ASOC CODEC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On capture through some of dmic we observe a glitch at the
start of record. This is because we start capturing even before
dmic is ready to send out data.
The optional delay will be applied after enabling the mic.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/codecs/adau7002.c | 45 +++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/codecs/adau7002.c b/sound/soc/codecs/adau7002.c
index fdff868..a8deb37 100644
--- a/sound/soc/codecs/adau7002.c
+++ b/sound/soc/codecs/adau7002.c
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -15,12 +16,55 @@
=20
 #include <sound/soc.h>
=20
+struct adau7002_priv {
+	int wakeup_delay;
+};
+
+static int adau7002_aif_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+			snd_soc_dapm_to_component(w->dapm);
+	struct adau7002_priv *adau7002 =3D
+			snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		if (adau7002->wakeup_delay)
+			msleep(adau7002->wakeup_delay);
+		break;
+	}
+
+	return 0;
+}
+
+static int adau7002_component_probe(struct snd_soc_component *component)
+{
+	struct adau7002_priv *adau7002;
+
+	adau7002 =3D devm_kzalloc(component->dev, sizeof(*adau7002),
+				GFP_KERNEL);
+	if (!adau7002)
+		return -ENOMEM;
+
+	device_property_read_u32(component->dev, "wakeup-delay-ms",
+				 &adau7002->wakeup_delay);
+
+	snd_soc_component_set_drvdata(component, adau7002);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget adau7002_widgets[] =3D {
+	SND_SOC_DAPM_AIF_OUT_E("ADAU AIF", "Capture", 0,
+			       SND_SOC_NOPM, 0, 0, adau7002_aif_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_INPUT("PDM_DAT"),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("IOVDD", 0, 0),
 };
=20
 static const struct snd_soc_dapm_route adau7002_routes[] =3D {
+	{ "ADAU AIF", NULL, "PDM_DAT"},
 	{ "Capture", NULL, "PDM_DAT" },
 	{ "Capture", NULL, "IOVDD" },
 };
@@ -40,6 +84,7 @@
 };
=20
 static const struct snd_soc_component_driver adau7002_component_driver =3D=
 {
+	.probe			=3D adau7002_component_probe,
 	.dapm_widgets		=3D adau7002_widgets,
 	.num_dapm_widgets	=3D ARRAY_SIZE(adau7002_widgets),
 	.dapm_routes		=3D adau7002_routes,
--=20
1.9.1
