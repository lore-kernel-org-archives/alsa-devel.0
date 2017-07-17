From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove unnecessary static in
	rsnd_ssiu_probe()" to the asoc tree
Date: Mon, 17 Jul 2017 17:04:18 +0100
Message-ID: <E1dX8VO-0004O9-4w@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB6A266F93
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:04:27 +0200 (CEST)
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
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove unnecessary static in rsnd_ssiu_probe()

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

>From 32e1b60d8f91be932c4a624d4153224895b65ec7 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Mon, 17 Jul 2017 10:30:20 -0500
Subject: [PATCH] ASoC: rsnd: remove unnecessary static in rsnd_ssiu_probe()

Remove unnecessary static on local variable ops.
Such variable is initialized before being used,
on every execution path throughout the function.
The static has no benefit and, removing it reduces
the code size.

This issue was detected using Coccinelle and the following semantic patch:

@bad exists@
position p;
identifier x;
type T;
@@

static T x@p;
...
x = <+...x...+>

@@
identifier x;
expression e;
type T;
position p != bad.p;
@@

-static
 T x@p;
 ... when != x
     when strict
?x = e;

In the following log you can see the difference in the code size. Also,
there is a significant difference in the bss segment. This log is the
output of the size command, before and after the code change:

before:
   text    data     bss     dec     hex filename
   3211     680      64    3955     f73 sound/soc/sh/rcar/ssiu.o

after:
   text    data     bss     dec     hex filename
   3207     592       0    3799     ed7 sound/soc/sh/rcar/ssiu.o

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index bed2c9c0004b..4d948757d300 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -250,7 +250,7 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_ssiu *ssiu;
-	static struct rsnd_mod_ops *ops;
+	struct rsnd_mod_ops *ops;
 	int i, nr, ret;
 
 	/* same number to SSI */
-- 
2.13.2
