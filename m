From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Subject: [PATCH v6 3/3] ARM: imx_v6_v7_defconfig: enable tlv320aic3x audio codec by default
Date: Tue, 4 Nov 2014 16:05:49 +0300
Message-ID: <1415106349-18846-4-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1415106349-18846-1-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415106349-18846-1-git-send-email-d.lavnikevich@sam-solutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shawn.guo@linaro.org, shawn.guo@freescale.com, kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
List-Id: alsa-devel@alsa-project.org

Used on Phytec PBAB01 board.

Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8fca6e2..cac07d6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -210,6 +210,7 @@ CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
 CONFIG_SND_SOC_IMX_MC13783=y
+CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.1.2
