From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: s6105-ipcam: Fix build for I2C
	dependencies
Date: Sat,  5 Jul 2014 18:01:26 +0100
Message-ID: <1404579686-8491-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5E4C265532
 for <alsa-devel@alsa-project.org>; Sat,  5 Jul 2014 19:01:40 +0200 (CEST)
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
Cc: linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The s6105-ipcam driver calls i2c_register_board_info() which means that
not only does it need I2C to be enabled to be built but since that
symbol is not exported it means that the driver also can't be linked as
a module.  Use a bool instead of a tristate and add a dependency on I2C
to fix these issues.

Commit b5dd60fd263 (ASoC: s6000: Allow to build when COMPILE_TEST is
enabled) made this problem more visible since it enabled build of the
driver on more common architectures but this has always been an issue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/s6000/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s6000/Kconfig b/sound/soc/s6000/Kconfig
index 4823e1e4daef..f244a2566f20 100644
--- a/sound/soc/s6000/Kconfig
+++ b/sound/soc/s6000/Kconfig
@@ -15,8 +15,9 @@ config SND_S6000_SOC_I2S
 	tristate
 
 config SND_S6000_SOC_S6IPCAM
-	tristate "SoC Audio support for Stretch 6105 IP Camera"
-	depends on SND_S6000_SOC
+	bool "SoC Audio support for Stretch 6105 IP Camera"
+	depends on SND_S6000_SOC=y
+	depends on I2C=y
 	depends on XTENSA_PLATFORM_S6105 || COMPILE_TEST
 	select SND_S6000_SOC_I2S
 	select SND_SOC_TLV320AIC3X
-- 
2.0.0
