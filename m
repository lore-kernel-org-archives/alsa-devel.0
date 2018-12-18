From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] ASoC: eukrea-tlv320: Do not enable on ARM64
Date: Tue, 18 Dec 2018 14:58:24 -0800
Message-ID: <20181218225824.20974-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

ARCH_MXC is also used by i.MX8/AArch64 SoC, building the driver for
that platform results in:

sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory
 #include <asm/mach-types.h>
          ^~~~~~~~~~~~~~~~~~
compilation terminated.

Since the code in question doesn't seem to have any use on i.MX8,
disable it by adding a !ARM64 as a dependecy.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Sorry for the noise if this is fixed already.

Thanks,
Andrey Smirnov

 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6ec19fb4a934..2e75b5bc5f1d 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -221,7 +221,7 @@ config SND_SOC_PHYCORE_AC97
 
 config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
-	depends on ARCH_MXC && I2C
+	depends on ARCH_MXC && !ARM64 && I2C
 	select SND_SOC_TLV320AIC23_I2C
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
-- 
2.19.1
