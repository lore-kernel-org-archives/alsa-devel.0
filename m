From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: use common rsnd_ssi_status_xxx()"
	to the asoc tree
Date: Tue, 27 Oct 2015 13:48:27 +0900
Message-ID: <E1ZqwBP-0004od-Iv@finisterre>
References: <87k2qa3u1b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CAB832651EB
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:48:36 +0100 (CET)
In-Reply-To: <87k2qa3u1b.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: use common rsnd_ssi_status_xxx()

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

>From 272c6a0c739339c40217a179ead6a7569224dc32 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:42:09 +0000
Subject: [PATCH] ASoC: rsnd: use common rsnd_ssi_status_xxx()

Current ssi.c driver has random access to SSISR register. Let's use
common rsnd_ssi_status_xxx() function

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 86e51ce..ad5539d 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -105,6 +105,16 @@ int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 	return use_busif;
 }
 
+static void rsnd_ssi_status_clear(struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, SSISR, 0);
+}
+
+static u32 rsnd_ssi_status_get(struct rsnd_mod *mod)
+{
+	return rsnd_mod_read(mod, SSISR);
+}
+
 static void rsnd_ssi_status_check(struct rsnd_mod *mod,
 				  u32 bit)
 {
@@ -114,7 +124,7 @@ static void rsnd_ssi_status_check(struct rsnd_mod *mod,
 	int i;
 
 	for (i = 0; i < 1024; i++) {
-		status = rsnd_mod_read(mod, SSISR);
+		status = rsnd_ssi_status_get(mod);
 		if (status & bit)
 			return;
 
@@ -245,7 +255,7 @@ static void rsnd_ssi_hw_start(struct rsnd_ssi *ssi,
 		rsnd_mod_write(mod, SSIWSR, CONT);
 
 	/* clear error status */
-	rsnd_mod_write(mod, SSISR, 0);
+	rsnd_ssi_status_clear(mod);
 
 	ssi->usrcnt++;
 
@@ -406,17 +416,20 @@ static int rsnd_ssi_hw_params(struct rsnd_mod *mod,
 	return 0;
 }
 
-static void rsnd_ssi_record_error(struct rsnd_ssi *ssi, u32 status)
+static u32 rsnd_ssi_record_error(struct rsnd_ssi *ssi)
 {
 	struct rsnd_mod *mod = rsnd_mod_get(ssi);
+	u32 status = rsnd_ssi_status_get(mod);
 
 	/* under/over flow error */
 	if (status & (UIRQ | OIRQ)) {
 		ssi->err++;
 
 		/* clear error status */
-		rsnd_mod_write(mod, SSISR, 0);
+		rsnd_ssi_status_clear(mod);
 	}
+
+	return status;
 }
 
 static int rsnd_ssi_start(struct rsnd_mod *mod,
@@ -442,7 +455,7 @@ static int rsnd_ssi_stop(struct rsnd_mod *mod,
 
 	rsnd_ssi_irq_disable(mod);
 
-	rsnd_ssi_record_error(ssi, rsnd_mod_read(mod, SSISR));
+	rsnd_ssi_record_error(ssi);
 
 	rsnd_ssi_hw_stop(io, ssi);
 
@@ -467,7 +480,7 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 	if (!rsnd_io_is_working(io))
 		goto rsnd_ssi_interrupt_out;
 
-	status = rsnd_mod_read(mod, SSISR);
+	status = rsnd_ssi_record_error(ssi);
 
 	/* PIO only */
 	if (!is_dma && (status & DIRQ)) {
@@ -500,8 +513,6 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 		rsnd_ssi_start(mod, io, priv);
 	}
 
-	rsnd_ssi_record_error(ssi, status);
-
 	if (ssi->err > 1024) {
 		rsnd_ssi_irq_disable(mod);
 
-- 
2.6.1
