From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ADAU7002: Add optional delay before
	start of capture" to the asoc tree
Date: Tue,  8 Jan 2019 16:17:10 +0000 (GMT)
Message-ID: <20190108161710.49B0C112778C@debutante.sirena.org.uk>
References: <1546942924-9428-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B5919266B98
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2019 17:17:12 +0100 (CET)
In-Reply-To: <1546942924-9428-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Agrawal@sirena.org.uk
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Deucher, ,
 Alexander" <Alexander.Deucher@amd.com>, "Agrawal, ,
 Akshu" <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ADAU7002: Add optional delay before start of capture

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7b57085a33ce55e28616f04fd9877ba2ca7e79de Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Tue, 8 Jan 2019 10:24:40 +0000
Subject: [PATCH] ASoC: ADAU7002: Add optional delay before start of capture

On capture through some of dmic we observe a glitch at the
start of record. This is because we start capturing even before
dmic is ready to send out data.
The optional delay will be applied after enabling the mic.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau7002.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/codecs/adau7002.c b/sound/soc/codecs/adau7002.c
index fdff86878287..a8deb37fc78a 100644
--- a/sound/soc/codecs/adau7002.c
+++ b/sound/soc/codecs/adau7002.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -15,12 +16,55 @@
 
 #include <sound/soc.h>
 
+struct adau7002_priv {
+	int wakeup_delay;
+};
+
+static int adau7002_aif_event(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+			snd_soc_dapm_to_component(w->dapm);
+	struct adau7002_priv *adau7002 =
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
+	adau7002 = devm_kzalloc(component->dev, sizeof(*adau7002),
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
 static const struct snd_soc_dapm_widget adau7002_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT_E("ADAU AIF", "Capture", 0,
+			       SND_SOC_NOPM, 0, 0, adau7002_aif_event,
+			       SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_INPUT("PDM_DAT"),
 	SND_SOC_DAPM_REGULATOR_SUPPLY("IOVDD", 0, 0),
 };
 
 static const struct snd_soc_dapm_route adau7002_routes[] = {
+	{ "ADAU AIF", NULL, "PDM_DAT"},
 	{ "Capture", NULL, "PDM_DAT" },
 	{ "Capture", NULL, "IOVDD" },
 };
@@ -40,6 +84,7 @@ static struct snd_soc_dai_driver adau7002_dai = {
 };
 
 static const struct snd_soc_component_driver adau7002_component_driver = {
+	.probe			= adau7002_component_probe,
 	.dapm_widgets		= adau7002_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(adau7002_widgets),
 	.dapm_routes		= adau7002_routes,
-- 
2.20.1
