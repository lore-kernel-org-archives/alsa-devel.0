From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/14] ASoC: ux500_pcm: No need to wrap
	snd_dmaengine_pcm_close()
Date: Fri, 22 Mar 2013 14:12:05 +0100
Message-ID: <1363957934-20059-6-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 25400266530
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:10:36 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

If a PCM driver using the dmaengine PCM helper functions doesn't need to do
anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
directly for as the pcm_close callback and there is no need to wrap it in a
custom function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/ux500/ux500_pcm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 375ca6b..d000ba2 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -160,18 +160,6 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int ux500_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *dai = rtd->cpu_dai;
-
-	dev_dbg(dai->dev, "%s: Enter\n", __func__);
-
-	snd_dmaengine_pcm_close(substream);
-
-	return 0;
-}
-
 static int ux500_pcm_hw_params(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *hw_params)
 {
@@ -246,7 +234,7 @@ static int ux500_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops ux500_pcm_ops = {
 	.open		= ux500_pcm_open,
-	.close		= ux500_pcm_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= ux500_pcm_hw_params,
 	.hw_free	= ux500_pcm_hw_free,
-- 
1.8.0
