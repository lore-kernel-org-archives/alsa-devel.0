From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 8/9] mfd: arizona: Add support for new fratio
	encoding
Date: Fri,  7 Mar 2014 16:34:24 +0000
Message-ID: <1394210065-23941-9-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF91D2659FD
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:42:56 +0100 (CET)
In-Reply-To: <1394210065-23941-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Newer IP has an expanded encoding for the fratio bits. As the additional
used bits are unused on older IP simply expand the field to the new
size.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/linux/mfd/arizona/registers.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mfd/arizona/registers.h b/include/linux/mfd/arizona/registers.h
index fdf3aa3..3ddaa63 100644
--- a/include/linux/mfd/arizona/registers.h
+++ b/include/linux/mfd/arizona/registers.h
@@ -1702,9 +1702,9 @@
 /*
  * R373 (0x175) - FLL1 Control 5
  */
-#define ARIZONA_FLL1_FRATIO_MASK                 0x0700  /* FLL1_FRATIO - [10:8] */
-#define ARIZONA_FLL1_FRATIO_SHIFT                     8  /* FLL1_FRATIO - [10:8] */
-#define ARIZONA_FLL1_FRATIO_WIDTH                     3  /* FLL1_FRATIO - [10:8] */
+#define ARIZONA_FLL1_FRATIO_MASK                 0x0F00  /* FLL1_FRATIO - [11:8] */
+#define ARIZONA_FLL1_FRATIO_SHIFT                     8  /* FLL1_FRATIO - [11:8] */
+#define ARIZONA_FLL1_FRATIO_WIDTH                     4  /* FLL1_FRATIO - [11:8] */
 #define ARIZONA_FLL1_OUTDIV_MASK                 0x000E  /* FLL1_OUTDIV - [3:1] */
 #define ARIZONA_FLL1_OUTDIV_SHIFT                     1  /* FLL1_OUTDIV - [3:1] */
 #define ARIZONA_FLL1_OUTDIV_WIDTH                     3  /* FLL1_OUTDIV - [3:1] */
-- 
1.7.2.5
