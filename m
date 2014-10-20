From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/5] ASoC: intel: use __iowrite32_copy for 32
	bit copy
Date: Mon, 20 Oct 2014 15:29:08 +0530
Message-ID: <1413799148-6368-6-git-send-email-vinod.koul@intel.com>
References: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EA8CD2606C0
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 12:36:22 +0200 (CEST)
In-Reply-To: <1413799148-6368-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The sst-firmware was also using own method to do 32bit copy, turns out we have a
kernel API so use that instead

[For BYT]
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-firmware.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 3bb43da..44090ac 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -34,11 +34,8 @@ static void block_module_remove(struct sst_module *module);
 
 static void sst_memcpy32(volatile void __iomem *dest, void *src, u32 bytes)
 {
-	u32 i;
-
-	/* copy one 32 bit word at a time as 64 bit access is not supported */
-	for (i = 0; i < bytes; i += 4)
-		memcpy_toio(dest + i, src + i, 4);
+	/* __iowrite32_copy use 32bit size values so divide by 4 */
+	__iowrite32_copy(dest, src, bytes/4);
 }
 
 /* create new generic firmware object */
-- 
1.7.0.4
