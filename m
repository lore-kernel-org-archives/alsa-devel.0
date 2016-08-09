From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: use
	asoc_simple_card_canonicalize_dailink()" to the asoc tree
Date: Tue, 09 Aug 2016 13:43:51 +0100
Message-ID: <E1bX6Nr-0003WL-Pz@debutante>
References: <87fuqe7b2m.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 89713267CF4
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:44:00 +0200 (CEST)
In-Reply-To: <87fuqe7b2m.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: use asoc_simple_card_canonicalize_dailink()

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

>From c958374f1cd22ec87f210985f9f9e1ba8b3df30b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 9 Aug 2016 05:50:02 +0000
Subject: [PATCH] ASoC: simple-card: use
 asoc_simple_card_canonicalize_dailink()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 03ecca85a724..8b1efdd2b115 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -286,14 +286,9 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	if (!dai_link->cpu_dai_name || !dai_link->codec_dai_name) {
-		ret = -EINVAL;
+	ret = asoc_simple_card_canonicalize_dailink(dai_link);
+	if (ret < 0)
 		goto dai_link_of_err;
-	}
-
-	/* Assumes platform == cpu */
-	if (!dai_link->platform_of_node)
-		dai_link->platform_of_node = dai_link->cpu_of_node;
 
 	ret = asoc_simple_card_set_dailink_name(dev, dai_link,
 						"%s-%s",
-- 
2.8.1
