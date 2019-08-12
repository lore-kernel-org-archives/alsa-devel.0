From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: rx51: use
	snd_soc_dai_link_component for aux_dev" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:53 +0100 (BST)
Message-ID: <20190812130954.064072740CBD@ypsilon.sirena.org.uk>
References: <87imr86w96.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 685EEF805F5
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:09:59 +0200 (CEST)
In-Reply-To: <87imr86w96.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Richard Fontana <rfontana@redhat.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Kevin Hilman <khilman@baylibre.com>, YueHaibing <yuehaibing@huawei.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Tzung-Bi Shih <tzungbi@google.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Danny Milosavljevic <dannym@scratchpost.org>, Georgii Staroselski i <georgii.staroselskii@emlid.com>, Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@li>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: rx51: use snd_soc_dai_link_component for aux_dev

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 77b21d2822fdbfad19170516256c4c7f236054a9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 8 Aug 2019 14:54:30 +0900
Subject: [PATCH] ASoC: ti: rx51: use snd_soc_dai_link_component for aux_dev

We can use snd_soc_dai_link_component to specify aux_dev.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/87imr86w96.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/rx51.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/rx51.c b/sound/soc/ti/rx51.c
index ccd0e8a07dd1..588f680a9c24 100644
--- a/sound/soc/ti/rx51.c
+++ b/sound/soc/ti/rx51.c
@@ -319,12 +319,10 @@ static struct snd_soc_dai_link rx51_dai[] = {
 
 static struct snd_soc_aux_dev rx51_aux_dev[] = {
 	{
-		.name = "TLV320AIC34b",
-		.codec_name = "tlv320aic3x-codec.2-0019",
+		.dlc = COMP_AUX("tlv320aic3x-codec.2-0019"),
 	},
 	{
-		.name = "TPA61320A2",
-		.codec_name = "tpa6130a2.2-0060",
+		.dlc = COMP_AUX("tpa6130a2.2-0060"),
 	},
 };
 
@@ -397,8 +395,8 @@ static int rx51_soc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Auxiliary Codec node is not provided\n");
 			return -EINVAL;
 		}
-		rx51_aux_dev[0].codec_name = NULL;
-		rx51_aux_dev[0].codec_of_node = dai_node;
+		rx51_aux_dev[0].dlc.name = NULL;
+		rx51_aux_dev[0].dlc.of_node = dai_node;
 		rx51_codec_conf[0].dev_name = NULL;
 		rx51_codec_conf[0].of_node = dai_node;
 
@@ -407,8 +405,8 @@ static int rx51_soc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "Headphone amplifier node is not provided\n");
 			return -EINVAL;
 		}
-		rx51_aux_dev[1].codec_name = NULL;
-		rx51_aux_dev[1].codec_of_node = dai_node;
+		rx51_aux_dev[1].dlc.name = NULL;
+		rx51_aux_dev[1].dlc.of_node = dai_node;
 		rx51_codec_conf[1].dev_name = NULL;
 		rx51_codec_conf[1].of_node = dai_node;
 	}
-- 
2.20.1
