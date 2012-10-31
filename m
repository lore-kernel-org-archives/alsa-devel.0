From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: mxs-saif: Add MODULE_ALIAS
Date: Wed, 31 Oct 2012 01:20:05 -0200
Message-ID: <1351653605-30512-2-git-send-email-festevam@gmail.com>
References: <1351653605-30512-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f51.google.com (mail-yh0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D0FE2615BF
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 04:20:28 +0100 (CET)
Received: by mail-yh0-f51.google.com with SMTP id n12so197419yhn.38
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 20:20:28 -0700 (PDT)
In-Reply-To: <1351653605-30512-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add MODULE_ALIAS information.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-saif.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 7c3154d..fe260c1 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -804,3 +804,4 @@ module_platform_driver(mxs_saif_driver);
 MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("MXS ASoC SAIF driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mxs-saif");
-- 
1.7.9.5
