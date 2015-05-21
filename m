From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: qcom: remove incorrect dependencies
Date: Thu, 21 May 2015 11:07:08 +0200
Message-ID: <2324031.cqS0mEEEhQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, Kenneth Westfield <kwestfie@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Compile-tests show a warning for the newly added SND_SOC_STORM
symbol:

warning: (SND_SOC_STORM) selects SND_SOC_LPASS_CPU which has unmet direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC && SND_SOC_QCOM)

The problem is that it can be selected for COMPILE_TEST on non-QCOM
builds, but the symbols it selects have a dependency.
Dropping the dependencies makes it work without warnings and no
other side-effects, because these are not user-visible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f380dd3f3cd ("ASoC: qcom: Add ability to build QCOM drivers")

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5f58e4f1bca9..b07f183fc47f 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -6,12 +6,10 @@ config SND_SOC_QCOM
 
 config SND_SOC_LPASS_CPU
 	tristate
-	depends on SND_SOC_QCOM
 	select REGMAP_MMIO
 
 config SND_SOC_LPASS_PLATFORM
 	tristate
-	depends on SND_SOC_QCOM
 	select REGMAP_MMIO
 
 config SND_SOC_STORM
