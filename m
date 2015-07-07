From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: gtm601: Constify soc_codec_dev_gtm601"
	to the asoc tree
Date: Tue, 07 Jul 2015 14:57:44 +0100
Message-ID: <E1ZCTNY-0005VD-E4@finisterre>
References: <1436245039.1605.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 93F4B265626
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:59 +0200 (CEST)
In-Reply-To: <1436245039.1605.1.camel@ingics.com>
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

   ASoC: gtm601: Constify soc_codec_dev_gtm601

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

>From 02a9547e9b3f10d73fde66f52fc8b2a375a300cd Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 7 Jul 2015 12:57:19 +0800
Subject: [PATCH] ASoC: gtm601: Constify soc_codec_dev_gtm601

Also clean up the code a bit by fixing indent.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/gtm601.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
index 12d15e5..0b80052 100644
--- a/sound/soc/codecs/gtm601.c
+++ b/sound/soc/codecs/gtm601.c
@@ -51,7 +51,7 @@ static struct snd_soc_dai_driver gtm601_dai = {
 	},
 };
 
-static struct snd_soc_codec_driver soc_codec_dev_gtm601 = {
+static const struct snd_soc_codec_driver soc_codec_dev_gtm601 = {
 	.dapm_widgets = gtm601_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(gtm601_dapm_widgets),
 	.dapm_routes = gtm601_dapm_routes,
@@ -80,10 +80,9 @@ MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
 
 static struct platform_driver gtm601_codec_driver = {
 	.driver = {
-			.name = "gtm601",
-			.of_match_table = of_match_ptr(gtm601_codec_of_match),
+		.name = "gtm601",
+		.of_match_table = of_match_ptr(gtm601_codec_of_match),
 	},
-
 	.probe = gtm601_platform_probe,
 	.remove = gtm601_platform_remove,
 };
-- 
2.1.4
