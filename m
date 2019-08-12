From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: axg-card: use
	snd_soc_dai_link_component for aux_dev" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:55 +0100 (BST)
Message-ID: <20190812130956.058832740CBD@ypsilon.sirena.org.uk>
References: <87r25w6wa1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F18D4F805FA
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:10:03 +0200 (CEST)
In-Reply-To: <87r25w6wa1.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: meson: axg-card: use snd_soc_dai_link_component for aux_dev

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

>From a73b522d4b570ee41754990e81f6f4e849af1af9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 8 Aug 2019 14:53:59 +0900
Subject: [PATCH] ASoC: meson: axg-card: use snd_soc_dai_link_component for
 aux_dev

We can use snd_soc_dai_link_component to specify aux_dev.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87r25w6wa1.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 14a8321744da..6283e5025548 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -124,7 +124,7 @@ static void axg_card_clean_references(struct axg_card *priv)
 
 	if (card->aux_dev) {
 		for (i = 0; i < card->num_aux_devs; i++)
-			of_node_put(card->aux_dev[i].codec_of_node);
+			of_node_put(card->aux_dev[i].dlc.of_node);
 	}
 
 	kfree(card->dai_link);
@@ -158,9 +158,9 @@ static int axg_card_add_aux_devices(struct snd_soc_card *card)
 	card->num_aux_devs = num;
 
 	for (i = 0; i < card->num_aux_devs; i++, aux++) {
-		aux->codec_of_node =
+		aux->dlc.of_node =
 			of_parse_phandle(node, "audio-aux-devs", i);
-		if (!aux->codec_of_node)
+		if (!aux->dlc.of_node)
 			return -EINVAL;
 	}
 
-- 
2.20.1
