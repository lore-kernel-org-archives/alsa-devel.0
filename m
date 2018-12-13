From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build
	error on i.MX8M
Date: Thu, 13 Dec 2018 00:08:38 -0200
Message-ID: <1544666918-10783-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by alsa0.perex.cz (Postfix) with ESMTP id C7313267C5F
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 03:08:43 +0100 (CET)
Received: by mail-qk1-f195.google.com with SMTP id a132so291602qkg.1
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 18:08:43 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, shawnguo@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

eukrea-tlv320.c machine driver runs on non-DT platforms
and include <asm/mach-types.h> header file in order to be able
to use some machine_is_eukrea_xxx() macros.

Building it for ARM64 causes the following build error:

sound/soc/fsl/eukrea-tlv320.c:28:10: fatal error: asm/mach-types.h: No such file or directory

Avoid this error by not allowing to build the SND_SOC_EUKREA_TLV320
driver when ARM64 is selected.

This is needed in preparation for the i.MX8M support.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Drop the mention to the i.MX8M commit that is currently only in
Shawn's tree.
 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6ec19fb..2e75b5b 100644
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
2.7.4
