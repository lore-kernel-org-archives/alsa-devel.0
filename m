From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa-ssp: enable and disable extclk if
	given" to the asoc tree
Date: Thu,  4 Oct 2018 11:42:27 +0100 (BST)
Message-ID: <20181004104227.2C85E1121BA8@debutante.sirena.org.uk>
References: <20181003193627.5423-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C34582676A7
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 12:42:27 +0200 (CEST)
In-Reply-To: <20181003193627.5423-1-daniel@zonque.org>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, robert.jarzmik@free.fr, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa-ssp: enable and disable extclk if given

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

>From cfe9ee5f2b7808ceec21df83a45e38afcc647153 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 3 Oct 2018 21:36:27 +0200
Subject: [PATCH] ASoC: pxa-ssp: enable and disable extclk if given

If a "extclk" clock is given, enable and disable it when appropriate.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa-ssp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 69033e1a84e6..adcf8ba9d287 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -103,6 +103,9 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 		pxa_ssp_disable(ssp);
 	}
 
+	if (priv->extclk)
+		clk_prepare_enable(priv->extclk);
+
 	dma = kzalloc(sizeof(struct snd_dmaengine_dai_dma_data), GFP_KERNEL);
 	if (!dma)
 		return -ENOMEM;
@@ -125,6 +128,9 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 		clk_disable_unprepare(ssp->clk);
 	}
 
+	if (priv->extclk)
+		clk_disable_unprepare(priv->extclk);
+
 	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
 	snd_soc_dai_set_dma_data(cpu_dai, substream, NULL);
 }
-- 
2.19.0.rc2
