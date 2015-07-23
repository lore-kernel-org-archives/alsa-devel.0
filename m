From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xtensa: Remove unnecessary
	snd_pcm_lib_preallocate_free_for_all()" to the asoc tree
Date: Thu, 23 Jul 2015 17:41:50 +0100
Message-ID: <E1ZIJZ8-0002Nh-5S@debutante>
References: <20150723163914.GA4050@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3C3326128B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:41:56 +0200 (CEST)
In-Reply-To: <20150723163914.GA4050@vaishali-Ideapad-Z570>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xtensa: Remove unnecessary snd_pcm_lib_preallocate_free_for_all()

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

>From 36e914cc4bb5d1842e7c8a2e2b9b4f2935771c14 Mon Sep 17 00:00:00 2001
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Thu, 23 Jul 2015 22:09:15 +0530
Subject: [PATCH] ASoC: xtensa: Remove unnecessary
 snd_pcm_lib_preallocate_free_for_all()

The ALSA core takes care that all preallocated memory is freed
when the PCM itself is freed. There is no need to do this
manually in the driver.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xtensa/xtfpga-i2s.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 1cfb19e12949..039f65e36fa8 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -474,11 +474,6 @@ static int xtfpga_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						     card->dev, size, size);
 }
 
-static void xtfpga_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static const struct snd_pcm_ops xtfpga_pcm_ops = {
 	.open		= xtfpga_pcm_open,
 	.close		= xtfpga_pcm_close,
@@ -490,7 +485,6 @@ static const struct snd_pcm_ops xtfpga_pcm_ops = {
 
 static const struct snd_soc_platform_driver xtfpga_soc_platform = {
 	.pcm_new	= xtfpga_pcm_new,
-	.pcm_free	= xtfpga_pcm_free,
 	.ops		= &xtfpga_pcm_ops,
 };
 
-- 
2.1.4
