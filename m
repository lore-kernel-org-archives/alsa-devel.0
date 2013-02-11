From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-audmux: Fix sparse warning
Date: Mon, 11 Feb 2013 13:39:08 -0200
Message-ID: <1360597148-6420-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f174.google.com (mail-ye0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A299261670
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 16:39:26 +0100 (CET)
Received: by mail-ye0-f174.google.com with SMTP id m3so1259469yen.33
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 07:39:24 -0800 (PST)
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

Fix the following sparse warning:

sound/soc/fsl/imx-audmux.c:182:3: warning: symbol 'audmux_type' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-audmux.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 251f4d9..fab912e 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -176,7 +176,7 @@ static inline void audmux_debugfs_remove(void)
 }
 #endif
 
-enum imx_audmux_type {
+static enum imx_audmux_type {
 	IMX21_AUDMUX,
 	IMX31_AUDMUX,
 } audmux_type;
-- 
1.7.9.5
