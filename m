From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Fix up
	snd_soc_register_platform error path" to the asoc tree
Date: Fri, 29 Jan 2016 01:16:44 +0100
Message-ID: <E1aOwk0-0005Yp-16@finisterre>
References: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3151261560
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 01:16:55 +0100 (CET)
In-Reply-To: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5110: Fix up snd_soc_register_platform error path

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

>From 0f9aa09d669b29ae536d51631bf035ad44ae0551 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 21 Jan 2016 17:52:57 +0000
Subject: [PATCH] ASoC: wm5110: Fix up snd_soc_register_platform error path

Whilst there is nothing wrong with the error path here it looks a little
bit odd, this patches makes the code a little more idiomatic.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 6088d30..83760b7 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2366,7 +2366,7 @@ static int wm5110_probe(struct platform_device *pdev)
 	ret = snd_soc_register_platform(&pdev->dev, &wm5110_compr_platform);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
-		goto error;
+		return ret;
 	}
 
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
@@ -2376,7 +2376,6 @@ static int wm5110_probe(struct platform_device *pdev)
 		snd_soc_unregister_platform(&pdev->dev);
 	}
 
-error:
 	return ret;
 }
 
-- 
2.6.4
