From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: spear_pcm: Use
	devm_snd_dmaengine_pcm_register to fix resource leak" to the
	asoc tree
Date: Sun, 30 Aug 2015 12:26:50 +0100
Message-ID: <E1ZW0l8-0008FK-IW@finisterre>
References: <1440893295.19750.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2F62605F4
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 16:18:05 +0200 (CEST)
In-Reply-To: <1440893295.19750.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: spear_pcm: Use devm_snd_dmaengine_pcm_register to fix resource leak

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2c3f4b97eea5ce405baf2591715445da6ed05851 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 30 Aug 2015 08:08:15 +0800
Subject: [PATCH] ASoC: spear_pcm: Use devm_snd_dmaengine_pcm_register to fix
 resource leak

All the callers assume devm_spear_pcm_platform_register is a devm_ API, so
use devm_snd_dmaengine_pcm_register in devm_spear_pcm_platform_register.

Fixes: e1771bcf99b0 ("ASoC: SPEAr: remove custom DMA alloc compat function")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/spear/spear_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
index a7dc3c5..e8476da 100644
--- a/sound/soc/spear/spear_pcm.c
+++ b/sound/soc/spear/spear_pcm.c
@@ -44,7 +44,7 @@ int devm_spear_pcm_platform_register(struct device *dev,
 	*config = spear_dmaengine_pcm_config;
 	config->compat_filter_fn = filter;
 
-	return snd_dmaengine_pcm_register(dev, config,
+	return devm_snd_dmaengine_pcm_register(dev, config,
 		SND_DMAENGINE_PCM_FLAG_NO_DT |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
-- 
2.5.0
