From: Mark Brown <broonie@kernel.org>
Subject: Applied "rcar: dvc: Avoid use of ret uninitialised" to
	the asoc tree
Date: Tue, 15 Dec 2015 22:41:15 +0000
Message-ID: <E1a8yHT-0008Au-O1@debutante>
References: <1450094851-27525-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA0DB2610C5
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 23:41:23 +0100 (CET)
In-Reply-To: <1450094851-27525-2-git-send-email-broonie@kernel.org>
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

   rcar: dvc: Avoid use of ret uninitialised

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

>From 2e4118dac3d6765186dd1faf1fd3cede37b74e73 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Dec 2015 12:05:17 +0000
Subject: [PATCH] rcar: dvc: Avoid use of ret uninitialised

We use ret as the return value from the rsnd_dvc_probe() but if there
are no child nodes and no errors then we will never initialize ret leading
to build warnings. Ensure ret is initialized before we iterate over the
child nodes to avoid this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 66aeea8e0069..42e6a230a3d1 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -360,6 +360,7 @@ int rsnd_dvc_probe(struct rsnd_priv *priv)
 	priv->dvc	= dvc;
 
 	i = 0;
+	ret = 0;
 	for_each_child_of_node(node, np) {
 		dvc = rsnd_dvc_get(priv, i);
 
-- 
2.6.2
