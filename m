From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 8/8] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig
 symbol
Date: Fri, 20 Apr 2018 15:28:34 +0200
Message-ID: <1524230914-10175-9-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "David S . Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Kconfig symbol for Renesas 64-bit ARM SoCs has always been
ARCH_RENESAS, with ARCH_SHMOBILE being selected to reuse drivers shared
with Renesas 32-bit ARM and/or Renesas SuperH SH-Mobile SoCs.

Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
32-bit SoCs.  Now all drivers for Renesas ARM SoCs have gained proper
ARCH_RENESAS platform dependencies, there is no longer a need to select
ARCH_SHMOBILE.

With ARCH_SHMOBILE gone, move the ARCH_RENESAS section up, to restore
alphabetical sort order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on the driver patches in this series, hence the RFC.

JFTR, after this, the following symbols for drivers supporting only
Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
  - CONFIG_KEYBOARD_SH_KEYSC,
  - CONFIG_VIDEO_SH_VOU,
  - CONFIG_VIDEO_RENESAS_CEU,
  - CONFIG_FB_SH_MOBILE_MERAM.
(changes for a renesas_defconfig .config)
---
 arch/arm64/Kconfig.platforms | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac351fc3a776..49d8ed1ab84766dd 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -145,31 +145,8 @@ config ARCH_REALTEK
 	  This enables support for the ARMv8 based Realtek chipsets,
 	  like the RTD1295.
 
-config ARCH_ROCKCHIP
-	bool "Rockchip Platforms"
-	select ARCH_HAS_RESET_CONTROLLER
-	select GPIOLIB
-	select PINCTRL
-	select PINCTRL_ROCKCHIP
-	select ROCKCHIP_TIMER
-	help
-	  This enables support for the ARMv8 based Rockchip chipsets,
-	  like the RK3368.
-
-config ARCH_SEATTLE
-	bool "AMD Seattle SoC Family"
-	help
-	  This enables support for AMD Seattle SOC Family
-
-config ARCH_SHMOBILE
-	bool
-
-config ARCH_SYNQUACER
-	bool "Socionext SynQuacer SoC Family"
-
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
-	select ARCH_SHMOBILE
 	select PINCTRL
 	select PM
 	select PM_GENERIC_DOMAINS
@@ -220,6 +197,25 @@ config ARCH_R8A77995
 	help
 	  This enables support for the Renesas R-Car D3 SoC.
 
+config ARCH_ROCKCHIP
+	bool "Rockchip Platforms"
+	select ARCH_HAS_RESET_CONTROLLER
+	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_ROCKCHIP
+	select ROCKCHIP_TIMER
+	help
+	  This enables support for the ARMv8 based Rockchip chipsets,
+	  like the RK3368.
+
+config ARCH_SEATTLE
+	bool "AMD Seattle SoC Family"
+	help
+	  This enables support for AMD Seattle SOC Family
+
+config ARCH_SYNQUACER
+	bool "Socionext SynQuacer SoC Family"
+
 config ARCH_STRATIX10
 	bool "Altera's Stratix 10 SoCFPGA Family"
 	help
-- 
2.7.4
