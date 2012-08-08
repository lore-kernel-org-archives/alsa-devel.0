From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs: Fix the name of the SoC family
Date: Wed,  8 Aug 2012 00:47:21 -0300
Message-ID: <1344397641-6673-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DFE38266024
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 05:17:44 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so313686yhn.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 20:47:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SND_SOC_MXS_SGTL5000 is used on MXS boards, so fix the SoC family name.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mxs/Kconfig b/sound/soc/mxs/Kconfig
index 99a997f..b6fa776 100644
--- a/sound/soc/mxs/Kconfig
+++ b/sound/soc/mxs/Kconfig
@@ -10,7 +10,7 @@ menuconfig SND_MXS_SOC
 if SND_MXS_SOC
 
 config SND_SOC_MXS_SGTL5000
-	tristate "SoC Audio support for i.MX boards with sgtl5000"
+	tristate "SoC Audio support for MXS boards with sgtl5000"
 	depends on I2C
 	select SND_SOC_SGTL5000
 	help
-- 
1.7.1
