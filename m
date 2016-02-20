From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup forever loop bug on SSI" to
	the asoc tree
Date: Sun, 21 Feb 2016 02:16:04 +0900
Message-ID: <E1aXB8W-0008Qs-Sx@finisterre>
References: <87lh6itp2w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C5412651C8
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:23 +0100 (CET)
In-Reply-To: <87lh6itp2w.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup forever loop bug on SSI

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

>From 5bf5d8fc7f5a8a1e75413939e4bdb00ebc2d5610 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:16:04 +0000
Subject: [PATCH] ASoC: rsnd: fixup forever loop bug on SSI

commit b5b442abd9 ("ASoC: rsnd: add .irq callback")
added .irq support, and it cares both parent SSI and normal SSI.
But it should care only normal SSI. Otherwise SSI might be
forever loop if SSI is used as both parent SSI and normal SSI
(= 2 users), and if under/over run error happen. Because irq disable
do nothing in such case. This patch solve this issue.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index c5c4510..90c3f58 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -149,13 +149,12 @@ static int rsnd_ssi_irq(struct rsnd_mod *mod,
 			struct rsnd_priv *priv,
 			int enable)
 {
-	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	u32 val = 0;
 
 	if (rsnd_is_gen1(priv))
 		return 0;
 
-	if (ssi->usrcnt != 1)
+	if (rsnd_ssi_is_parent(mod, io))
 		return 0;
 
 	if (enable)
-- 
2.7.0
