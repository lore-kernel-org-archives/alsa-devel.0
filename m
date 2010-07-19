From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/2]ASoC: multi-component - Fix S5P compile
	error
Date: Mon, 19 Jul 2010 21:45:49 +0900
Message-ID: <4C4448FD.5010600@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 028C9103865
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 14:45:53 +0200 (CEST)
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5T0074D24DV6D0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 19 Jul 2010 21:45:49 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5T002WP24DY5@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 19 Jul 2010 21:45:49 +0900 (KST)
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

This patch fix compile error on using I2S and WM8994 common code.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 sound/soc/codecs/Kconfig       |    4 ++--
 sound/soc/s3c24xx/s3c-i2s-v2.c |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ea1f5ed..55bc2be 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -85,8 +85,8 @@ config SND_SOC_ALL_CODECS
 
 config SND_SOC_WM_HUBS
 	tristate
-	default y if SND_SOC_WM8993=y
-	default m if SND_SOC_WM8993=m
+	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
+	default m if SND_SOC_WM8993=m || SND_SOC_WM8994=m
 
 config SND_SOC_AC97_CODEC
 	tristate
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
