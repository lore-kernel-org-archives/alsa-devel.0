From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ASoC: Intel: remove duplicate headers
Date: Tue, 13 May 2014 11:29:15 +0300
Message-ID: <1399969755-15976-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3924F265451
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 10:29:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

A few files contain duplicate headers. This patch removes the second entry of
duplicate in each file under question.

There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-ipc.c | 1 -
 sound/soc/intel/sst-haswell-ipc.c  | 1 -
 sound/soc/intel/sst-haswell-pcm.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-ipc.c b/sound/soc/intel/sst-baytrail-ipc.c
index 0d31dbb..a9c58cd 100644
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
index e7996b3..2dfd070 100644
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
index ce27b50..058efb1 100644
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
