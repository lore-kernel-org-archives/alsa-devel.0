From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup SSI clock during
	suspend/resume modes" to the asoc tree
Date: Fri, 21 Sep 2018 18:05:38 +0100 (BST)
Message-ID: <20180921170538.65F7B440078@finisterre.ee.mobilebroadband>
References: <87fty3310u.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B2152676A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 19:05:41 +0200 (CEST)
In-Reply-To: <87fty3310u.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmytro Prokopchuk <dmytro.prokopchuk@globallogic.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup SSI clock during suspend/resume modes

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

>From 624d1a7cd8991e33dad96ab4629a52c412540e65 Mon Sep 17 00:00:00 2001
From: Dmytro Prokopchuk <dmytro.prokopchuk@globallogic.com>
Date: Fri, 21 Sep 2018 04:59:59 +0000
Subject: [PATCH] ASoC: rsnd: fixup SSI clock during suspend/resume modes

Prepare <-> Cleanup functions pair has balanced calls.
But in case of suspend mode no call to rsnd_soc_dai_shutdown()
function, so cleanup isn't called. OTOH during resume mode
function rsnd_soc_dai_prepare() is called, but calling
rsnd_ssi_prepare() is skipped (rsnd_status_update() returns zero,
bacause was not cleanup before).
We need to call rsnd_ssi_prepare(), because it enables SSI clocks
by calling rsnd_ssi_master_clk_start().

This patch allows to call prepare/cleanup functions always.

Signed-off-by: Dmytro Prokopchuk <dmytro.prokopchuk@globallogic.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
[kuninori: adjusted to upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dma.c  |  7 +++----
 sound/soc/sh/rcar/rsnd.h | 14 +++++++-------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 0bbc4b0ea2c6..6d1947515dc8 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -134,10 +134,9 @@ static int rsnd_dmaen_prepare(struct rsnd_mod *mod,
 	struct rsnd_dmaen *dmaen = rsnd_dma_to_dmaen(dma);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
-	if (dmaen->chan) {
-		dev_err(dev, "it already has dma channel\n");
-		return -EIO;
-	}
+	/* maybe suspended */
+	if (dmaen->chan)
+		return 0;
 
 	/*
 	 * DMAEngine request uses mutex lock.
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index e857311ee5c1..4464d1d0a042 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -318,9 +318,8 @@ struct rsnd_mod {
 /*
  * status
  *
- * 0xH0000CBA
+ * 0xH0000CB0
  *
- * A	0: prepare	1: cleanup
  * B	0: init		1: quit
  * C	0: start	1: stop
  *
@@ -331,9 +330,8 @@ struct rsnd_mod {
  * H	0: hw_params
  * H	0: pointer
  * H	0: prepare
+ * H	0: cleanup
  */
-#define __rsnd_mod_shift_prepare	0
-#define __rsnd_mod_shift_cleanup	0
 #define __rsnd_mod_shift_init		4
 #define __rsnd_mod_shift_quit		4
 #define __rsnd_mod_shift_start		8
@@ -345,11 +343,13 @@ struct rsnd_mod {
 #define __rsnd_mod_shift_fallback	28 /* always called */
 #define __rsnd_mod_shift_hw_params	28 /* always called */
 #define __rsnd_mod_shift_pointer	28 /* always called */
+#define __rsnd_mod_shift_prepare	28 /* always called */
+#define __rsnd_mod_shift_cleanup	28 /* always called */
 
 #define __rsnd_mod_add_probe		0
 #define __rsnd_mod_add_remove		0
-#define __rsnd_mod_add_prepare		 1
-#define __rsnd_mod_add_cleanup		-1
+#define __rsnd_mod_add_prepare		0
+#define __rsnd_mod_add_cleanup		0
 #define __rsnd_mod_add_init		 1
 #define __rsnd_mod_add_quit		-1
 #define __rsnd_mod_add_start		 1
@@ -363,7 +363,7 @@ struct rsnd_mod {
 #define __rsnd_mod_call_probe		0
 #define __rsnd_mod_call_remove		0
 #define __rsnd_mod_call_prepare		0
-#define __rsnd_mod_call_cleanup		1
+#define __rsnd_mod_call_cleanup		0
 #define __rsnd_mod_call_init		0
 #define __rsnd_mod_call_quit		1
 #define __rsnd_mod_call_start		0
-- 
2.19.0
