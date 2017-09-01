From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add missing compile rule for max98371"
	to the asoc tree
Date: Fri, 01 Sep 2017 12:11:57 +0100
Message-ID: <E1dnjrh-0007wk-9V@debutante>
References: <87a82fniy2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A18AF2676D5
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 13:12:01 +0200 (CEST)
In-Reply-To: <87a82fniy2.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add missing compile rule for max98371

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b21f0522ee376ddbea54fab47ff36f687f2a438b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 1 Sep 2017 04:33:01 +0000
Subject: [PATCH] ASoC: add missing compile rule for max98371

It is still using old driver style, this patch also
fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Makefile   |  1 +
 sound/soc/codecs/max98371.c | 14 ++++++++------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 1755a54e3dc9..b4d576dab48a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -320,6 +320,7 @@ obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98090)	+= snd-soc-max98090.o
 obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
 obj-$(CONFIG_SND_SOC_MAX98357A)	+= snd-soc-max98357a.o
+obj-$(CONFIG_SND_SOC_MAX98371)	+= snd-soc-max98371.o
 obj-$(CONFIG_SND_SOC_MAX9867)	+= snd-soc-max9867.o
 obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX98926)	+= snd-soc-max98926.o
diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 781be9ba8dba..7bc2a17c1e94 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -349,12 +349,14 @@ static struct snd_soc_dai_driver max98371_dai[] = {
 };
 
 static const struct snd_soc_codec_driver max98371_codec = {
-	.controls = max98371_snd_controls,
-	.num_controls = ARRAY_SIZE(max98371_snd_controls),
-	.dapm_routes = max98371_audio_map,
-	.num_dapm_routes = ARRAY_SIZE(max98371_audio_map),
-	.dapm_widgets = max98371_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(max98371_dapm_widgets),
+	.component_driver = {
+		.controls = max98371_snd_controls,
+		.num_controls = ARRAY_SIZE(max98371_snd_controls),
+		.dapm_routes = max98371_audio_map,
+		.num_dapm_routes = ARRAY_SIZE(max98371_audio_map),
+		.dapm_widgets = max98371_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(max98371_dapm_widgets),
+	},
 };
 
 static const struct regmap_config max98371_regmap = {
-- 
2.14.1
