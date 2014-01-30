From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ASoC: Samsung: Fix trivial typo
Date: Thu, 30 Jan 2014 11:58:28 +0530
Message-ID: <1391063308-11745-2-git-send-email-sachin.kamat@linaro.org>
References: <1391063308-11745-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A45F26530D
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 07:33:17 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id rd3so2755449pab.33
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 22:33:17 -0800 (PST)
In-Reply-To: <1391063308-11745-1-git-send-email-sachin.kamat@linaro.org>
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

Changed Sat -> Say.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index c006d4aafd5a..658e3de3f822 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -59,7 +59,7 @@ config SND_SOC_SAMSUNG_JIVE_WM8750
 	select SND_SOC_WM8750
 	select SND_S3C2412_SOC_I2S
 	help
-	  Sat Y if you want to add support for SoC audio on the Jive.
+	  Say Y if you want to add support for SoC audio on the Jive.
 
 config SND_SOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
@@ -149,7 +149,7 @@ config SND_SOC_SAMSUNG_SMDK_WM9713
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
-	  Sat Y if you want to add support for SoC audio on the SMDK.
+	  Say Y if you want to add support for SoC audio on the SMDK.
 
 config SND_SOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
-- 
1.7.9.5
