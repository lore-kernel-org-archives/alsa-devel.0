From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup semantics of
	rsnd_ssi_record_error()" to the asoc tree
Date: Fri, 27 Nov 2015 12:55:41 +0000
Message-ID: <E1a2IYv-0005qZ-Gr@debutante>
References: <87d1vejvyr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 511F52610A7
 for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2015 13:55:46 +0100 (CET)
In-Reply-To: <87d1vejvyr.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup semantics of rsnd_ssi_record_error()

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

>From 5342dff23263933060d0485cece864f36c0b5d32 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 26 Nov 2015 11:13:40 +0000
Subject: [PATCH] ASoC: rsnd: tidyup semantics of rsnd_ssi_record_error()

rsnd_ssi_record_error() should recorde error, but it clears error too.
this patch fixes up semantic of rsnd_ssi_record_error that it records
error but doesn't clear error.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 0fe5e3068b6b..40d5b587cbe9 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -396,13 +396,9 @@ static u32 rsnd_ssi_record_error(struct rsnd_ssi *ssi)
 	u32 status = rsnd_ssi_status_get(mod);
 
 	/* under/over flow error */
-	if (status & (UIRQ | OIRQ)) {
+	if (status & (UIRQ | OIRQ))
 		ssi->err++;
 
-		/* clear error status */
-		rsnd_ssi_status_clear(mod);
-	}
-
 	return status;
 }
 
@@ -537,6 +533,7 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 			 rsnd_mod_name(mod), rsnd_mod_id(mod));
 	}
 
+	rsnd_ssi_status_clear(mod);
 rsnd_ssi_interrupt_out:
 	spin_unlock(&priv->lock);
 
-- 
2.6.2
