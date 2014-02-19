From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCHv2] ASoC: Intel: Fix sparse warnings for
	firmware loader.
Date: Wed, 19 Feb 2014 14:06:23 +0000
Message-ID: <1392818784-6248-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id DE7EB2652CD
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 15:07:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Changes since V1 :-
 o Fixed sparse warning for block_module_remove
 o Fixed additional sparse warnings when building entire driver. 

Sparse gives us the following warnings on sst-firmware.c

  CHECK   sound/soc/intel/sst-firmware.c
sound/soc/intel/sst-firmware.c:39:34: warning: incorrect type in argument 1 (different address spaces)
sound/soc/intel/sst-firmware.c:39:34:    expected void volatile [noderef] <asn:2>*dst
sound/soc/intel/sst-firmware.c:39:34:    got void *
sound/soc/intel/sst-firmware.c:417:36: warning: incorrect type in argument 1 (different address spaces)
sound/soc/intel/sst-firmware.c:417:36:    expected void *dest
sound/soc/intel/sst-firmware.c:417:36:    got void [noderef] <asn:2>*
sound/soc/intel/sst-firmware.c:430:5: warning: symbol 'sst_block_module_remove' was not declared. Should it be static?

and

  CC [M]  sound/soc/intel/sst-dsp.o
sound/soc/intel/sst-dsp-priv.h:271:53: warning: incorrect type in argument 3 (different address spaces)
sound/soc/intel/sst-dsp-priv.h:271:53:    expected void *src
sound/soc/intel/sst-dsp-priv.h:271:53:    got void [noderef] <asn:2>*
sound/soc/intel/sst-dsp-priv.h:271:53: warning: incorrect type in argument 3 (different address spaces)
sound/soc/intel/sst-dsp-priv.h:271:53:    expected void *src
sound/soc/intel/sst-dsp-priv.h:271:53:    got void [noderef] <asn:2>*
sound/soc/intel/sst-dsp-priv.h:271:53: warning: incorrect type in argument 3 (different address spaces)
sound/soc/intel/sst-dsp-priv.h:271:53:    expected void *src
sound/soc/intel/sst-dsp-priv.h:271:53:    got void [noderef] <asn:2>*


This patch removes these warnings

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-dsp-priv.h | 7 +++++--
 sound/soc/intel/sst-firmware.c | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/sst-dsp-priv.h b/sound/soc/intel/sst-dsp-priv.h
index 6135564..fe8e81a 100644
--- a/sound/soc/intel/sst-dsp-priv.h
+++ b/sound/soc/intel/sst-dsp-priv.h
@@ -41,8 +41,10 @@ struct sst_ops {
 	u64 (*read64)(void __iomem *addr, u32 offset);
 
 	/* DSP I/DRAM IO */
-	void (*ram_read)(struct sst_dsp *sst, void *dest, void *src, size_t bytes);
-	void (*ram_write)(struct sst_dsp *sst, void *dest, void *src, size_t bytes);
+	void (*ram_read)(struct sst_dsp *sst, void  *dest, void __iomem *src,
+		size_t bytes);
+	void (*ram_write)(struct sst_dsp *sst, void __iomem *dest, void *src,
+		size_t bytes);
 
 	void (*dump)(struct sst_dsp *);
 
@@ -296,6 +298,7 @@ struct sst_module *sst_module_get_from_id(struct sst_dsp *dsp, u32 id);
 struct sst_module *sst_mem_block_alloc_scratch(struct sst_dsp *dsp);
 void sst_mem_block_free_scratch(struct sst_dsp *dsp,
 	struct sst_module *scratch);
+int sst_block_module_remove(struct sst_module *module);
 
 /* Register the DSPs memory blocks - would be nice to read from ACPI */
 struct sst_mem_block *sst_mem_block_register(struct sst_dsp *dsp, u32 offset,
diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 31cd154..dee7eb5 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -30,7 +30,7 @@
 #include "sst-dsp.h"
 #include "sst-dsp-priv.h"
 
-static void sst_memcpy32(void *dest, void *src, u32 bytes)
+static void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 {
 	u32 i;
 
-- 
1.8.3.2
