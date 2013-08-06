From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: imx-mc13783: Make SND_SOC_IMX_MC13783
	visible again
Date: Tue,  6 Aug 2013 18:03:07 -0300
Message-ID: <1375822987-12830-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f180.google.com (mail-gh0-f180.google.com
 [209.85.160.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 350092616E9
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 23:03:19 +0200 (CEST)
Received: by mail-gh0-f180.google.com with SMTP id f18so277468ghb.39
 for <alsa-devel@alsa-project.org>; Tue, 06 Aug 2013 14:03:18 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 02502da45 (ASoC: imx-mc13783: Depend on ARCH_ARM) introduced 'ARCH_ARM' 
as a dependency for SND_SOC_IMX_MC13783, but this is a non-existent symbol.

This makes the selection of SND_SOC_IMX_MC13783 to be impossible.

Use the correct 'ARM' symbol instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index c26449b..e15f771 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -194,7 +194,7 @@ config SND_SOC_IMX_SGTL5000
 
 config SND_SOC_IMX_MC13783
 	tristate "SoC Audio support for I.MX boards with mc13783"
-	depends on MFD_MC13783 && ARCH_ARM
+	depends on MFD_MC13783 && ARM
 	select SND_SOC_IMX_SSI
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_MC13783
-- 
1.8.1.2
