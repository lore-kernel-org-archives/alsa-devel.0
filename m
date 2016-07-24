From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Delete an unnecessary check before the function call "release_firmware"" to the asoc tree
Date: Sun, 24 Jul 2016 22:06:15 +0100
Message-ID: <E1bRQbH-0003xj-Aa@debutante>
References: <2c4f9e3a-96d7-36e1-379e-282353ea09b2@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2c4f9e3a-96d7-36e1-379e-282353ea09b2@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Delete an unnecessary check before the function call "release_firmware"

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

>From 1b00126cb3de017274e899ac559a744d4e3dbd61 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Jul 2016 18:58:14 +0200
Subject: [PATCH] ASoC: Intel: Skylake: Delete an unnecessary check before the
 function call "release_firmware"

The release_firmware() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 2337748ffead..cd59536a761d 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -781,8 +781,7 @@ static void skl_remove(struct pci_dev *pci)
 	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
 	struct skl *skl = ebus_to_skl(ebus);
 
-	if (skl->tplg)
-		release_firmware(skl->tplg);
+	release_firmware(skl->tplg);
 
 	if (pci_dev_run_wake(pci))
 		pm_runtime_get_noresume(&pci->dev);
-- 
2.8.1
