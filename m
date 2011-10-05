From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: imx: Remove unused variable 'dai'
Date: Wed, 05 Oct 2011 14:41:35 +0800
Message-ID: <1317796895.21481.2.camel@phoenix>
References: <1317796846.21481.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317796846.21481.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/imx/imx-pcm-fiq.c |    1 -
 sound/soc/imx/imx-ssi.c     |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index c8527ea..8df0fae2 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -240,7 +240,6 @@ static int ssi_irq = 0;
 
 static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	struct snd_pcm_substream *substream;
 	int ret;
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 4297cb6..4c05e2b 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -391,7 +391,6 @@ static u64 imx_pcm_dmamask = DMA_BIT_MASK(32);
 int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_card *card = rtd->card->snd_card;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret = 0;
 
-- 
1.7.4.1
