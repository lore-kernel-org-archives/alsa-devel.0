From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-pcm-fiq: Use 'unsigned int' for
	period
Date: Wed, 20 Mar 2013 02:22:40 -0300
Message-ID: <1363756960-11386-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 15C2026157F
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 06:22:52 +0100 (CET)
Received: by mail-qc0-f179.google.com with SMTP id b40so630506qcq.24
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 22:22:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: s.hauer@pengutronix.de
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following warning when building with W=1 option:

sound/soc/fsl/imx-pcm-fiq.c: In function 'snd_hrtimer_callback':
sound/soc/fsl/imx-pcm-fiq.c:76:12: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-pcm-fiq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 920f945..47228c0 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -34,7 +34,7 @@
 #include "imx-ssi.h"
 
 struct imx_pcm_runtime_data {
-	int period;
+	unsigned int period;
 	int periods;
 	unsigned long offset;
 	unsigned long last_offset;
-- 
1.7.9.5
