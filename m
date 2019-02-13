From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Add widgets and routes
	for DPCM support" to the asoc tree
Date: Wed, 13 Feb 2019 11:53:42 +0000 (GMT)
Message-ID: <20190213115342.582CD1128158@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A9FBE267960
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2019 12:53:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Add widgets and routes for DPCM support

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

>From 64aba9bca5bd8d0957b0410bdfa192afb1fcb267 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 12 Feb 2019 19:03:24 +0100
Subject: [PATCH] ASoC: samsung: i2s: Add widgets and routes for DPCM support

This patch adds DAPM widgets required to model the internal mixer
of the I2S controller merging audio streams from the primary and
from the secondary PCM interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fffc76ab60da..29bcfca20572 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1116,8 +1116,31 @@ static const struct snd_soc_dai_ops samsung_i2s_dai_ops = {
 	.delay = i2s_delay,
 };
 
+static const struct snd_soc_dapm_widget samsung_i2s_widgets[] = {
+	/* Backend DAI  */
+	SND_SOC_DAPM_AIF_OUT("Mixer DAI TX", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("Mixer DAI RX", NULL, 0, SND_SOC_NOPM, 0, 0),
+
+	/* Playback Mixer */
+	SND_SOC_DAPM_MIXER("Playback Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
+};
+
+static const struct snd_soc_dapm_route samsung_i2s_dapm_routes[] = {
+	{ "Playback Mixer", NULL, "Primary" },
+	{ "Playback Mixer", NULL, "Secondary" },
+
+	{ "Mixer DAI TX", NULL, "Playback Mixer" },
+	{ "Playback Mixer", NULL, "Mixer DAI RX" },
+};
+
 static const struct snd_soc_component_driver samsung_i2s_component = {
-	.name		= "samsung-i2s",
+	.name = "samsung-i2s",
+
+	.dapm_widgets = samsung_i2s_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(samsung_i2s_widgets),
+
+	.dapm_routes = samsung_i2s_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(samsung_i2s_dapm_routes),
 };
 
 #define SAMSUNG_I2S_FMTS	(SNDRV_PCM_FMTBIT_S8 | \
@@ -1129,6 +1152,7 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 			  int num_dais)
 {
 	static const char *dai_names[] = { "samsung-i2s", "samsung-i2s-sec" };
+	static const char *stream_names[] = { "Primary", "Secondary" };
 	struct snd_soc_dai_driver *dai_drv;
 	struct i2s_dai *dai;
 	int i;
@@ -1158,6 +1182,7 @@ static int i2s_alloc_dais(struct samsung_i2s_priv *priv,
 		dai_drv->playback.channels_max = 2;
 		dai_drv->playback.rates = i2s_dai_data->pcm_rates;
 		dai_drv->playback.formats = SAMSUNG_I2S_FMTS;
+		dai_drv->playback.stream_name = stream_names[i];
 
 		dai_drv->id = i + 1;
 		dai_drv->name = dai_names[i];
-- 
2.20.1
