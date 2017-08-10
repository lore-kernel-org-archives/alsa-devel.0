From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Delete error messages for a failed memory allocation in snd_soc_new_compress()" to the asoc tree
Date: Thu, 10 Aug 2017 16:42:09 +0100
Message-ID: <E1dfpb7-0001hZ-F5@finisterre>
References: <f9abf5ea-0284-ba87-9f22-2111d8631dfa@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f9abf5ea-0284-ba87-9f22-2111d8631dfa@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Delete error messages for a failed memory allocation in snd_soc_new_compress()

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

>From 7a0cf42edd9cc335572aa8614df0ebefa2f537be Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 10 Aug 2017 16:21:34 +0200
Subject: [PATCH] ASoC: compress: Delete error messages for a failed memory
 allocation in snd_soc_new_compress()

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-compress.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 206f36bf43e8..6c867d50e036 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -764,15 +764,12 @@ int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 		direction = SND_COMPRESS_CAPTURE;
 
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
-	if (compr == NULL) {
-		snd_printk(KERN_ERR "Cannot allocate compr\n");
+	if (!compr)
 		return -ENOMEM;
-	}
 
 	compr->ops = devm_kzalloc(rtd->card->dev, sizeof(soc_compr_ops),
 				  GFP_KERNEL);
-	if (compr->ops == NULL) {
-		dev_err(rtd->card->dev, "Cannot allocate compressed ops\n");
+	if (!compr->ops) {
 		ret = -ENOMEM;
 		goto compr_err;
 	}
-- 
2.13.2
