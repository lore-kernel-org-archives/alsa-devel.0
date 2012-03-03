From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 07/20] ASoC: imx: move SND_SOC_AC97_BUS selection down to
 machine driver
Date: Sat,  3 Mar 2012 23:19:48 +0800
Message-ID: <1330788001-10158-8-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

SND_SOC_AC97_BUS is selected to enable the AC97 support in soc-core.
Rather than selecting the option under SND_IMX_SOC, it's better to
leave the selection to individual machine driver which knows if AC97
support is needed or not.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 4025eee..d3b7166 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,7 +1,6 @@
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
-	select SND_SOC_AC97_BUS
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the i.MX SSI interface.
@@ -43,6 +42,7 @@ config SND_SOC_MX27VIS_AIC32X4
 config SND_SOC_PHYCORE_AC97
 	tristate "SoC Audio support for Phytec phyCORE (and phyCARD) boards"
 	depends on MACH_PCM043 || MACH_PCA100
+	select SND_SOC_AC97_BUS
 	select SND_SOC_WM9712
 	select SND_MXC_SOC_FIQ
 	select SND_SOC_IMX_AUDMUX
-- 
1.7.5.4
