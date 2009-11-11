From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 3/7] S3C64XX PCM: Define PCM Controller base
	registers
Date: Wed, 11 Nov 2009 13:45:09 +0900
Message-ID: <1257914709-4447-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id D190110380E
	for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2009 05:50:04 +0100 (CET)
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

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c6400/include/mach/map.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index fc8b223..866be31 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -48,6 +48,8 @@
 #define S3C64XX_PA_IIS1		(0x7F003000)
 #define S3C64XX_PA_TIMER	(0x7F006000)
 #define S3C64XX_PA_IIC0		(0x7F004000)
+#define S3C64XX_PA_PCM0		(0x7F009000)
+#define S3C64XX_PA_PCM1		(0x7F00A000)
 #define S3C64XX_PA_IISV4	(0x7F00D000)
 #define S3C64XX_PA_IIC1		(0x7F00F000)
 
-- 
1.6.2.5
