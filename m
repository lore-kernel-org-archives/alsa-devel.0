From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 2/2] ASoC: soc-compress: split soc-compress
	to a module
Date: Mon, 15 Jun 2015 11:20:45 +0800
Message-ID: <1434338445-31992-2-git-send-email-yang.jie@intel.com>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 145BE26067A
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 05:16:29 +0200 (CEST)
In-Reply-To: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: ramesh.babu@linux.intel.com, alsa-devel@alsa-project.org, vivian.zhang@intel.com, vinod.koul@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Split soc-compress into a separate module so we only compile/load
it when it's needed.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/Makefile       | 4 +++-
 sound/soc/soc-compress.c | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 184c1e6..2936088 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,7 +1,9 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
 snd-soc-core-objs += soc-pcm.o soc-io.o soc-devres.o soc-ops.o
 snd-soc-core-objs += soc-topology.o
-snd-soc-core-$(CONFIG_SND_SOC_COMPRESS) += soc-compress.o
+snd-soc-compress-objs := soc-compress.o
+
+obj-$(CONFIG_SND_SOC_COMPRESS) += snd-soc-compress.o
 
 ifneq ($(CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM),)
 snd-soc-core-objs += soc-generic-dmaengine-pcm.o
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 025c38f..a93ac8a 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/module.h>
 #include <sound/core.h>
 #include <sound/compress_params.h>
 #include <sound/compress_driver.h>
@@ -703,3 +704,10 @@ compr_err:
 	kfree(compr);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(soc_new_compress);
+
+/* Module information */
+MODULE_AUTHOR("Ramesh Babu K V <ramesh.babu@linux.intel.com>");
+MODULE_AUTHOR("Vinod Koul <vinod.koul@linux.intel.com>");
+MODULE_DESCRIPTION("ALSA SoC Compress");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
