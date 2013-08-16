From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: si476x: Add DAPM support
Date: Fri, 16 Aug 2013 12:02:40 +0100
Message-ID: <1376650960-20566-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CD9CE2616AB
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 13:02:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This ensures the driver continues to work with DAPM mandatory and makes
it easier to connect the device up to other components in the subsystem.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/si476x.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 73e205c..38f3b10 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -102,6 +102,16 @@ static int si476x_codec_write(struct snd_soc_codec *codec,
 	return err;
 }
 
+static const struct snd_soc_dapm_widget si476x_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("LOUT"),
+SND_SOC_DAPM_OUTPUT("ROUT"),
+};
+
+static const struct snd_soc_dapm_route si476x_dapm_routes[] = {
+	{ "Capture", NULL, "LOUT" },
+	{ "Capture", NULL, "ROUT" },
+};
+
 static int si476x_codec_set_dai_fmt(struct snd_soc_dai *codec_dai,
 				    unsigned int fmt)
 {
@@ -260,6 +270,10 @@ static struct snd_soc_codec_driver soc_codec_dev_si476x = {
 	.probe  = si476x_codec_probe,
 	.read   = si476x_codec_read,
 	.write  = si476x_codec_write,
+	.dapm_widgets = si476x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(si476x_dapm_widgets),
+	.dapm_routes = si476x_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(si476x_dapm_routes),
 };
 
 static int si476x_platform_probe(struct platform_device *pdev)
-- 
1.8.4.rc2
