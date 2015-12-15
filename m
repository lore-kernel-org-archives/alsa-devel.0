From: Mark Brown <broonie@kernel.org>
Subject: Applied "rcar: ctu: Avoid use of ret uninitialised" to
	the asoc tree
Date: Tue, 15 Dec 2015 22:41:16 +0000
Message-ID: <E1a8yHU-0008BN-Lk@debutante>
References: <1450094851-27525-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C8CCA2608D3
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 23:41:23 +0100 (CET)
In-Reply-To: <1450094851-27525-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   rcar: ctu: Avoid use of ret uninitialised

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

>From 76ca9970322118610681af5f929aba62f346082b Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Dec 2015 12:04:54 +0000
Subject: [PATCH] rcar: ctu: Avoid use of ret uninitialised

We use ret as the return value from the rsnd_ctu_probe() but if there
are no child nodes and no errors then we will never initialize ret leading
to build warnings. Ensure ret is initialized before we iterate over the
child nodes to avoid this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 7c1e190cd389..d53a225d19e9 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -111,6 +111,7 @@ int rsnd_ctu_probe(struct rsnd_priv *priv)
 	priv->ctu	= ctu;
 
 	i = 0;
+	ret = 0;
 	for_each_child_of_node(node, np) {
 		ctu = rsnd_ctu_get(priv, i);
 
-- 
2.6.2
