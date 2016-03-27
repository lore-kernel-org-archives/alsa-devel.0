From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: wm8962: Adjust clk definitions so that
	simple card can work
Date: Sun, 27 Mar 2016 18:36:13 -0300
Message-ID: <1459114573-2006-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com
 [209.85.220.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 7094C261785
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 23:36:40 +0200 (CEST)
Received: by mail-qk0-f172.google.com with SMTP id i4so49614469qkc.3
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 14:36:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

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
---
 sound/soc/codecs/wm8962.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.h b/sound/soc/codecs/wm8962.h
index 910aafd..e63a318 100644
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
1.9.1
