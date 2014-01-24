From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] ASoC: Samsung: Fix build error due to
	missing dependency
Date: Fri, 24 Jan 2014 14:09:25 +0530
Message-ID: <1390552765-32210-2-git-send-email-sachin.kamat@linaro.org>
References: <1390552765-32210-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 00CC6261687
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 09:44:07 +0100 (CET)
Received: by mail-pb0-f53.google.com with SMTP id md12so2979512pbc.40
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 00:44:07 -0800 (PST)
In-Reply-To: <1390552765-32210-1-git-send-email-sachin.kamat@linaro.org>
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
Cc: patches@linaro.org, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, sachin.kamat@linaro.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Depend on MFD_ARIZONA to avoid the following build errors:

sound/soc/codecs/arizona.c:218: undefined reference to `arizona_request_irq'
sound/soc/codecs/arizona.c:226: undefined reference to `arizona_request_irq'
sound/soc/codecs/arizona.c:1719: undefined reference to `arizona_request_irq'

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/samsung/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index e8fbf4e5732f..454f41cfc828 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -210,7 +210,7 @@ config SND_SOC_TOBERMORY
 
 config SND_SOC_BELLS
 	tristate "Audio support for Wolfson Bells"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && MFD_ARIZONA
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5102
 	select SND_SOC_WM5110
-- 
1.7.9.5
