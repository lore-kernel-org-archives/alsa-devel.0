From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] ASoC: Samsung: Disable build on
	multiplatform
Date: Fri, 24 Jan 2014 16:23:24 +0530
Message-ID: <1390560804-31135-3-git-send-email-sachin.kamat@linaro.org>
References: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3624D261693
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 11:58:04 +0100 (CET)
Received: by mail-pa0-f51.google.com with SMTP id ld10so3156353pab.10
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 02:58:03 -0800 (PST)
In-Reply-To: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: sbkim73@samsung.com, sachin.kamat@linaro.org, broonie@kernel.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Samsung sound drivers use mach/dma.h which is not available
on multiplatform. Hence disable audio support on multiplatform
build for now. Without this patch we get the following build errors:

sound/soc/samsung/pcm.c:23:22: fatal error: mach/dma.h: No such file or directory
 #include <mach/dma.h>
sound/soc/samsung/spdif.c:21:22: fatal error: mach/dma.h: No such file or directory
 #include <mach/dma.h>

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index e8fbf4e5732f..3a031af5febd 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -170,7 +170,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 
 config SND_SOC_SAMSUNG_SMDK_SPDIF
 	tristate "SoC S/PDIF Audio support for SMDK"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && !ARCH_MULTIPLATFORM
 	select SND_SAMSUNG_SPDIF
 	help
 	  Say Y if you want to add support for SoC S/PDIF audio on the SMDK.
@@ -185,7 +185,7 @@ config SND_SOC_SMDK_WM8580_PCM
 
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
-	depends on SND_SOC_SAMSUNG
+	depends on SND_SOC_SAMSUNG && !ARCH_MULTIPLATFORM
 	depends on I2C=y
 	select MFD_WM8994
 	select SND_SOC_WM8994
-- 
1.7.9.5
