From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/3] ASoC: multi-component - Support Samsung
	SoC(S5P) in I2Sv2
Date: Tue, 20 Jul 2010 14:28:30 +0900
Message-ID: <4C4533FE.3070009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D6252450D
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 07:28:34 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5U0052SCJJ2UB0@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 20 Jul 2010 14:28:31 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5U00MANCJJMY@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 20 Jul 2010 14:28:31 +0900 (KST)
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
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch modify I2Sv2 driver to support Samsung SoC(S5PV210).

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 6575410..f4fbc0e 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -32,7 +32,8 @@
 
 #undef S3C_IIS_V2_SUPPORTED
 
-#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
+#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413) \
+	|| defined(CONFIG_CPU_S5PV210)
 #define S3C_IIS_V2_SUPPORTED
 #endif
 
-- 
1.6.3.3
