From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add missing .irq callback for
	DMA" to the asoc tree
Date: Sun, 21 Feb 2016 02:16:03 +0900
Message-ID: <E1aXB8V-0008QP-K1@finisterre>
References: <87k2m2tp1v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 575B626514A
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:18 +0100 (CET)
In-Reply-To: <87k2m2tp1v.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: add missing .irq callback for DMA

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

>From c8e969a85ecb982dccf2ba13ba9aff9f1a68eab2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:16:43 +0000
Subject: [PATCH] ASoC: rsnd: add missing .irq callback for DMA

commit b5b442abd9d5 ("ASoC: rsnd: add .irq callback") added .irq callback
but SSI DMA is missing it. This patch adds it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 90c3f58..b1a29e2 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -694,6 +694,7 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.quit	= rsnd_ssi_quit,
 	.start	= rsnd_ssi_start,
 	.stop	= rsnd_ssi_stop,
+	.irq	= rsnd_ssi_irq,
 	.fallback = rsnd_ssi_fallback,
 	.hw_params = rsnd_ssi_hw_params,
 };
-- 
2.7.0
