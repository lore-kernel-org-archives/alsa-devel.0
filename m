From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: move rsnd_ssi_irq() position" to
	the asoc tree
Date: Sun, 21 Feb 2016 02:15:59 +0900
Message-ID: <E1aXB8R-0008P1-RJ@finisterre>
References: <87fuwqtoz8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60D632651BE
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:16:05 +0100 (CET)
In-Reply-To: <87fuwqtoz8.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: move rsnd_ssi_irq() position

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

>From 615fb6c7b13b7f142f5f8e23e5f8593dd1e7b319 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Feb 2016 08:18:16 +0000
Subject: [PATCH] ASoC: rsnd: move rsnd_ssi_irq() position

prepare for runtime judging for SSI work

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index b5c6f0c..d46bc08 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -144,27 +144,6 @@ static void rsnd_ssi_status_check(struct rsnd_mod *mod,
 		 rsnd_mod_name(mod), rsnd_mod_id(mod));
 }
 
-static int rsnd_ssi_irq(struct rsnd_mod *mod,
-			struct rsnd_dai_stream *io,
-			struct rsnd_priv *priv,
-			int enable)
-{
-	u32 val = 0;
-
-	if (rsnd_is_gen1(priv))
-		return 0;
-
-	if (rsnd_ssi_is_parent(mod, io))
-		return 0;
-
-	if (enable)
-		val = rsnd_ssi_is_dma_mode(mod) ? 0x0e000000 : 0x0f000000;
-
-	rsnd_mod_write(mod, SSI_INT_ENABLE, val);
-
-	return 0;
-}
-
 u32 rsnd_ssi_multi_slaves(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *mod;
@@ -480,6 +459,27 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 	return 0;
 }
 
+static int rsnd_ssi_irq(struct rsnd_mod *mod,
+			struct rsnd_dai_stream *io,
+			struct rsnd_priv *priv,
+			int enable)
+{
+	u32 val = 0;
+
+	if (rsnd_is_gen1(priv))
+		return 0;
+
+	if (rsnd_ssi_is_parent(mod, io))
+		return 0;
+
+	if (enable)
+		val = rsnd_ssi_is_dma_mode(mod) ? 0x0e000000 : 0x0f000000;
+
+	rsnd_mod_write(mod, SSI_INT_ENABLE, val);
+
+	return 0;
+}
+
 static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io)
 {
-- 
2.7.0
