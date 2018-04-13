From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: bytcr_rt5640: Replace GFP_ATOMIC
	with GFP_KERNEL in snd_byt_rt5640_mc_probe" to the asoc tree
Date: Fri, 13 Apr 2018 12:24:08 +0100
Message-ID: <E1f6woK-0000Dd-2m@debutante>
References: <E1f6wNC-0007B3-Vv@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EFF8926760F
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 13:24:08 +0200 (CEST)
In-Reply-To: <E1f6wNC-0007B3-Vv@debutante>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: bytcr_rt5640: Replace GFP_ATOMIC with GFP_KERNEL in snd_byt_rt5640_mc_probe

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

>From f5c74c2918e51be14bc9c11c76fa118e354f4789 Mon Sep 17 00:00:00 2001
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Mon, 9 Apr 2018 18:47:37 +0800
Subject: [PATCH] ASoC: intel: bytcr_rt5640: Replace GFP_ATOMIC with GFP_KERNEL
 in snd_byt_rt5640_mc_probe

snd_byt_rt5640_mc_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
snd_byt_rt5640_mc_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a8d8bff788e7..ad5fcd5a1762 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -744,7 +744,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	int i;
 
 	is_bytcr = false;
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-- 
2.17.0
