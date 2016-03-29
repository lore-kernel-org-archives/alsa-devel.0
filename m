From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: Adjust clk definitions so that
	simple card can work" to the asoc tree
Date: Tue, 29 Mar 2016 10:08:11 -0700
Message-ID: <E1akx7j-0001GZ-Ro@finisterre>
References: <1459114573-2006-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E5882668C6
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 19:08:23 +0200 (CEST)
In-Reply-To: <1459114573-2006-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8962: Adjust clk definitions so that simple card can work

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

>From 937e92dc50231bb41294262abf56d2bdddc4d38c Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 27 Mar 2016 18:36:13 -0300
Subject: [PATCH] ASoC: wm8962: Adjust clk definitions so that simple card can
 work

When trying to use simple card with wm8962 the following probe
error happens:

wm8962 0-001a: simple-card: set_sysclk error
asoc-simple-card sound: ASoC: failed to init 202c000.ssi-wm8962: -22
asoc-simple-card sound: ASoC: failed to instantiate card -22
asoc-simple-card: probe of sound failed with error -22

In simple-card.c the snd_soc_dai_set_sysclk() function is called with
clk_id as 0, which is an invalid clock for wm8962.

Adjust the clocks source definitions in wm8962.h so that the
simple card driver can work successfully.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.h b/sound/soc/codecs/wm8962.h
index 910aafd09d21..e63a318a3015 100644
--- a/sound/soc/codecs/wm8962.h
+++ b/sound/soc/codecs/wm8962.h
@@ -16,9 +16,9 @@
 #include <asm/types.h>
 #include <sound/soc.h>
 
-#define WM8962_SYSCLK_MCLK 1
-#define WM8962_SYSCLK_FLL  2
-#define WM8962_SYSCLK_PLL3 3
+#define WM8962_SYSCLK_MCLK 0
+#define WM8962_SYSCLK_FLL  1
+#define WM8962_SYSCLK_PLL3 2
 
 #define WM8962_FLL  1
 
-- 
2.8.0.rc3
