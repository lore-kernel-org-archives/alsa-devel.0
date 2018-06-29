From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: provide PCM ops for ssp,
	i2s and ac97 components" to the asoc tree
Date: Fri, 29 Jun 2018 12:07:11 +0100
Message-ID: <E1fYrF9-0002bO-AQ@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C0F9267A2F
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 13:07:12 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: provide PCM ops for ssp, i2s and ac97 components

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d767d3ce5c48b3378e20e8cfd5d5379c4ca6001b Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 27 Jun 2018 21:33:57 +0200
Subject: [PATCH] ASoC: pxa: provide PCM ops for ssp, i2s and ac97 components

Now that the functions are now available through pxa2xx-lib, hook them up
to pxa-sspi, pxa-ac97 and pxa-i2s. This allows DT platforms to use the DAIs
without a platform driver.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index c52b33802bf2..9f779657bc86 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -214,6 +214,9 @@ static struct snd_soc_dai_driver pxa_ac97_dai_driver[] = {
 
 static const struct snd_soc_component_driver pxa_ac97_component = {
 	.name		= "pxa-ac97",
+	.ops		= &pxa2xx_pcm_ops,
+	.pcm_new	= pxa2xx_soc_pcm_new,
+	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
 
 #ifdef CONFIG_OF
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
2.18.0.rc2
