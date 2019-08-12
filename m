From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove legacy style of
	aux_dev" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:53 +0100 (BST)
Message-ID: <20190812130953.9A8F42740CB7@ypsilon.sirena.org.uk>
References: <87h86s6w8x.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D3D6F8060D
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:10:03 +0200 (CEST)
In-Reply-To: <87h86s6w8x.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: remove legacy style of aux_dev

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

>From a48b561d873d1d9fda55782d275eff94ec647863 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 8 Aug 2019 14:54:39 +0900
Subject: [PATCH] ASoC: soc-core: remove legacy style of aux_dev

Now all drivers are using snd_soc_dai_link_component for aux_dev.
Let's remove legacy style

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87h86s6w8x.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 9 ---------
 sound/soc/soc-core.c | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index fd6ecea48fc0..2fc56e5963f3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -963,19 +963,10 @@ struct snd_soc_codec_conf {
 };
 
 struct snd_soc_aux_dev {
-	const char *name;		/* Codec name */
-
 	/*
 	 * specify multi-codec either by device name, or by
 	 * DT/OF node, but not both.
 	 */
-	const char *codec_name;
-	struct device_node *codec_of_node;
-
-	/*
-	 * name, codec_name, codec_of_node will be replaced
-	 * into dlc. don't use both in the same time
-	 */
 	struct snd_soc_dai_link_component dlc;
 
 	/* codec/machine specific init - e.g. add machine controls */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 56b99e340dda..4af382d52675 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1538,12 +1538,6 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_component *component;
 
-	/* remove me */
-	if (aux_dev->codec_name)
-		aux_dev->dlc.name = aux_dev->codec_name;
-	if (aux_dev->codec_of_node)
-		aux_dev->dlc.of_node = aux_dev->codec_of_node;
-
 	/* codecs, usually analog devices */
 	component = soc_find_component(&aux_dev->dlc);
 	if (!component)
-- 
2.20.1
