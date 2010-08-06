From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Document CFG switch settings for
	SMDK6410 WM8580 usage
Date: Fri,  6 Aug 2010 18:35:31 +0100
Message-ID: <1281116132-25432-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1281116132-25432-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED666103985
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 19:35:33 +0200 (CEST)
In-Reply-To: <1281116132-25432-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Sadly these aren't soft controllable and can't be read back either :(

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 5853f66..4926aca 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -22,6 +22,12 @@
 #include "s3c-dma.h"
 #include "s3c64xx-i2s.h"
 
+/*
+ * Default CFG switch settings to use this driver:
+ *
+ *   SMDK6410: Set CFG1 1-3 Off, CFG2 1-4 On
+ */
+
 /* SMDK64XX has a 12MHZ crystal attached to WM8580 */
 #define SMDK64XX_WM8580_FREQ 12000000
 
-- 
1.7.1
