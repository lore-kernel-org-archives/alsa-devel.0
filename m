From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: accept NULL
	parameter on asoc_simple_card_xxx()" to the asoc tree
Date: Wed, 21 Nov 2018 13:29:32 +0000 (GMT)
Message-ID: <20181121132932.9256B11250AE@debutante.sirena.org.uk>
References: <87tvkbp4v0.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 44201267A7E
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:29:33 +0100 (CET)
In-Reply-To: <87tvkbp4v0.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card-utils: accept NULL parameter on asoc_simple_card_xxx()

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

>From f31a17105560f5f074f4d26fd5469a221f50af18 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Nov 2018 02:09:16 +0000
Subject: [PATCH] ASoC: simple-card-utils: accept NULL parameter on
 asoc_simple_card_xxx()

If simple-card-utils accept NULL pointer on asoc_simple_card_xxx(),
each driver code will be more simple.
Let's accept NULL pointer.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 996bfe42bc8d..f3183a4718b3 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -153,13 +153,17 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_parse_card_name);
 
 int asoc_simple_card_clk_enable(struct asoc_simple_dai *dai)
 {
-	return clk_prepare_enable(dai->clk);
+	if (dai)
+		return clk_prepare_enable(dai->clk);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_clk_enable);
 
 void asoc_simple_card_clk_disable(struct asoc_simple_dai *dai)
 {
-	clk_disable_unprepare(dai->clk);
+	if (dai)
+		clk_disable_unprepare(dai->clk);
 }
 EXPORT_SYMBOL_GPL(asoc_simple_card_clk_disable);
 
@@ -342,6 +346,9 @@ int asoc_simple_card_init_dai(struct snd_soc_dai *dai,
 {
 	int ret;
 
+	if (!simple_dai)
+		return 0;
+
 	if (simple_dai->sysclk) {
 		ret = snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk,
 					     simple_dai->clk_direction);
-- 
2.19.0.rc2
