From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup devm_request_irq() option
	on ssi.c" to the asoc tree
Date: Fri, 23 Oct 2015 08:10:07 +0900
Message-ID: <E1ZpOzn-000072-9r@finisterre>
References: <87zizbsipw.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B68C7266ABE
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:10:16 +0200 (CEST)
In-Reply-To: <87zizbsipw.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup devm_request_irq() option on ssi.c

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

>From b05ce4c0916dec0e31a12c35a3386e3ca3ed989a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Oct 2015 03:13:44 +0000
Subject: [PATCH] ASoC: rsnd: fixup devm_request_irq() option on ssi.c

bfc0cfe("ASoC: rsnd: don't use rsnd_mod_to_io() on rsnd_ssi_xxx()")
tidyuped devm_request_irq() option from ssi to mod, but devm_free_irq()
on rsnd_ssi_dma_remove() didn't modified. This patch fixups this issue.
Otherwise kernel will output WARNING message.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 842a35b..40e2b5d 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -555,7 +555,7 @@ static int rsnd_ssi_dma_remove(struct rsnd_mod *mod,
 	rsnd_dma_quit(io, rsnd_mod_to_dma(mod));
 
 	/* PIO will request IRQ again */
-	devm_free_irq(dev, irq, ssi);
+	devm_free_irq(dev, irq, mod);
 
 	return 0;
 }
-- 
2.6.1
