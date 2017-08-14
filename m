From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: blackfin: Use common error handling code in sport_create()" to the asoc tree
Date: Mon, 14 Aug 2017 17:42:58 +0100
Message-ID: <E1dhISA-0005BA-7h@finisterre>
References: <ef3f99a2-7e51-ff07-8e68-3d74495854a9@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ef3f99a2-7e51-ff07-8e68-3d74495854a9@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Scott Jiang <scott.jiang.linux@gmail.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: blackfin: Use common error handling code in sport_create()

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

>From 11fca34b2783408dbf37e42a38e4b55d54d6fa3a Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 22:02:47 +0200
Subject: [PATCH] ASoC: blackfin: Use common error handling code in
 sport_create()

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/blackfin/bf6xx-sport.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index 1bc3e0a47a57..fcddebf2558c 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -394,19 +394,18 @@ struct sport_device *sport_create(struct platform_device *pdev)
 	sport->pdev = pdev;
 
 	ret = sport_get_resource(sport);
-	if (ret) {
-		kfree(sport);
-		return NULL;
-	}
+	if (ret)
+		goto free_data;
 
 	ret = sport_request_resource(sport);
-	if (ret) {
-		kfree(sport);
-		return NULL;
-	}
+	if (ret)
+		goto free_data;
 
 	dev_dbg(dev, "SPORT create success\n");
 	return sport;
+free_data:
+	kfree(sport);
+	return NULL;
 }
 EXPORT_SYMBOL(sport_create);
 
-- 
2.13.2
