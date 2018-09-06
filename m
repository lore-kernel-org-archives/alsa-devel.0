From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't fallback to PIO mode when
	-EPROBE_DEFER" to the asoc tree
Date: Thu,  6 Sep 2018 11:44:24 +0100 (BST)
Message-ID: <20180906104424.2F39D1122A1F@debutante.sirena.org.uk>
References: <87y3cf9v11.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BE44226781A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:44:24 +0200 (CEST)
In-Reply-To: <87y3cf9v11.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 6c92d5a2744e27619a8fcc9d74b91ee9f1cdebd1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Sep 2018 03:21:47 +0000
Subject: [PATCH] ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER

Current rsnd driver will fallback to PIO mode if it can't get DMA
handler. But, DMA might return -EPROBE_DEFER when probe timing.
This driver always fallback to PIO mode especially from
commit ac6bbf0cdf4206c ("iommu: Remove IOMMU_OF_DECLARE") because
of this reason.

The DMA driver will be probed later, but sound driver might be
probed as PIO mode in such case. This patch fixup this issue.
Then, -EPROBE_DEFER is not error. Thus, let's don't indicate error
message in such case.
And it needs to call rsnd_adg_remove() individually if probe failed,
because it registers clk which should be unregister.

Maybe PIO fallback feature itself is not needed,
but let's keep it so far.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 10 +++++++++-
 sound/soc/sh/rcar/dma.c  |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b35f5509cfe2..d23c2bbff0cf 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -478,7 +478,7 @@ static int rsnd_status_update(u32 *status,
 			(func_call && (mod)->ops->fn) ? #fn : "");	\
 		if (func_call && (mod)->ops->fn)			\
 			tmp = (mod)->ops->fn(mod, io, param);		\
-		if (tmp)						\
+		if (tmp && (tmp != -EPROBE_DEFER))			\
 			dev_err(dev, "%s[%d] : %s error %d\n",		\
 				rsnd_mod_name(mod), rsnd_mod_id(mod),	\
 						     #fn, tmp);		\
@@ -1561,6 +1561,14 @@ static int rsnd_probe(struct platform_device *pdev)
 		rsnd_dai_call(remove, &rdai->capture, priv);
 	}
 
+	/*
+	 * adg is very special mod which can't use rsnd_dai_call(remove),
+	 * and it registers ADG clock on probe.
+	 * It should be unregister if probe failed.
+	 * Mainly it is assuming -EPROBE_DEFER case
+	 */
+	rsnd_adg_remove(priv);
+
 	return ret;
 }
 
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index fe63ef8600d0..d65ea7bc4dac 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -241,6 +241,10 @@ static int rsnd_dmaen_attach(struct rsnd_dai_stream *io,
 	/* try to get DMAEngine channel */
 	chan = rsnd_dmaen_request_channel(io, mod_from, mod_to);
 	if (IS_ERR_OR_NULL(chan)) {
+		/* Let's follow when -EPROBE_DEFER case */
+		if (PTR_ERR(chan) == -EPROBE_DEFER)
+			return PTR_ERR(chan);
+
 		/*
 		 * DMA failed. try to PIO mode
 		 * see
-- 
2.19.0.rc1
