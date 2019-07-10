From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: care no Platform for
	DPCM" to the asoc tree
Date: Wed, 10 Jul 2019 16:34:49 +0100 (BST)
Message-ID: <20190710153449.2C89AD02D84@fitzroy.sirena.org.uk>
References: <87muhmgw2o.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C05EBF802FB
 for <alsa-devel@alsa-project.org>; Wed, 10 Jul 2019 17:34:49 +0200 (CEST)
In-Reply-To: <87muhmgw2o.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: simple-card-utils: care no Platform for DPCM

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

>From 794fcee8da3c0c8a01b08ecad1c181cb0a622868 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Jul 2019 17:01:12 +0900
Subject: [PATCH] ASoC: simple-card-utils: care no Platform for DPCM

commit 34614739988ad ("ASoC: soc-core: support dai_link with
platforms_num != 1") supports multi Platform, and
commit 9f3eb91753451 ("ASoC: simple-card-utils: consider CPU-Platform
possibility") removed no Platform from simple-card.

Multi Platform is now checking both Platform name/of_node are NULL case.
But in normal case, DPCM be doesn't have Platform.

asoc_simple_canonicalize_platform() try to use CPU of_node
to Platform (This is needed for DMAEngine platform case),
but it still might be NULL at DPCM be.

This patch try to use no Platform after that if Platform of_node
is still NULL. It can't probe without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/87muhmgw2o.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index ac8678fe55ff..556b1a789629 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -349,6 +349,13 @@ void asoc_simple_canonicalize_platform(struct snd_soc_dai_link *dai_link)
 	/* Assumes platform == cpu */
 	if (!dai_link->platforms->of_node)
 		dai_link->platforms->of_node = dai_link->cpus->of_node;
+
+	/*
+	 * DPCM BE can be no platform.
+	 * Alloced memory will be waste, but not leak.
+	 */
+	if (!dai_link->platforms->of_node)
+		dai_link->num_platforms = 0;
 }
 EXPORT_SYMBOL_GPL(asoc_simple_canonicalize_platform);
 
-- 
2.20.1
