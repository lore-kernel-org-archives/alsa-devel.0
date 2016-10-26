From: Mark Brown <broonie@kernel.org>
Subject: Applied "SoC: mxs-saif: check validity of ids in mxs_saif_probe()" to the asoc tree
Date: Wed, 26 Oct 2016 11:15:39 +0100
Message-ID: <E1bzLFD-0004Qv-F8@debutante>
References: <1476482016-27659-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476482016-27659-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, ldv-project@linuxtesting.org, alsa-devel@alsa-project.org, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   SoC: mxs-saif: check validity of ids in mxs_saif_probe()

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

>From e1b790a8720192e1cfdd46a9b20d0f56de99c73d Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 15 Oct 2016 00:53:36 +0300
Subject: [PATCH] SoC: mxs-saif: check validity of ids in mxs_saif_probe()

There is a check for validity of one of ids in mxs_saif_probe(),
while array dereferece is made by the other id.

The patch adds the check for the second saif id.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mxs/mxs-saif.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 13631003cb7c..a002ab892772 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -735,6 +735,11 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	else
 		saif->id = ret;
 
+	if (saif->id >= ARRAY_SIZE(mxs_saif)) {
+		dev_err(&pdev->dev, "get wrong saif id\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * If there is no "fsl,saif-master" phandle, it's a saif
 	 * master.  Otherwise, it's a slave and its phandle points
@@ -749,11 +754,11 @@ static int mxs_saif_probe(struct platform_device *pdev)
 			return ret;
 		else
 			saif->master_id = ret;
-	}
 
-	if (saif->master_id >= ARRAY_SIZE(mxs_saif)) {
-		dev_err(&pdev->dev, "get wrong master id\n");
-		return -EINVAL;
+		if (saif->master_id >= ARRAY_SIZE(mxs_saif)) {
+			dev_err(&pdev->dev, "get wrong master id\n");
+			return -EINVAL;
+		}
 	}
 
 	mxs_saif[saif->id] = saif;
-- 
2.8.1
