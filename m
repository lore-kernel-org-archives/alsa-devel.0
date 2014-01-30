From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] ASoC: Samsung: Remove invalid dependencies
Date: Thu, 30 Jan 2014 11:58:27 +0530
Message-ID: <1391063308-11745-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f44.google.com (mail-pb0-f44.google.com
 [209.85.160.44])
 by alsa0.perex.cz (Postfix) with ESMTP id C6A8B26530C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 07:33:15 +0100 (CET)
Received: by mail-pb0-f44.google.com with SMTP id rq2so2749123pbb.17
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 22:33:14 -0800 (PST)
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

These symbols got eliminated when non-DT support for Exynos was
removed. Remove them.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 1f369c69469c..c006d4aafd5a 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -145,7 +145,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 
 config SND_SOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
-- 
1.7.9.5
