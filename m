From: Mark Brown <broonie@kernel.org>
Subject: Applied "rcar: mux: Avoid use of ret uninitialised" to
	the asoc tree
Date: Tue, 15 Dec 2015 22:41:14 +0000
Message-ID: <E1a8yHS-0008AR-R4@debutante>
References: <1450094851-27525-3-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C7390260786
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 23:41:23 +0100 (CET)
In-Reply-To: <1450094851-27525-3-git-send-email-broonie@kernel.org>
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

   rcar: mux: Avoid use of ret uninitialised

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

>From 2b235a3da5560d65df6865ea436389e55a0f41ad Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Dec 2015 12:05:28 +0000
Subject: [PATCH] rcar: mux: Avoid use of ret uninitialised

We use ret as the return value from the rsnd_mix_probe() but if there
are no child nodes and no errors then we will never initialize ret leading
to build warnings. Ensure ret is initialized before we iterate over the
child nodes to avoid this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/mix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index b34957ab75b9..65542b6a89e9 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -158,6 +158,7 @@ int rsnd_mix_probe(struct rsnd_priv *priv)
 	priv->mix	= mix;
 
 	i = 0;
+	ret = 0;
 	for_each_child_of_node(node, np) {
 		mix = rsnd_mix_get(priv, i);
 
-- 
2.6.2
