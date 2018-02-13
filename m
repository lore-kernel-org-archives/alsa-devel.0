From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: suppress rsnd_dai_call() debug
	message" to the asoc tree
Date: Tue, 13 Feb 2018 12:16:11 +0000
Message-ID: <E1elZVL-0005YN-Gv@debutante>
References: <873725lk0x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3B8267963
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:16:13 +0100 (CET)
In-Reply-To: <873725lk0x.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: suppress rsnd_dai_call() debug message

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

>From 1f6e920faae065fa8e6985b99ec86899bc3308de Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Feb 2018 02:09:14 +0000
Subject: [PATCH] ASoC: rsnd: suppress rsnd_dai_call() debug message

rsnd_dai_call() is using dev_dbg(), but its message is sometimes
blocks nessesary other messages. If RSND_DEBUG_NO_DAI_CALL was
defined it will be suppressed by this patch.

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 11 ++++++++++-
 sound/soc/sh/rcar/rsnd.h | 10 ++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 64d5ecb86528..5aafc37f5119 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -93,6 +93,15 @@
  *  [mod]->fn() -> [mod]->fn() -> [mod]->fn()...
  *
  */
+
+/*
+ * you can enable below define if you don't need
+ * DAI status debug message when debugging
+ * see rsnd_dbg_dai_call()
+ *
+ * #define RSND_DEBUG_NO_DAI_CALL 1
+ */
+
 #include <linux/pm_runtime.h>
 #include "rsnd.h"
 
@@ -468,7 +477,7 @@ static int rsnd_status_update(u32 *status,
 						__rsnd_mod_shift_##fn,	\
 						__rsnd_mod_add_##fn,	\
 						__rsnd_mod_call_##fn);	\
-		dev_dbg(dev, "%s[%d]\t0x%08x %s\n",			\
+		rsnd_dbg_dai_call(dev, "%s[%d]\t0x%08x %s\n",		\
 			rsnd_mod_name(mod), rsnd_mod_id(mod), *status,	\
 			(func_call && (mod)->ops->fn) ? #fn : "");	\
 		if (func_call && (mod)->ops->fn)			\
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 5241ea7cf153..172c8d612890 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -798,4 +798,14 @@ void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type);
 	if (!IS_BUILTIN(RSND_DEBUG_NO_IRQ_STATUS))	\
 		dev_dbg(dev, param)
 
+/*
+ * If you don't need rsnd_dai_call debug message,
+ * define RSND_DEBUG_NO_DAI_CALL as 1 on top of core.c
+ *
+ * #define RSND_DEBUG_NO_DAI_CALL 1
+ */
+#define rsnd_dbg_dai_call(dev, param...)		\
+	if (!IS_BUILTIN(RSND_DEBUG_NO_DAI_CALL))	\
+		dev_dbg(dev, param)
+
 #endif
-- 
2.16.1
