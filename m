From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ab8500: Remove explicit initialization
	of driver callbacks to NULL" to the asoc tree
Date: Wed, 23 Nov 2016 16:31:22 +0000
Message-ID: <E1c9aSA-0006Wf-B3@debutante>
References: <1479851388-17593-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C0301266649
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2016 17:31:41 +0100 (CET)
In-Reply-To: <1479851388-17593-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ab8500: Remove explicit initialization of driver callbacks to NULL

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

>From 0a69516cd8b9878c4040c35294443ac18338febd Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 22 Nov 2016 22:49:48 +0100
Subject: [PATCH] ASoC: ab8500: Remove explicit initialization of driver
 callbacks to NULL

Fields of structs with global storage are implicitly initialized to 0/NULL,
there is usually no need to do this explicitly.

Removing the initialization of the legacy suspend/resume callback fields
also gets the driver ready for the day when they are eventually removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 935ff7cb71c5..312b2a11abb6 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2587,8 +2587,6 @@ static struct platform_driver ab8500_codec_platform_driver = {
 	},
 	.probe		= ab8500_codec_driver_probe,
 	.remove		= ab8500_codec_driver_remove,
-	.suspend	= NULL,
-	.resume		= NULL,
 };
 module_platform_driver(ab8500_codec_platform_driver);
 
-- 
2.10.2
