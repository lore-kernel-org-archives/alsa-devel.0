From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: core: Remove dependencies on
	GENERIC_HARDIRQS
Date: Fri,  6 Sep 2013 11:55:47 +0100
Message-ID: <1378464947-4260-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E61026086E
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2013 12:56:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

All architectures now use the generic IRQ subsystem so this is redundant.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/Kconfig  | 2 +-
 sound/soc/samsung/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 15106c0..b33b45d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -107,7 +107,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM8782
 	select SND_SOC_WM8804 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_WM8900 if I2C
-	select SND_SOC_WM8903 if I2C && GENERIC_HARDIRQS
+	select SND_SOC_WM8903 if I2C
 	select SND_SOC_WM8904 if I2C
 	select SND_SOC_WM8940 if I2C
 	select SND_SOC_WM8955 if I2C
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 1b0cccd..d446c6b 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -63,7 +63,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
 	depends on SND_SOC_SAMSUNG
-	depends on I2C=y && GENERIC_HARDIRQS
+	depends on I2C=y
 	select MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
-- 
1.8.4.rc3
