From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/4] ASoC: Intel: remove duplicate headers
Date: Mon, 26 May 2014 16:56:31 +0300
Message-ID: <1401112593-2852-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1401112593-2852-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0812E26518B
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:56:47 +0200 (CEST)
In-Reply-To: <1401112593-2852-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A few files contain duplicate headers. This patch removes the second entry of
duplicate in each file under question.

There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
Resending this as Mark wasn't cc'ed in original patch and patch and my ack
got probably buried.
---
 sound/soc/intel/sst-baytrail-ipc.c | 1 -
 sound/soc/intel/sst-haswell-ipc.c  | 1 -
 sound/soc/intel/sst-haswell-pcm.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 7c1ec003d55d..208e69561d78 100644
--- a/sound/soc/intel/sst-baytrail-ipc.c
+++ b/sound/soc/intel/sst-baytrail-ipc.c
@@ -22,7 +22,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/kthread.h>
 #include <linux/firmware.h>
diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index e7996b39a484..2dfd0707b00c 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
-#include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/kthread.h>
 #include <linux/firmware.h>
diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 9d5f64a583a3..c53cd5772d58 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <linux/module.h>
 #include <linux/delay.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-- 
2.0.0.rc2
