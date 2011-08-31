From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove unused variable 'card' in imx_pcm_fiq_new
Date: Wed, 31 Aug 2011 13:50:25 +0800
Message-ID: <1314769825.28750.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix below build warning:

  CC      sound/soc/imx/imx-pcm-fiq.o
sound/soc/imx/imx-pcm-fiq.c: In function 'imx_pcm_fiq_new':
sound/soc/imx/imx-pcm-fiq.c:243: warning: unused variable 'card'

Signed-off-by: Axel Lin <axel.lin@gmail.com>
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
1.7.4.1
