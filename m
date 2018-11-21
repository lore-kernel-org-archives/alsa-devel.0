From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: remove
	asoc_simple_card_clk_register()" to the asoc tree
Date: Wed, 21 Nov 2018 13:29:42 +0000 (GMT)
Message-ID: <20181121132942.1912111250AE@debutante.sirena.org.uk>
References: <87va4rp4vj.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DD0B267A61
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:29:42 +0100 (CET)
In-Reply-To: <87va4rp4vj.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card-utils: remove asoc_simple_card_clk_register()

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

>From c0f4697c5dbca0c9bdd1264bcf2d7c5d15a14f67 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Nov 2018 02:08:59 +0000
Subject: [PATCH] ASoC: simple-card-utils: remove
 asoc_simple_card_clk_register()

asoc_simple_card_clk_register() is used but only 1 user,
and very pointless code. Let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index f34cc6cddfa2..996bfe42bc8d 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -151,12 +151,6 @@ int asoc_simple_card_parse_card_name(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 
-static void asoc_simple_card_clk_register(struct asoc_simple_dai *dai,
-					  struct clk *clk)
-{
-	dai->clk = clk;
-}
-
 int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 {
 	return clk_prepare_enable(dai->clk);
@@ -200,7 +194,7 @@ int asoc_simple_card_parse_clk(struct device *dev,
 	if (!IS_ERR(clk)) {
 		simple_dai->sysclk = clk_get_rate(clk);
 
-		asoc_simple_card_clk_register(simple_dai, clk);
+		simple_dai->clk = clk;
 	} else if (!of_property_read_u32(node, "system-clock-frequency", &val)) {
 		simple_dai->sysclk = val;
 	} else {
-- 
2.19.0.rc2
