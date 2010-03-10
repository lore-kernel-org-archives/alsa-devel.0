From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 12/20] ASoC: S3C2412: I2S: Debug IMS field
Date: Wed, 10 Mar 2010 16:49:01 +0900
Message-ID: <1268207349-9979-12-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F033103842
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 09:23:01 +0100 (CET)
In-Reply-To: <1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
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

The IMS field of s3c2412/13 is essentially the same as that of s3c64xx.
That is, the IISMOD[11] bit decides Master/Slave mode and IISMOD[10] bit
selects source clock for signal generation.
For that reason, remove improper defines for IISMOD[11:10] field mask
and define two 1bit fields that can be set independent of each other.
As a consequence, corresponding fields for PLAT_S3C64XX too get to use
these new defines.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/regs-i2s-v2.h |    6 ++----
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   25 ++-----------------------
 sound/soc/s3c24xx/s3c2412-i2s.c |    8 ++------
 3 files changed, 6 insertions(+), 33 deletions(-)

diff --git a/sound/soc/s3c24xx/regs-i2s-v2.h b/sound/soc/s3c24xx/regs-i2s-v2.h
index dea199e..f612468 100644
--- a/sound/soc/s3c24xx/regs-i2s-v2.h
+++ b/sound/soc/s3c24xx/regs-i2s-v2.h
@@ -76,10 +76,8 @@
 #define S3C64XX_IISMOD_IMS_PCLK		(0 << 10)
 #define S3C64XX_IISMOD_IMS_SYSMUX	(1 << 10)
 
-#define S3C2412_IISMOD_MASTER_INTERNAL	(0 << 10)
-#define S3C2412_IISMOD_MASTER_EXTERNAL	(1 << 10)
-#define S3C2412_IISMOD_SLAVE		(2 << 10)
-#define S3C2412_IISMOD_MASTER_MASK	(3 << 10)
+#define S3C2412_IISMOD_IMS_SYSMUX	(1 << 10)
+#define S3C2412_IISMOD_SLAVE		(1 << 11)
 #define S3C2412_IISMOD_MODE_TXONLY	(0 << 8)
 #define S3C2412_IISMOD_MODE_RXONLY	(1 << 8)
 #define S3C2412_IISMOD_MODE_TXRX	(2 << 8)
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index b690078..1b29b4b 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -251,35 +251,14 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	iismod = readl(i2s->regs + S3C2412_IISMOD);
 	pr_debug("hw_params r: IISMOD: %x \n", iismod);
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
-#define IISMOD_MASTER_MASK S3C2412_IISMOD_MASTER_MASK
-#define IISMOD_SLAVE S3C2412_IISMOD_SLAVE
-#define IISMOD_MASTER S3C2412_IISMOD_MASTER_INTERNAL
-#endif
-
-#if defined(CONFIG_PLAT_S3C64XX)
-/* From Rev1.1 datasheet, we have two master and two slave modes:
- * IMS[11:10]:
- *	00 = master mode, fed from PCLK
- *	01 = master mode, fed from CLKAUDIO
- *	10 = slave mode, using PCLK
- *	11 = slave mode, using I2SCLK
- */
-#define IISMOD_MASTER_MASK (1 << 11)
-#define IISMOD_SLAVE (1 << 11)
-#define IISMOD_MASTER (0 << 11)
-#endif
-
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
 		i2s->master = 0;
-		iismod &= ~IISMOD_MASTER_MASK;
-		iismod |= IISMOD_SLAVE;
+		iismod |= S3C2412_IISMOD_SLAVE;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		i2s->master = 1;
-		iismod &= ~IISMOD_MASTER_MASK;
-		iismod |= IISMOD_MASTER;
+		iismod &= ~S3C2412_IISMOD_SLAVE;
 		break;
 	default:
 		pr_err("unknwon master/slave format\n");
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 42fb663..e6871f7 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -78,14 +78,10 @@ static int s3c2412_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
 
 	switch (clk_id) {
 	case S3C2412_CLKSRC_PCLK:
-		s3c2412_i2s.master = 1;
-		iismod &= ~S3C2412_IISMOD_MASTER_MASK;
-		iismod |= S3C2412_IISMOD_MASTER_INTERNAL;
+		iismod &= ~S3C2412_IISMOD_IMS_SYSMUX;
 		break;
 	case S3C2412_CLKSRC_I2SCLK:
-		s3c2412_i2s.master = 0;
-		iismod &= ~S3C2412_IISMOD_MASTER_MASK;
-		iismod |= S3C2412_IISMOD_MASTER_EXTERNAL;
+		iismod |= S3C2412_IISMOD_IMS_SYSMUX;
 		break;
 	default:
 		return -EINVAL;
-- 
1.6.2.5
