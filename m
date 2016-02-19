From: Carlos Palminha <CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 4/4] ARC: axs10x: Update defconfigs so that I2S is enabled
Date: Fri, 19 Feb 2016 09:40:18 +0000
Message-ID: <cf8d0dab3658c2f7641a69809ba409f93ce43f9c.1455872448.git.palminha@synopsys.com>
References: <cover.1455872448.git.palminha@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1455872448.git.palminha-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>

The defconfigs for the AXS boards were updated to
enable Designware I2S driver.

Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 arch/arc/configs/axs101_defconfig     | 1 +
 arch/arc/configs/axs103_defconfig     | 1 +
 arch/arc/configs/axs103_smp_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 7c22163..dd38d03 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -116,3 +116,4 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
+CONFIG_SND_DESIGNWARE_I2S=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index d63aef0..ff7162e 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -119,3 +119,4 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
+CONFIG_SND_DESIGNWARE_I2S=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index f4b51ce..b9f4671 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -120,3 +120,4 @@ CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
+CONFIG_SND_DESIGNWARE_I2S=y
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
