From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: imx: Fix build warning of unused 'card'
	variable
Date: Tue, 30 Aug 2011 00:28:42 -0300
Message-ID: <1314674922-1540-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D3E924398
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 05:28:53 +0200 (CEST)
Received: by gyd8 with SMTP id 8so5528562gyd.38
	for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2011 20:28:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>, lrg@ti.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Fixes the following warning:

  CC      sound/soc/imx/imx-pcm-fiq.o
sound/soc/imx/imx-pcm-fiq.c: In function 'imx_pcm_fiq_new':
sound/soc/imx/imx-pcm-fiq.c:243: warning: unused variable 'card'
  CC      sound/soc/imx/imx-pcm-dma-mx2.o

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/imx/imx-pcm-fiq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 309c59e..7945625 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -240,7 +240,6 @@ static int ssi_irq = 0;
 
 static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_card *card = rtd->card->snd_card;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
-- 
1.6.0.4
