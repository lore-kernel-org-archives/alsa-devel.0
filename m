From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] linux/kernel.h: move DIV_ROUND_DOWN_ULL() macro
Date: Tue, 25 Jul 2017 10:12:36 +0900
Message-ID: <1500945156-12907-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 40982266EBF
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 03:13:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Richard Weinberger <richard@nod.at>, Marek Vasut <marek.vasut@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: alsa-devel@alsa-project.org

This macro is useful to avoid link error on 32-bit systems.

We have the same definition in two drivers, so move it to
include/linux/kernel.h

While we are here, refactor DIV_ROUND_UP_ULL() by using
DIV_ROUND_DOWN_ULL().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/denali.c  | 3 ---
 include/linux/kernel.h     | 7 +++++--
 sound/soc/codecs/pcm512x.c | 3 ---
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/denali.c b/drivers/mtd/nand/denali.c
index d723be352148..3087b0ba7b7f 100644
--- a/drivers/mtd/nand/denali.c
+++ b/drivers/mtd/nand/denali.c
@@ -980,9 +980,6 @@ static int denali_erase(struct mtd_info *mtd, int page)
 	return irq_status & INTR__ERASE_COMP ? 0 : NAND_STATUS_FAIL;
 }
 
-#define DIV_ROUND_DOWN_ULL(ll, d) \
-	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
-
 static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
 				       const struct nand_data_interface *conf)
 {
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 96381f2b0e09..2a254ae6f7f7 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -78,8 +78,11 @@
 
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
-#define DIV_ROUND_UP_ULL(ll,d) \
-	({ unsigned long long _tmp = (ll)+(d)-1; do_div(_tmp, d); _tmp; })
+
+#define DIV_ROUND_DOWN_ULL(ll, d) \
+	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
+
+#define DIV_ROUND_UP_ULL(ll, d)		DIV_ROUND_DOWN_ULL((ll) + (d) - 1, (d))
 
 #if BITS_PER_LONG == 32
 # define DIV_ROUND_UP_SECTOR_T(ll,d) DIV_ROUND_UP_ULL(ll, d)
diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 72b19e62f626..ad3bfb894ee0 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -30,9 +30,6 @@
 
 #include "pcm512x.h"
 
-#define DIV_ROUND_DOWN_ULL(ll, d) \
-	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
-
 #define PCM512x_NUM_SUPPLIES 3
 static const char * const pcm512x_supply_names[PCM512x_NUM_SUPPLIES] = {
 	"AVDD",
-- 
2.7.4
