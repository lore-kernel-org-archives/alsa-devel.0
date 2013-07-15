From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/3] ASoC: kirkwood: Enable build on
	non-Kirkwood platforms
Date: Mon, 15 Jul 2013 16:42:49 +0100
Message-ID: <1373902970-935-2-git-send-email-broonie@kernel.org>
References: <1373902970-935-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 956FF261661
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 17:43:00 +0200 (CEST)
In-Reply-To: <1373902970-935-1-git-send-email-broonie@kernel.org>
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

Improve build coverage by enabling build on other platforms if COMPILE_TEST
is enabled.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/kirkwood/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index c62d715..59085ad 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood chip"
-	depends on ARCH_KIRKWOOD
+	depends on ARCH_KIRKWOOD || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
@@ -11,7 +11,7 @@ config SND_KIRKWOOD_SOC_I2S
 
 config SND_KIRKWOOD_SOC_OPENRD
 	tristate "SoC Audio support for Kirkwood Openrd Client"
-	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE)
+	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE || COMPILE_TEST)
 	depends on I2C
 	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_CS42L51
@@ -21,7 +21,7 @@ config SND_KIRKWOOD_SOC_OPENRD
 
 config SND_KIRKWOOD_SOC_T5325
 	tristate "SoC Audio support for HP t5325"
-	depends on SND_KIRKWOOD_SOC && MACH_T5325 && I2C
+	depends on SND_KIRKWOOD_SOC && (MACH_T5325 || COMPILE_TEST) && I2C
 	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_ALC5623
 	help
-- 
1.8.3.2
