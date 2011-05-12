From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: DMIC codec - Add input widget
Date: Thu, 12 May 2011 16:26:20 +0100
Message-ID: <1305213980-4700-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id F2073243DC
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 17:26:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

Digital microphones can have some additional elements in their
audio path (like microphone bias). An input widget is required
for digital microphone CODEC driver to allow external connections
in machine drivers.

Change-Id: Ice9fcb2dbe9acccd859f90ae875d2280926bf08a
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/dmic.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 57e9dac..f9a8773 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -39,7 +39,31 @@ static struct snd_soc_dai_driver dmic_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_dmic = {};
+static const struct snd_soc_dapm_widget dmic_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_OUT("DMIC AIF", "Capture", 0,
+			     SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_INPUT("DMic"),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+	{"DMIC AIF", NULL, "DMic"},
+};
+
+static int dmic_probe(struct snd_soc_codec *codec)
+{
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_new_controls(dapm, dmic_dapm_widgets,
+				  ARRAY_SIZE(dmic_dapm_widgets));
+        snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
+	snd_soc_dapm_new_widgets(dapm);
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver soc_dmic = {
+	.probe	= dmic_probe,
+};
 
 static int __devinit dmic_dev_probe(struct platform_device *pdev)
 {
-- 
1.7.4.1
