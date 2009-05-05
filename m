From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 02/18] ASoC: Check for supported CPUs when
	building s3c-i2s-v2
Date: Tue,  5 May 2009 11:02:15 +0100
Message-ID: <1241517751-2634-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00CBA24518
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:35 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index ab680aa..3b9201c 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -37,6 +37,20 @@
 
 #include "s3c-i2s-v2.h"
 
+#undef S3C_IIS_V2_SUPPORTED
+
+#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#define S3C_IIS_V2_SUPPORTED
+#endif
+
+#ifdef CONFIG_PLAT_S3C64XX
+#define S3C_IIS_V2_SUPPORTED
+#endif
+
+#ifndef S3C_IIS_V2_SUPPORTED
+#error Unsupported CPU model
+#endif
+
 #define S3C2412_I2S_DEBUG_CON 0
 
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-- 
1.6.2.4
