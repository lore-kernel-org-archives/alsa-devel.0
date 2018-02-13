From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: indicate IRQ error status for
	debug" to the asoc tree
Date: Tue, 13 Feb 2018 12:16:21 +0000
Message-ID: <E1elZVV-0005ZQ-CS@debutante>
References: <874lmllk1k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BEB53267986
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:16:23 +0100 (CET)
In-Reply-To: <874lmllk1k.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, hiroyuki.yokoyama.vx@renesas.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: indicate IRQ error status for debug

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

>From 2b62786951ca38cc9fd0bd9273de0aae1b45134d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Feb 2018 02:08:53 +0000
Subject: [PATCH] ASoC: rsnd: indicate IRQ error status for debug

SSI/SRC have under/over flow error handling, and its status is useful
for debuging. But sometimes it might be too much message,
and it might blocks necessity other information.

To avoid such situation, basically this patch indicates interrupt
status debug message if DEBUG was defined, but it will be suppressed
if RSND_DEBUG_NO_IRQ_STATUS was defined.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 10 ++++++++++
 sound/soc/sh/rcar/src.c  | 22 ++++++++++++++++++++--
 sound/soc/sh/rcar/ssi.c  | 16 +++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ad6523595b0a..5241ea7cf153 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -788,4 +788,14 @@ void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type);
 #define rsnd_mod_confirm_dvc(mdvc)
 #endif
 
+/*
+ * If you don't need interrupt status debug message,
+ * define RSND_DEBUG_NO_IRQ_STATUS as 1 on top of src.c/ssi.c
+ *
+ * #define RSND_DEBUG_NO_IRQ_STATUS 1
+ */
+#define rsnd_dbg_irq_status(dev, param...)		\
+	if (!IS_BUILTIN(RSND_DEBUG_NO_IRQ_STATUS))	\
+		dev_dbg(dev, param)
+
 #endif
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 510b68a483b4..a727e71587b6 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -8,6 +8,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+/*
+ * you can enable below define if you don't need
+ * SSI interrupt status debug message when debugging
+ * see rsnd_dbg_irq_status()
+ *
+ * #define RSND_DEBUG_NO_IRQ_STATUS 1
+ */
+
 #include "rsnd.h"
 
 #define SRC_NAME "src"
@@ -325,7 +334,10 @@ static void rsnd_src_status_clear(struct rsnd_mod *mod)
 
 static bool rsnd_src_error_occurred(struct rsnd_mod *mod)
 {
+	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	u32 val0, val1;
+	u32 status0, status1;
 	bool ret = false;
 
 	val0 = val1 = OUF_SRC(rsnd_mod_id(mod));
@@ -338,9 +350,15 @@ static bool rsnd_src_error_occurred(struct rsnd_mod *mod)
 	if (rsnd_src_sync_is_enabled(mod))
 		val0 = val0 & 0xffff;
 
-	if ((rsnd_mod_read(mod, SCU_SYS_STATUS0) & val0) ||
-	    (rsnd_mod_read(mod, SCU_SYS_STATUS1) & val1))
+	status0 = rsnd_mod_read(mod, SCU_SYS_STATUS0);
+	status1 = rsnd_mod_read(mod, SCU_SYS_STATUS1);
+	if ((status0 & val0) || (status1 & val1)) {
+		rsnd_dbg_irq_status(dev, "%s[%d] err status : 0x%08x, 0x%08x\n",
+			rsnd_mod_name(mod), rsnd_mod_id(mod),
+			status0, status1);
+
 		ret = true;
+	}
 
 	return ret;
 }
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 97a9db892a8f..333b802681ad 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -11,6 +11,15 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+
+/*
+ * you can enable below define if you don't need
+ * SSI interrupt status debug message when debugging
+ * see rsnd_dbg_irq_status()
+ *
+ * #define RSND_DEBUG_NO_IRQ_STATUS 1
+ */
+
 #include <sound/simple_card_utils.h>
 #include <linux/delay.h>
 #include "rsnd.h"
@@ -603,6 +612,7 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 				 struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
+	struct device *dev = rsnd_priv_to_dev(priv);
 	int is_dma = rsnd_ssi_is_dma_mode(mod);
 	u32 status;
 	bool elapsed = false;
@@ -621,8 +631,12 @@ static void __rsnd_ssi_interrupt(struct rsnd_mod *mod,
 		elapsed = rsnd_ssi_pio_interrupt(mod, io);
 
 	/* DMA only */
-	if (is_dma && (status & (UIRQ | OIRQ)))
+	if (is_dma && (status & (UIRQ | OIRQ))) {
+		rsnd_dbg_irq_status(dev, "%s[%d] err status : 0x%08x\n",
+			rsnd_mod_name(mod), rsnd_mod_id(mod), status);
+
 		stop = true;
+	}
 
 	rsnd_ssi_status_clear(mod);
 rsnd_ssi_interrupt_out:
-- 
2.16.1
