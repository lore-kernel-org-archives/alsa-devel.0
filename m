From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [PATCH V3 2/4] ASoC: SAMSUNG: Add idma related
	register definition
Date: Mon, 20 Jun 2011 16:36:19 +0900
Message-ID: <1308555381-4419-2-git-send-email-sbkim73@samsung.com>
References: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E39510387C
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:46:24 +0200 (CEST)
In-Reply-To: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, jassisinghbrar@gmail.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch add idma related register definitions to support idma.

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/i2s-regs.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/i2s-regs.h b/sound/soc/samsung/i2s-regs.h
index 1fa0cd1..c0e6d9a 100644
--- a/sound/soc/samsung/i2s-regs.h
+++ b/sound/soc/samsung/i2s-regs.h
@@ -23,6 +23,14 @@
 #define I2SRXD		0x14
 #define I2SFICS		0x18
 #define I2STXDS		0x1c
+#define I2SAHB		0x20
+#define I2SSTR0		0x24
+#define I2SSIZE		0x28
+#define I2STRNCNT	0x2c
+#define I2SLVL0ADDR	0x30
+#define I2SLVL1ADDR	0x34
+#define I2SLVL2ADDR	0x38
+#define I2SLVL3ADDR	0x3c
 
 #define CON_RSTCLR		(1 << 31)
 #define CON_FRXOFSTATUS		(1 << 26)
@@ -114,10 +122,22 @@
 
 #define FIC_TXFLUSH		(1 << 15)
 #define FIC_RXFLUSH		(1 << 7)
+
 #define FIC_TXCOUNT(x)		(((x) >>  8) & 0xf)
 #define FIC_RXCOUNT(x)		(((x) >>  0) & 0xf)
 #define FICS_TXCOUNT(x)		(((x) >>  8) & 0x7f)
 
+#define AHB_INTENLVL0		(1 << 24)
+#define AHB_LVL0INT		(1 << 20)
+#define AHB_CLRLVL0INT		(1 << 16)
+#define AHB_DMARLD		(1 << 5)
+#define AHB_INTMASK		(1 << 3)
+#define AHB_DMAEN		(1 << 0)
+#define AHB_LVLINTMASK		(0xf << 20)
+
+#define I2SSIZE_TRNMSK		(0xffff)
+#define I2SSIZE_SHIFT		(16)
+
 #endif /* __SND_SOC_SAMSUNG_I2S_REGS_H */
 
 
-- 
1.7.1
