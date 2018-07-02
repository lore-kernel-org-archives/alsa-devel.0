From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es7134: Add VDD and AVDD power supplies" to the asoc tree
Date: Mon, 02 Jul 2018 11:09:15 +0100
Message-ID: <E1fZvlj-0006Ku-6g@debutante>
References: <20180629150924.18197-5-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629150924.18197-5-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es7134: Add VDD and AVDD power supplies

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

>From 424e2b4b3521334812d833eef27df77671428698 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 29 Jun 2018 17:09:23 +0200
Subject: [PATCH] ASoC: es7134: Add VDD and AVDD power supplies

Add the VDD and AVDD power supplies to the DAPM graph as some board may
need to enable a regulator to turn them on.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es7134.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 698289dc3e22..5ad59c38fed1 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -167,11 +167,15 @@ static const struct snd_soc_dapm_widget es7134_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("AOUTL"),
 	SND_SOC_DAPM_OUTPUT("AOUTR"),
 	SND_SOC_DAPM_DAC("DAC", "Playback", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("VDD", 0, 0),
+	SND_SOC_DAPM_REGULATOR_SUPPLY("AVDD", 0, 0),
 };
 
 static const struct snd_soc_dapm_route es7134_dapm_routes[] = {
 	{ "AOUTL", NULL, "DAC" },
 	{ "AOUTR", NULL, "DAC" },
+	{ "Playback", NULL, "VDD" },
+	{ "DAC", NULL, "AVDD" },
 };
 
 static const struct snd_soc_component_driver es7134_component_driver = {
-- 
2.18.0.rc2
