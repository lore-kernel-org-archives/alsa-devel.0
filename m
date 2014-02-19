From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix sparse warnings for firmware
	loader.
Date: Wed, 19 Feb 2014 11:00:37 +0000
Message-ID: <1392807637-4767-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA002652C5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:00:56 +0100 (CET)
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

Sparse gives us the following warning on sst-firmware.c

  CHECK   sound/soc/intel/sst-firmware.c
sound/soc/intel/sst-firmware.c:39:34: warning: incorrect type in argument 1 (different address spaces)
sound/soc/intel/sst-firmware.c:39:34:    expected void volatile [noderef] <asn:2>*dst
sound/soc/intel/sst-firmware.c:39:34:    got void *
sound/soc/intel/sst-firmware.c:417:36: warning: incorrect type in argument 1 (different address spaces)
sound/soc/intel/sst-firmware.c:417:36:    expected void *dest
sound/soc/intel/sst-firmware.c:417:36:    got void [noderef] <asn:2>*
sound/soc/intel/sst-firmware.c:430:5: warning: symbol 'sst_block_module_remove' was not declared. Should it be static?

This patch removes this warning.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
