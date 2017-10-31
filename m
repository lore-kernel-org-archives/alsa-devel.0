From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: NULL check is not needed for
	clk_unprepare()" to the asoc tree
Date: Tue, 31 Oct 2017 11:21:26 +0000
Message-ID: <E1e9Ubm-0002pD-Re@debutante>
References: <87wp3cxio8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 568992672B2
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 12:21:30 +0100 (CET)
In-Reply-To: <87wp3cxio8.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: NULL check is not needed for clk_unprepare()

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

>From ed3ac14ca90074d51f365dba5ed535e76ea155ea Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 31 Oct 2017 00:39:17 +0000
Subject: [PATCH] ASoC: rsnd: NULL check is not needed for clk_unprepare()

clk_unprepare() is checking parameter by IS_ERR_OR_NULL().
clk NULL check is not needed on rsnd_mod_quit()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 8fc3bf2b20f5..0216d3f53097 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -172,8 +172,7 @@ int rsnd_mod_init(struct rsnd_priv *priv,
 
 void rsnd_mod_quit(struct rsnd_mod *mod)
 {
-	if (mod->clk)
-		clk_unprepare(mod->clk);
+	clk_unprepare(mod->clk);
 	mod->clk = NULL;
 }
 
-- 
2.15.0.rc2
