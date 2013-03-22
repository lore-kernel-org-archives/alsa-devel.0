From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/14] ASoC: tegra_pcm: No need to wrap
	snd_dmaengine_pcm_close()
Date: Fri, 22 Mar 2013 14:12:04 +0100
Message-ID: <1363957934-20059-5-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A46B526652C
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:10:32 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Laxman Dewangan <ldewangan@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

If a PCM driver using the dmaengine PCM helper functions doesn't need to do
anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
directly for as the pcm_close callback and there is no need to wrap it in a
custom function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
---
 sound/soc/tegra/tegra_pcm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index c925ab0..e67af0b 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -75,12 +75,6 @@ static int tegra_pcm_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int tegra_pcm_close(struct snd_pcm_substream *substream)
-{
-	snd_dmaengine_pcm_close(substream);
-	return 0;
-}
-
 static int tegra_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
@@ -160,7 +154,7 @@ static int tegra_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops tegra_pcm_ops = {
 	.open		= tegra_pcm_open,
-	.close		= tegra_pcm_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= tegra_pcm_hw_params,
 	.hw_free	= tegra_pcm_hw_free,
-- 
1.8.0
