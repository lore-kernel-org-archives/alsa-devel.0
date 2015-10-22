From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Convert to
	devm_snd_soc_register_card" to the asoc tree
Date: Fri, 23 Oct 2015 08:08:46 +0900
Message-ID: <E1ZpOyU-0008GB-Fa@finisterre>
References: <1445339625.4751.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF66E266AAF
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:09:02 +0200 (CEST)
In-Reply-To: <1445339625.4751.0.camel@ingics.com>
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

   ASoC: Intel: Skylake: Convert to devm_snd_soc_register_card

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

>From 4901aa065bced55be5ae55b58fc032bfc727fdda Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 20 Oct 2015 19:13:45 +0800
Subject: [PATCH] ASoC: Intel: Skylake: Convert to devm_snd_soc_register_card

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 488c98e..a73a431 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -240,18 +240,11 @@ static int skylake_audio_probe(struct platform_device *pdev)
 {
 	skylake_rt286.dev = &pdev->dev;
 
-	return snd_soc_register_card(&skylake_rt286);
-}
-
-static int skylake_audio_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&skylake_rt286);
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, &skylake_rt286);
 }
 
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
-	.remove = skylake_audio_remove,
 	.driver = {
 		.name = "skl_alc286s_i2s",
 	},
-- 
2.6.1
