From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 04/20] ASoC: S3C: I2Sv2: Remove
	S3C_IIS_V2_SUPPORTED define
Date: Wed, 10 Mar 2010 16:48:53 +0900
Message-ID: <1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 88A552432F
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 08:58:03 +0100 (CET)
In-Reply-To: <1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

The code in s3c-i2s-v2.c is compiled via Makefile and not implicitly
by include'ing. Also, the driver developer anyways has to refer to the
manual to see if the code can be reused for the SoC under consideration.
That makes the S3C_IIS_V2_SUPPORTED retrospective rather than a check.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index b01f50e..2812b41 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -37,20 +37,6 @@
 #include "s3c-i2s-v2.h"
 #include "s3c-dma.h"
 
-#undef S3C_IIS_V2_SUPPORTED
-
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
-#define S3C_IIS_V2_SUPPORTED
-#endif
-
-#ifdef CONFIG_PLAT_S3C64XX
-#define S3C_IIS_V2_SUPPORTED
-#endif
-
-#ifndef S3C_IIS_V2_SUPPORTED
-#error Unsupported CPU model
-#endif
-
 #define S3C2412_I2S_DEBUG_CON 0
 
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-- 
1.6.2.5
