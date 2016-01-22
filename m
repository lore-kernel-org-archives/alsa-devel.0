From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: always call probe/remove for MUX"
	to the asoc tree
Date: Fri, 22 Jan 2016 18:26:46 +0000
Message-ID: <E1aMgQ2-000496-Pd@debutante>
References: <87io2n4s18.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47DC4260714
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:51 +0100 (CET)
In-Reply-To: <87io2n4s18.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: always call probe/remove for MUX

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

>From ea96380baa2794cb6e0d5bfbcca0c78b237a5f8a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:56:59 +0000
Subject: [PATCH] ASoC: rsnd: always call probe/remove for MUX

CTU/MUX/DVC/SSIU/SSI/Audio-DMAC-periperi might be used under multipath.
So, probe()/remove() need to be called multiple times.
This patch allows it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  1 +
 sound/soc/sh/rcar/rsnd.h | 14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index ad97ce3ae844..ed0918967def 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -163,6 +163,7 @@ void rsnd_mod_quit(struct rsnd_mod *mod)
 {
 	if (mod->clk)
 		clk_unprepare(mod->clk);
+	mod->clk = NULL;
 }
 
 void rsnd_mod_interrupt(struct rsnd_mod *mod,
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 317dd793149a..c7b2ba0daf2a 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -237,29 +237,29 @@ struct rsnd_mod {
 /*
  * status
  *
- * 0xH0000CBA
+ * 0xH0000CB0
  *
- * A	0: probe	1: remove
  * B	0: init		1: quit
  * C	0: start	1: stop
  *
  * H is always called (see __rsnd_mod_call)
+ * H	0: probe	1: remove
  * H	0: pcm_new
  * H	0: fallback
  * H	0: hw_params
  */
-#define __rsnd_mod_shift_probe		0
-#define __rsnd_mod_shift_remove		0
 #define __rsnd_mod_shift_init		4
 #define __rsnd_mod_shift_quit		4
 #define __rsnd_mod_shift_start		8
 #define __rsnd_mod_shift_stop		8
+#define __rsnd_mod_shift_probe		28 /* always called */
+#define __rsnd_mod_shift_remove		28 /* always called */
 #define __rsnd_mod_shift_pcm_new	28 /* always called */
 #define __rsnd_mod_shift_fallback	28 /* always called */
 #define __rsnd_mod_shift_hw_params	28 /* always called */
 
-#define __rsnd_mod_add_probe		 1
-#define __rsnd_mod_add_remove		-1
+#define __rsnd_mod_add_probe		0
+#define __rsnd_mod_add_remove		0
 #define __rsnd_mod_add_init		 1
 #define __rsnd_mod_add_quit		-1
 #define __rsnd_mod_add_start		 1
@@ -269,7 +269,7 @@ struct rsnd_mod {
 #define __rsnd_mod_add_hw_params	0
 
 #define __rsnd_mod_call_probe		0
-#define __rsnd_mod_call_remove		1
+#define __rsnd_mod_call_remove		0
 #define __rsnd_mod_call_init		0
 #define __rsnd_mod_call_quit		1
 #define __rsnd_mod_call_start		0
-- 
2.7.0.rc3
