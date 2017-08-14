From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: blackfin: Delete an error message for a failed memory allocation in sport_create()" to the asoc tree
Date: Mon, 14 Aug 2017 17:43:02 +0100
Message-ID: <E1dhISE-0005CD-0r@finisterre>
References: <d3eaf797-a4a3-f4ff-c368-3961b4e16fb1@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d3eaf797-a4a3-f4ff-c368-3961b4e16fb1@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: Mark Brown <broonie@kernel.org>, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Scott Jiang <scott.jiang.linux@gmail.com>, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: blackfin: Delete an error message for a failed memory allocation in sport_create()

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

>From 60ea0394a602d5abc24bd2381fa0966a8720eec1 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 21:45:37 +0200
Subject: [PATCH] ASoC: blackfin: Delete an error message for a failed memory
 allocation in sport_create()

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/blackfin/bf6xx-sport.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/blackfin/bf6xx-sport.c b/sound/soc/blackfin/bf6xx-sport.c
index dfb744381c42..1bc3e0a47a57 100644
--- a/sound/soc/blackfin/bf6xx-sport.c
+++ b/sound/soc/blackfin/bf6xx-sport.c
@@ -388,10 +388,9 @@ struct sport_device *sport_create(struct platform_device *pdev)
 	int ret;
 
 	sport = kzalloc(sizeof(*sport), GFP_KERNEL);
-	if (!sport) {
-		dev_err(dev, "Unable to allocate memory for sport device\n");
+	if (!sport)
 		return NULL;
-	}
+
 	sport->pdev = pdev;
 
 	ret = sport_get_resource(sport);
-- 
2.13.2
