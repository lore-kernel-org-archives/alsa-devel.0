From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: call request_irq/free_irq once in MIX case" to the asoc tree
Date: Thu, 10 Aug 2017 16:42:19 +0100
Message-ID: <E1dfpbH-0001js-DV@finisterre>
References: <873790z3y6.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <873790z3y6.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: call request_irq/free_irq once in MIX case

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

>From b6e58fcacb3edc6245ecf700207ba675cba18018 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Aug 2017 00:07:38 +0000
Subject: [PATCH] ASoC: rsnd: call request_irq/free_irq once in MIX case

Each module's dai callback function availability is controlled
by mod->status. For example "always called", "call once".
In .probe/.remove case, it needs to be called always, because
.probe will call xxx_attach() function on .probe, especially
if platform is using MIXer.
For example, below case, MIX0/DVC0/SSI0 needs to be called twice.

        playback = <&src0 &ctu02 &mix0 &dvc0 &ssi0>;
        playback = <&src2 &ctu03 &mix0 &dvc0 &ssi0>;

But in this case, SSI0 will call request_irq() twice.
This patch add new RSND_SSI_PROBED flag and control it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index ca9355b86bd9..8bb47144660b 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -90,6 +90,7 @@ struct rsnd_ssi {
 #define RSND_SSI_NO_BUSIF		(1 << 1) /* SSI+DMA without BUSIF */
 #define RSND_SSI_HDMI0			(1 << 2) /* for HDMI0 */
 #define RSND_SSI_HDMI1			(1 << 3) /* for HDMI1 */
+#define RSND_SSI_PROBED			(1 << 4)
 
 #define for_each_rsnd_ssi(pos, priv, i)					\
 	for (i = 0;							\
@@ -103,6 +104,7 @@ struct rsnd_ssi {
 #define rsnd_mod_to_ssi(_mod) container_of((_mod), struct rsnd_ssi, mod)
 #define rsnd_ssi_flags_has(p, f) ((p)->flags & f)
 #define rsnd_ssi_flags_set(p, f) ((p)->flags |= f)
+#define rsnd_ssi_flags_del(p, f) ((p)->flags = ((p)->flags & ~f))
 #define rsnd_ssi_is_parent(ssi, io) ((ssi) == rsnd_io_to_mod_ssip(io))
 #define rsnd_ssi_is_multi_slave(mod, io) \
 	(rsnd_ssi_multi_slaves(io) & (1 << rsnd_mod_id(mod)))
@@ -784,11 +786,22 @@ static int rsnd_ssi_common_probe(struct rsnd_mod *mod,
 	/*
 	 * SSI might be called again as PIO fallback
 	 * It is easy to manual handling for IRQ request/free
+	 *
+	 * OTOH, this function might be called many times if platform is
+	 * using MIX. It needs xxx_attach() many times on xxx_probe().
+	 * Because of it, we can't control .probe/.remove calling count by
+	 * mod->status.
+	 * But it don't need to call request_irq() many times.
+	 * Let's control it by RSND_SSI_PROBED flag.
 	 */
-	ret = request_irq(ssi->irq,
-			  rsnd_ssi_interrupt,
-			  IRQF_SHARED,
-			  dev_name(dev), mod);
+	if (!rsnd_ssi_flags_has(ssi, RSND_SSI_PROBED)) {
+		ret = request_irq(ssi->irq,
+				  rsnd_ssi_interrupt,
+				  IRQF_SHARED,
+				  dev_name(dev), mod);
+
+		rsnd_ssi_flags_set(ssi, RSND_SSI_PROBED);
+	}
 
 	return ret;
 }
@@ -805,7 +818,11 @@ static int rsnd_ssi_common_remove(struct rsnd_mod *mod,
 		return 0;
 
 	/* PIO will request IRQ again */
-	free_irq(ssi->irq, mod);
+	if (rsnd_ssi_flags_has(ssi, RSND_SSI_PROBED)) {
+		free_irq(ssi->irq, mod);
+
+		rsnd_ssi_flags_del(ssi, RSND_SSI_PROBED);
+	}
 
 	return 0;
 }
-- 
2.13.2
