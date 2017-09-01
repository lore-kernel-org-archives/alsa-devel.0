From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add missing compile rule for
	sirf-audio-codec" to the asoc tree
Date: Fri, 01 Sep 2017 11:46:59 +0100
Message-ID: <E1dnjTX-0005xu-Fx@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C15E266DBC
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 12:47:02 +0200 (CEST)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add missing compile rule for sirf-audio-codec

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

>From 2dc3b7b06bace6d8986a5fae6569ef30276cdd73 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 1 Sep 2017 04:33:27 +0000
Subject: [PATCH] ASoC: add missing compile rule for sirf-audio-codec

It is still using old driver style, this patch also
fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Makefile           |  1 +
 sound/soc/codecs/sirf-audio-codec.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index b4d576dab48a..8ed3c9256a74 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -373,6 +373,7 @@ obj-$(CONFIG_SND_SOC_SIGMADSP_REGMAP)	+= snd-soc-sigmadsp-regmap.o
 obj-$(CONFIG_SND_SOC_SI476X)	+= snd-soc-si476x.o
 obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
+obj-$(CONFIG_SND_SOC_SIRF_AUDIO_CODEC) += sirf-audio-codec.o
 obj-$(CONFIG_SND_SOC_SSM2518)	+= snd-soc-ssm2518.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_SSM2602_SPI)	+= snd-soc-ssm2602-spi.o
diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 6bfd25c289d1..01d7690a1520 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -432,10 +432,12 @@ static int sirf_audio_codec_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_device_sirf_audio_codec = {
 	.probe = sirf_audio_codec_probe,
 	.remove = sirf_audio_codec_remove,
-	.dapm_widgets = sirf_audio_codec_dapm_widgets,
-	.num_dapm_widgets = ARRAY_SIZE(sirf_audio_codec_dapm_widgets),
-	.dapm_routes = sirf_audio_codec_map,
-	.num_dapm_routes = ARRAY_SIZE(sirf_audio_codec_map),
+	.component_driver = {
+		.dapm_widgets = sirf_audio_codec_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(sirf_audio_codec_dapm_widgets),
+		.dapm_routes = sirf_audio_codec_map,
+		.num_dapm_routes = ARRAY_SIZE(sirf_audio_codec_map),
+	},
 	.idle_bias_off = true,
 };
 
-- 
2.14.1
