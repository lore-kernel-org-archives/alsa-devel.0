From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] tinycompress: remove usage of
	SNDRV_RATE_xxx
Date: Mon, 16 Dec 2013 20:45:00 +0530
Message-ID: <1387206900-9441-4-git-send-email-vinod.koul@intel.com>
References: <1387206900-9441-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C3CF726168B
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 17:14:20 +0100 (CET)
In-Reply-To: <1387206900-9441-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

as now it is not to be used for passing the sampling rate

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/tinycompress/tinycompress.h |   20 --------------------
 utils.c                             |   34 ----------------------------------
 2 files changed, 0 insertions(+), 54 deletions(-)

diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 40de69a..e340cca 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -269,25 +269,5 @@ int is_compress_ready(struct compress *compress);
 
 /* Returns a human readable reason for the last error */
 const char *compress_get_error(struct compress *compress);
-/*
- * since the SNDRV_PCM_RATE_* is not availble anywhere in userspace
- * and we have used these to define the sampling rate, we need to define
- * then here
- */
-#define SNDRV_PCM_RATE_5512		(1<<0)		/* 5512Hz */
-#define SNDRV_PCM_RATE_8000		(1<<1)		/* 8000Hz */
-#define SNDRV_PCM_RATE_11025		(1<<2)		/* 11025Hz */
-#define SNDRV_PCM_RATE_16000		(1<<3)		/* 16000Hz */
-#define SNDRV_PCM_RATE_22050		(1<<4)		/* 22050Hz */
-#define SNDRV_PCM_RATE_32000		(1<<5)		/* 32000Hz */
-#define SNDRV_PCM_RATE_44100		(1<<6)		/* 44100Hz */
-#define SNDRV_PCM_RATE_48000		(1<<7)		/* 48000Hz */
-#define SNDRV_PCM_RATE_64000		(1<<8)		/* 64000Hz */
-#define SNDRV_PCM_RATE_88200		(1<<9)		/* 88200Hz */
-#define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
-#define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
-#define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
 
-/* utility functions */
-unsigned int compress_get_alsa_rate(unsigned int rate);
 #endif
diff --git a/utils.c b/utils.c
index a835bef..9a0f86a 100644
--- a/utils.c
+++ b/utils.c
@@ -60,37 +60,3 @@
 #define __user
 #include "tinycompress/tinycompress.h"
 
-
-unsigned int compress_get_alsa_rate(unsigned int rate)
-{
-	switch (rate) {
-	case 5512:
-		return SNDRV_PCM_RATE_5512;
-	case 8000:
-		return SNDRV_PCM_RATE_8000;
-	case 11025:
-		return SNDRV_PCM_RATE_11025;
-	case 16000:
-		return SNDRV_PCM_RATE_16000;
-	case 22050:
-		return SNDRV_PCM_RATE_22050;
-	case 32000:
-		return SNDRV_PCM_RATE_32000;
-	case 44100:
-		return SNDRV_PCM_RATE_44100;
-	case 48000:
-		return SNDRV_PCM_RATE_48000;
-	case 64000:
-		return SNDRV_PCM_RATE_64000;
-	case 88200:
-		return SNDRV_PCM_RATE_88200;
-	case 96000:
-		return SNDRV_PCM_RATE_96000;
-	case 176400:
-		return SNDRV_PCM_RATE_176400;
-	case 192000:
-		return SNDRV_PCM_RATE_192000;
-	default:
-		return 0;
-	}
-}
-- 
1.7.0.4
