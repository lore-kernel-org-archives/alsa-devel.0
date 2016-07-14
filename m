From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: mediatek: Add HDMI dai-links to the mt8173-rt5650
 machine driver" to the asoc tree
Date: Thu, 14 Jul 2016 17:32:04 +0100
Message-ID: <E1bNjYS-0001R1-Fa@debutante>
References: <1467710781-23590-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467710781-23590-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Add HDMI dai-links to the mt8173-rt5650 machine driver

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

>From 97e1145a416e8bf0c00e7496e3522765437471ad Mon Sep 17 00:00:00 2001
From: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Tue, 5 Jul 2016 11:26:21 +0200
Subject: [PATCH] ASoC: mediatek: Add HDMI dai-links to the mt8173-rt5650
 machine driver

This patch adds HDMI audio output support to the MT8173 RT5650 machine
driver.

Signed-off-by: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |  5 +++--
 sound/soc/mediatek/Kconfig                         |  1 +
 sound/soc/mediatek/mt8173/mt8173-rt5650.c          | 26 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
index f250fc7c7acc..29dce2ac8773 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -1,8 +1,9 @@
-MT8173 with RT5650 CODECS
+MT8173 with RT5650 CODECS and HDMI via I2S
 
 Required properties:
 - compatible : "mediatek,mt8173-rt5650"
 - mediatek,audio-codec: the phandles of rt5650 codecs
+                        and of the hdmi encoder node
 - mediatek,platform: the phandle of MT8173 ASoC platform
 
 Optional subnodes:
@@ -20,7 +21,7 @@ Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650";
-		mediatek,audio-codec = <&rt5650>;
+		mediatek,audio-codec = <&rt5650 &hdmi0>;
 		mediatek,platform = <&afe>;
 		mediatek,mclk = <0>;
 		codec-capture {
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 2fbe5434f03b..05cf809cf9e1 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -46,6 +46,7 @@ config SND_SOC_MT8173_RT5650
 	tristate "ASoC Audio driver for MT8173 with RT5650 codec"
 	depends on SND_SOC_MT8173 && I2C
 	select SND_SOC_RT5645
+	select SND_SOC_HDMI_CODEC
 	help
 	  This adds ASoC driver for Mediatek MT8173 boards
 	  with the RT5650 audio codec.
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index d47897618cb5..ba65f4157a7e 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -169,7 +169,9 @@ static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
+	DAI_LINK_HDMI,
 	DAI_LINK_CODEC_I2S,
+	DAI_LINK_HDMI_I2S,
 };
 
 /* Digital audio interface glue - connects codec <---> CPU */
@@ -195,6 +197,16 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.dynamic = 1,
 		.dpcm_capture = 1,
 	},
+	[DAI_LINK_HDMI] = {
+		.name = "HDMI",
+		.stream_name = "HDMI PCM",
+		.cpu_dai_name = "HDMI",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
 	/* Back End DAI links */
 	[DAI_LINK_CODEC_I2S] = {
 		.name = "Codec",
@@ -210,6 +222,13 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 	},
+	[DAI_LINK_HDMI_I2S] = {
+		.name = "HDMI BE",
+		.cpu_dai_name = "HDMIO",
+		.no_pcm = 1,
+		.codec_dai_name = "i2s-hifi",
+		.dpcm_playback = 1,
+	},
 };
 
 static struct snd_soc_card mt8173_rt5650_card = {
@@ -284,6 +303,13 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 1);
+	if (!mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
2.8.1
