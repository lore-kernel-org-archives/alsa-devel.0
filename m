From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: count .probe/.remove for rsnd_mod_call()" to the asoc tree
Date: Thu, 28 Apr 2016 18:47:38 +0100
Message-ID: <E1avq2M-00025X-7a@debutante>
References: <87r3dqh5i5.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87r3dqh5i5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiep Cao Minh <cm-hiep@jinso.co.jp>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>Cao Minh Hiep <cm-hiep@jinso.co.jp>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Simon <horms@verge.net.au>, "osd2@lm.renesas.com" <osd2@lm.renesas.com>, h-inayoshi@jinso.co.jp, "M.Miura" <m-miura@jinso.co.jp>, Nguyen Viet Dung <nv-dung@jinso.co.jp>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: count .probe/.remove for rsnd_mod_call()

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

>From 1a5658c213116d56a1a38e83588f6636a57d6374 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 28 Apr 2016 01:49:48 +0000
Subject: [PATCH] ASoC: rsnd: count .probe/.remove for rsnd_mod_call()

Current rsnd_mod_call is counting its calling count to avoid unbalanced
function pair calling for error cases (ex init <-> quit).
SSI parent is now controlled as "mod" on current rsnd driver. Because of
this reason, SSI .remove function will be called twice if it was used as
SSI parent when user tried unbind. But probe/remove pair were not
counted. This patch counts probe/remove functions to avoid it.
Special thans Hiep

Reported-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index fc89a67258ca..a8f61d79333b 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -276,8 +276,9 @@ struct rsnd_mod {
 /*
  * status
  *
- * 0xH0000CB0
+ * 0xH0000CBA
  *
+ * A	0: probe	1: remove
  * B	0: init		1: quit
  * C	0: start	1: stop
  *
@@ -287,19 +288,19 @@ struct rsnd_mod {
  * H	0: fallback
  * H	0: hw_params
  */
+#define __rsnd_mod_shift_probe		0
+#define __rsnd_mod_shift_remove		0
 #define __rsnd_mod_shift_init		4
 #define __rsnd_mod_shift_quit		4
 #define __rsnd_mod_shift_start		8
 #define __rsnd_mod_shift_stop		8
-#define __rsnd_mod_shift_probe		28 /* always called */
-#define __rsnd_mod_shift_remove		28 /* always called */
 #define __rsnd_mod_shift_irq		28 /* always called */
 #define __rsnd_mod_shift_pcm_new	28 /* always called */
 #define __rsnd_mod_shift_fallback	28 /* always called */
 #define __rsnd_mod_shift_hw_params	28 /* always called */
 
-#define __rsnd_mod_add_probe		0
-#define __rsnd_mod_add_remove		0
+#define __rsnd_mod_add_probe		 1
+#define __rsnd_mod_add_remove		-1
 #define __rsnd_mod_add_init		 1
 #define __rsnd_mod_add_quit		-1
 #define __rsnd_mod_add_start		 1
@@ -310,7 +311,7 @@ struct rsnd_mod {
 #define __rsnd_mod_add_hw_params	0
 
 #define __rsnd_mod_call_probe		0
-#define __rsnd_mod_call_remove		0
+#define __rsnd_mod_call_remove		1
 #define __rsnd_mod_call_init		0
 #define __rsnd_mod_call_quit		1
 #define __rsnd_mod_call_start		0
-- 
2.8.0.rc3
