From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] S3C: Fix S3C2412_IISMOD_SDF_{MSB,
	LSB} definitions
Date: Mon,  9 Mar 2009 17:47:13 +0000
Message-ID: <1236620833-27171-1-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id B6BAD1037F4
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 18:49:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, openmoko-kernel@lists.openmoko.org
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

The definitions of S3C2412_IISMOD_SDF_MSB and S3C2412_IISMOD_SDF_LSB
are incorrect, being the same S3C2412_IISMOD_SDF_IIS which is the
only correct one in this series.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
index 25d4058..e5988b4 100644
--- a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
+++ b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
@@ -44,8 +44,8 @@
 #define S3C2412_IISMOD_LR_LLOW		(0 << 7)
 #define S3C2412_IISMOD_LR_RLOW		(1 << 7)
 #define S3C2412_IISMOD_SDF_IIS		(0 << 5)
-#define S3C2412_IISMOD_SDF_MSB		(0 << 5)
-#define S3C2412_IISMOD_SDF_LSB		(0 << 5)
+#define S3C2412_IISMOD_SDF_MSB		(1 << 5)
+#define S3C2412_IISMOD_SDF_LSB		(2 << 5)
 #define S3C2412_IISMOD_SDF_MASK		(3 << 5)
 #define S3C2412_IISMOD_RCLK_256FS	(0 << 3)
 #define S3C2412_IISMOD_RCLK_512FS	(1 << 3)
-- 
1.5.6.5
