From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rcar ctu: Staticise local symbols" to
	the asoc tree
Date: Wed, 29 Jul 2015 15:13:07 +0100
Message-ID: <E1ZKS6V-0004Yq-Va@finisterre>
References: <1437987388-9706-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C168E265150
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:29 +0200 (CEST)
In-Reply-To: <1437987388-9706-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rcar ctu: Staticise local symbols

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

>From e773c2f964640e103cc75a45aa4555c73ba55c29 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 27 Jul 2015 10:56:25 +0200
Subject: [PATCH] ASoC: rcar ctu: Staticise local symbols

rsnd_of_parse_ctu() is not used outside this file so it can be static.
Fixes the following sparse warning:

	sound/soc/sh/rcar/ctu.c:72:6: warning: symbol 'rsnd_of_parse_ctu' was
		not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 05edd20..05498bb 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -69,7 +69,7 @@ struct rsnd_mod *rsnd_ctu_mod_get(struct rsnd_priv *priv, int id)
 	return &((struct rsnd_ctu *)(priv->ctu) + id)->mod;
 }
 
-void rsnd_of_parse_ctu(struct platform_device *pdev,
+static void rsnd_of_parse_ctu(struct platform_device *pdev,
 		       const struct rsnd_of_data *of_data,
 		       struct rsnd_priv *priv)
 {
-- 
2.1.4
