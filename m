From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 5/7] ASoC: pxa: provide PCM ops for ssp,
	i2s and ac97 components
Date: Wed, 27 Jun 2018 21:33:57 +0200
Message-ID: <20180627193359.26631-6-daniel@zonque.org>
References: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id D40A72679A6
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:13 +0200 (CEST)
In-Reply-To: <20180627193359.26631-1-daniel@zonque.org>
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
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that the functions are now available through pxa2xx-lib, hook them up
to pxa-sspi, pxa-ac97 and pxa-i2s. This allows DT platforms to use the DAIs
without a platform driver.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/pxa/pxa-ssp.c     | 3 +++
 sound/soc/pxa/pxa2xx-ac97.c | 3 +++
 sound/soc/pxa/pxa2xx-i2s.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c1f4af869289..01d54697ede4 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -841,6 +841,9 @@ static struct snd_soc_dai_driver pxa_ssp_dai = {
 
 static const struct snd_soc_component_driver pxa_ssp_component = {
 	.name		= "pxa-ssp",
+	.ops		= &pxa2xx_pcm_ops,
+	.pcm_new	= pxa2xx_soc_pcm_new,
+	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
 
 #ifdef CONFIG_OF
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 1b41c0f2a8fb..95e34d196eab 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -214,6 +214,9 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 
 static const struct snd_soc_component_driver pxa_ac97_component = {
 	.name		= "pxa-ac97",
+	.ops		= &pxa2xx_pcm_ops,
+	.pcm_new	= pxa2xx_soc_pcm_new,
+	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
 
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index e7184de0de04..42820121e5b9 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -364,6 +364,9 @@ static struct snd_soc_dai_driver pxa_i2s_dai = {
 
 static const struct snd_soc_component_driver pxa_i2s_component = {
 	.name		= "pxa-i2s",
+	.ops		= &pxa2xx_pcm_ops,
+	.pcm_new	= pxa2xx_soc_pcm_new,
+	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
 
 static int pxa2xx_i2s_drv_probe(struct platform_device *pdev)
-- 
2.17.1
