From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Fix return code shown on error
	for hw_params" to the asoc tree
Date: Wed, 30 May 2018 16:34:41 +0100
Message-ID: <E1fO37Z-0006g0-2x@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ED59F267757
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 17:34:44 +0200 (CEST)
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
To: Jon Hunter <jonathanh@nvidia.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Fix return code shown on error for hw_params

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

>From b91530f0a39edd82aa1b286bd921d052eb747f31 Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Wed, 30 May 2018 16:15:19 +0100
Subject: [PATCH] ASoC: core: Fix return code shown on error for hw_params

When the call to hw_params for a component fails, the error code is held
by the variable '__ret' but the error message displays the value held by
the variable 'ret'. Fix the return code shown when hw_params fails for
a component.

Fixes: b8135864d4d3 ("ASoC: snd_soc_component_driver has snd_pcm_ops")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 0e2b2c6c60bd..5e7ae47a9658 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -956,7 +956,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		if (__ret < 0) {
 			dev_err(component->dev,
 				"ASoC: %s hw params failed: %d\n",
-				component->name, ret);
+				component->name, __ret);
 			ret = __ret;
 		}
 	}
-- 
2.17.0
