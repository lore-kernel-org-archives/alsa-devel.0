From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: sst: fix sst_memcpy32 wrong with
	non-4x bytes issue
Date: Mon, 14 Dec 2015 22:27:13 +0800
Message-ID: <1450103233-8304-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 65BD8260484
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 15:20:32 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, yang.jie@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

sst_memcpy32() only copied bytes/4 32bits, which means it dropped
the remaining bytes%4 bytes wrongly.

Here add copying those missing bytes, first to a 32bits tmp, and
then write the tmp to 32bits iomem.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/soc/intel/common/sst-firmware.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
index 60652cb..d745a78 100644
--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -51,8 +51,22 @@ struct sst_dma {
 
 static inline void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 {
+	u32 tmp = 0;
+	int i, m, n;
+	const u8 *src_byte = src;
+
+	m = bytes / 4;
+	n = bytes % 4;
+
 	/* __iowrite32_copy use 32bit size values so divide by 4 */
-	__iowrite32_copy((void *)dest, src, bytes/4);
+	__iowrite32_copy((void *)dest, src, m);
+
+	if (n) {
+		for (i = 0; i < n; i++)
+			tmp |= (u32)*(src_byte + m * 4 + i) << (i * 8);
+		__iowrite32_copy((void *)(dest + m * 4), &tmp, 1);
+	}
+
 }
 
 static void sst_dma_transfer_complete(void *arg)
-- 
2.5.0
