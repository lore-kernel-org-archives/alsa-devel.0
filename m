From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: tm2_wm5110: use
	snd_soc_dai_link_component for aux_dev" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:54 +0100 (BST)
Message-ID: <20190812130954.AD7932740CB7@ypsilon.sirena.org.uk>
References: <87lfw46w9g.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55666F805AA
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:09:59 +0200 (CEST)
In-Reply-To: <87lfw46w9g.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: tm2_wm5110: use snd_soc_dai_link_component for aux_dev

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

>From 124749194ad2e08fbea9c34fa5e2728310bf4486 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 8 Aug 2019 14:54:20 +0900
Subject: [PATCH] ASoC: samsung: tm2_wm5110: use snd_soc_dai_link_component for
 aux_dev

We can use snd_soc_dai_link_component to specify aux_dev.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/87lfw46w9g.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/tm2_wm5110.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index c091033d17ad..bb9910d4cbe2 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -307,7 +307,6 @@ static struct snd_soc_aux_dev tm2_speaker_amp_dev;
 static int tm2_late_probe(struct snd_soc_card *card)
 {
 	struct tm2_machine_priv *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_dai_link_component dlc = { 0 };
 	unsigned int ch_map[] = { 0, 1 };
 	struct snd_soc_dai *amp_pdm_dai;
 	struct snd_soc_pcm_runtime *rtd;
@@ -334,8 +333,7 @@ static int tm2_late_probe(struct snd_soc_card *card)
 		return ret;
 	}
 
-	dlc.of_node = tm2_speaker_amp_dev.codec_of_node;
-	amp_pdm_dai = snd_soc_find_dai(&dlc);
+	amp_pdm_dai = snd_soc_find_dai(&tm2_speaker_amp_dev.dlc);
 	if (!amp_pdm_dai)
 		return -ENODEV;
 
@@ -532,9 +530,9 @@ static int tm2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	card->aux_dev[0].codec_of_node = of_parse_phandle(dev->of_node,
+	card->aux_dev[0].dlc.of_node = of_parse_phandle(dev->of_node,
 							"audio-amplifier", 0);
-	if (!card->aux_dev[0].codec_of_node) {
+	if (!card->aux_dev[0].dlc.of_node) {
 		dev_err(dev, "audio-amplifier property invalid or missing\n");
 		return -EINVAL;
 	}
@@ -623,7 +621,7 @@ static int tm2_probe(struct platform_device *pdev)
 		of_node_put(cpu_dai_node[i]);
 	}
 
-	of_node_put(card->aux_dev[0].codec_of_node);
+	of_node_put(card->aux_dev[0].dlc.of_node);
 
 	return ret;
 }
-- 
2.20.1
