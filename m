From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 6/6] ASoC: Intel: Atom: fix inversion between
	__iowrite32 and __ioread32
Date: Tue, 24 Jul 2018 16:12:48 -0500
Message-ID: <20180724211248.29427-7-pierre-louis.bossart@linux.intel.com>
References: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 06B052676D4
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 23:13:01 +0200 (CEST)
In-Reply-To: <20180724211248.29427-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This looks like a copy/paste issue, but clearly there is an inversion
that is obvious when checking the arguments.

Detected with Sparse - now that we have fewer warnings this one was
easy to find.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index a686eef2cf7f..27413ebae956 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -44,15 +44,15 @@ void memcpy32_toio(void __iomem *dst, const void *src, int count)
 	/* __iowrite32_copy uses 32-bit count values so divide by 4 for
 	 * right count in words
 	 */
-	__iowrite32_copy(dst, src, count/4);
+	__iowrite32_copy(dst, src, count / 4);
 }
 
 void memcpy32_fromio(void *dst, const void __iomem *src, int count)
 {
-	/* __iowrite32_copy uses 32-bit count values so divide by 4 for
+	/* __ioread32_copy uses 32-bit count values so divide by 4 for
 	 * right count in words
 	 */
-	__iowrite32_copy(dst, src, count/4);
+	__ioread32_copy(dst, src, count / 4);
 }
 
 /**
-- 
2.14.1
