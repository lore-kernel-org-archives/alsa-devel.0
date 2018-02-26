From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-generic-dmaengine-pcm: Fix error
	handling" to the asoc tree
Date: Mon, 26 Feb 2018 11:17:16 +0000
Message-ID: <E1eqGmS-0005Qb-FD@debutante>
References: <1519326142-26421-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F147E267990
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 12:17:18 +0100 (CET)
In-Reply-To: <1519326142-26421-1-git-send-email-festevam@gmail.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-generic-dmaengine-pcm: Fix error handling

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

>From f91b1e73ccde71d4bc69ae10d475196df38844ab Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Thu, 22 Feb 2018 16:02:21 -0300
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: Fix error handling

When dmaengine_pcm_request_chan_of() fails it should release
the previously acquired resources, which in this case is to
call kfree(pcm), so jump to the correct point in the error
path.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 768247fd92c5..32ea16d062b1 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -450,7 +450,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
 	if (ret)
-		goto err_free_dma;
+		goto err_free_pcm;
 
 	ret = snd_soc_add_component(dev, &pcm->component,
 				    &dmaengine_pcm_component, NULL, 0);
@@ -461,6 +461,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 err_free_dma:
 	dmaengine_pcm_release_chan(pcm);
+err_free_pcm:
 	kfree(pcm);
 	return ret;
 }
-- 
2.16.1
