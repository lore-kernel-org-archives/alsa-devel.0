From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: codecs: Put the CODEC drivers in a
	menu
Date: Fri,  7 Feb 2014 15:59:29 +0000
Message-ID: <1391788770-31780-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69ADF265319
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 16:59:42 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Now they're visible they get a bit noisy.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 28faa2d0eaef..6b67e86f3f2c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -8,6 +8,8 @@ config SND_SOC_I2C_AND_SPI
 	default y if I2C=y
 	default y if SPI_MASTER=y
 
+menu "CODEC drivers"
+
 config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
 	depends on COMPILE_TEST
@@ -588,3 +590,5 @@ config SND_SOC_ML26124
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
+
+endmenu
-- 
1.9.rc1
