From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Revert "ASoC:
	soc-generic-dmaengine-pcm: Fix error handling"" to the asoc tree
Date: Mon, 26 Feb 2018 20:00:32 +0000
Message-ID: <E1eqOwq-0006v9-PC@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 202A0267516
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 21:00:35 +0100 (CET)
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
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Revert "ASoC: soc-generic-dmaengine-pcm: Fix error handling"

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

>From b84acf44d5b86597cebcb6aca16e7dd9ca2b0294 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 26 Feb 2018 15:55:25 -0300
Subject: [PATCH] ASoC: Revert "ASoC: soc-generic-dmaengine-pcm: Fix error
 handling"

This reverts commit f91b1e73ccde71d4bc69ae10d475196df38844ab.

As explained by Lars-Peter Clausen:

"This creates a resource leak. dmaengine_pcm_request_chan_of() requests
bothtransmit and receive channels. It might return with an error if one
of them fails, but the other one succeeded. In this case we need to call
dmaengine_pcm_release_chan() to free the requested channel"

So revert the commit.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 567fbdfd1ca9..56a541b9ff9e 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -504,7 +504,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
 	if (ret)
-		goto err_free_pcm;
+		goto err_free_dma;
 
 	if (config && config->process)
 		ret = snd_soc_add_component(dev, &pcm->component,
@@ -520,7 +520,6 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 err_free_dma:
 	dmaengine_pcm_release_chan(pcm);
-err_free_pcm:
 	kfree(pcm);
 	return ret;
 }
-- 
2.16.1
