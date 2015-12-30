From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fix usrcnt decrementing bug" to
	the asoc tree
Date: Wed, 30 Dec 2015 18:05:16 +0000
Message-ID: <E1aEL7c-0007LJ-Rm@debutante>
References: <1450940559-16516-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E806265A0C
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 19:05:24 +0100 (CET)
In-Reply-To: <1450940559-16516-1-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrzej Hajda <a.hajda@samsung.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fix usrcnt decrementing bug

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

>From e5d9cfc6f5fe56caa44cefbc7ef4531c480d901d Mon Sep 17 00:00:00 2001
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Thu, 24 Dec 2015 08:02:39 +0100
Subject: [PATCH] ASoC: rsnd: fix usrcnt decrementing bug

Field usrcnt is unsigned so it cannot be lesser than zero.
The patch fixes the check, moves it to the beginning of the function
and changes return value to -EIO in case of usercnt error.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 7db05fdfb656..7ee89da4dd5f 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -403,29 +403,30 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
-	if (rsnd_ssi_is_parent(mod, io))
-		goto rsnd_ssi_quit_end;
+	if (!ssi->usrcnt) {
+		dev_err(dev, "%s[%d] usrcnt error\n",
+			rsnd_mod_name(mod), rsnd_mod_id(mod));
+		return -EIO;
+	}
 
-	if (ssi->err > 0)
-		dev_warn(dev, "%s[%d] under/over flow err = %d\n",
-			 rsnd_mod_name(mod), rsnd_mod_id(mod), ssi->err);
+	if (!rsnd_ssi_is_parent(mod, io)) {
+		if (ssi->err > 0)
+			dev_warn(dev, "%s[%d] under/over flow err = %d\n",
+				 rsnd_mod_name(mod), rsnd_mod_id(mod),
+				 ssi->err);
 
-	ssi->cr_own	= 0;
-	ssi->err	= 0;
+		ssi->cr_own	= 0;
+		ssi->err	= 0;
 
-	rsnd_ssi_irq_disable(mod);
+		rsnd_ssi_irq_disable(mod);
+	}
 
-rsnd_ssi_quit_end:
 	rsnd_ssi_master_clk_stop(ssi, io);
 
 	rsnd_mod_power_off(mod);
 
 	ssi->usrcnt--;
 
-	if (ssi->usrcnt < 0)
-		dev_err(dev, "%s[%d] usrcnt error\n",
-			rsnd_mod_name(mod), rsnd_mod_id(mod));
-
 	return 0;
 }
 
-- 
2.6.2
