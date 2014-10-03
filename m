From: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Subject: [PATCH v4 3/4] ARM: imx_v6_v7_defconfig: enable tlv320aic3x audio codec by default
Date: Fri, 3 Oct 2014 16:18:55 +0300
Message-ID: <1412342336-25700-4-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412342336-25700-1-git-send-email-d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Used on Phytec PBAB01 board.

Signed-off-by: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8fca6e276b69..cac07d67b933 100644
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
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
