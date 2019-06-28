From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: snow: consider CPU-Platform
	possibility" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:25 +0100 (BST)
Message-ID: <20190628165625.56FFE440049@finisterre.sirena.org.uk>
References: <87blyiv5wr.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A674F8973A
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 18:56:26 +0200 (CEST)
In-Reply-To: <87blyiv5wr.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: snow: consider CPU-Platform possibility

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 3dfc3e9c24b742067bbcbf849caba294bdb938f6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 10:48:23 +0900
Subject: [PATCH] ASoC: samsung: snow: consider CPU-Platform possibility

commit a555b6a959e6 ("ASoC: samsung: snow: don't select unnecessary
Platform")

Current ALSA SoC avoid to add duplicate component to rtd,
and this driver was selecting CPU component as Platform component.
Thus, above patch removed Platform settings from this driver,
because it assumed these are same component.

But, some CPU driver is using generic DMAEngine, in such case, both
CPU component and Platform component will have same of_node/name.
In other words, there are some components which are different but
have same of_node/name.

In such case, Card driver definitely need to select Platform even
though it is same as CPU.
It is depends on CPU driver, but is difficult to know it from Card driver.
This patch reverts above patch.

Fixes: commit a555b6a959e6 ("ASoC: samsung: snow: don't select unnecessary Platform")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/snow.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 7d669c42cdad..8ea7799df028 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -14,9 +14,9 @@
 
 #define FIN_PLL_RATE		24000000
 
-SND_SOC_DAILINK_DEF(links_cpus,
-	DAILINK_COMP_ARRAY(COMP_EMPTY()));
-SND_SOC_DAILINK_DEF(links_codecs,
+SND_SOC_DAILINK_DEFS(links,
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 struct snow_priv {
@@ -150,6 +150,8 @@ static int snow_probe(struct platform_device *pdev)
 	link->num_cpus = ARRAY_SIZE(links_cpus);
 	link->codecs = links_codecs;
 	link->num_codecs = ARRAY_SIZE(links_codecs);
+	link->platforms = links_platforms;
+	link->num_platforms = ARRAY_SIZE(links_platforms);
 
 	card->dai_link = link;
 	card->num_links = 1;
@@ -205,6 +207,8 @@ static int snow_probe(struct platform_device *pdev)
 		}
 	}
 
+	link->platforms->of_node = link->cpus->of_node;
+
 	/* Update card-name if provided through DT, else use default name */
 	snd_soc_of_parse_card_name(card, "samsung,model");
 
-- 
2.20.1
