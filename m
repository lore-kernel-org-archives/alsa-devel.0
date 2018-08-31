From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-util: remove dai_link
	compatible code for platform" to the asoc tree
Date: Fri, 31 Aug 2018 16:26:27 +0100 (BST)
Message-ID: <20180831152627.B4B4C11226FE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 41287267964
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:26:29 +0200 (CEST)
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

   ASoC: simple-card-util: remove dai_link compatible code for platform

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

>From c2f0898b86486a459fa8c91d194f3b699498c0c1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 31 Aug 2018 03:11:25 +0000
Subject: [PATCH] ASoC: simple-card-util: remove dai_link compatible code for
 platform

Now no simple/audio cards are using legacy dai_link style for platform.
Let's remove compatible code.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 644cd62ba027..b400dbf1f834 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -376,13 +376,9 @@ EXPORT_SYMBOL_GPL(asoc_simple_card_init_dai);
 int asoc_simple_card_canonicalize_dailink(struct snd_soc_dai_link *dai_link)
 {
 	/* Assumes platform == cpu */
-	if (dai_link->platform) {
-		if (!dai_link->platform->of_node)
-			dai_link->platform->of_node = dai_link->cpu_of_node;
-	} else {
-		if (!dai_link->platform_of_node)
-			dai_link->platform_of_node = dai_link->cpu_of_node;
-	}
+	if (!dai_link->platform->of_node)
+		dai_link->platform->of_node = dai_link->cpu_of_node;
+
 	return 0;
 
 }
-- 
2.19.0.rc1
