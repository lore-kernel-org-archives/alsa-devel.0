From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Changed the if-else case to
	switch case" to the asoc tree
Date: Thu, 18 Feb 2016 20:19:54 +0000
Message-ID: <E1aWV3K-0004Lq-DB@debutante>
References: <1455820580-26501-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0B752606A9
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 21:20:00 +0100 (CET)
In-Reply-To: <1455820580-26501-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Changed the if-else case to switch case

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

>From b14614502908beb5d898a665b40cfa91ad237f93 Mon Sep 17 00:00:00 2001
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 18 Feb 2016 10:36:20 -0800
Subject: [PATCH] ASoC: max9867: Changed the if-else case to switch case

Signed-off-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index b9d989f25515..5a8481bf20c2 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -212,16 +212,22 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		switch (snd_pcm_format_width(params_format(params))) {
 		case 8:
 		case 16:
-			if (pclk_bclk_ratio == 2)
+			switch (pclk_bclk_ratio) {
+			case 2:
 				bclk_value = MAX9867_IFC1B_PCLK_2;
-			else if (pclk_bclk_ratio == 4)
+				break;
+			case 4:
 				bclk_value = MAX9867_IFC1B_PCLK_4;
-			else if (pclk_bclk_ratio == 8)
+				break;
+			case 8:
 				bclk_value = MAX9867_IFC1B_PCLK_8;
-			else if (pclk_bclk_ratio == 16)
+				break;
+			case 16:
 				bclk_value = MAX9867_IFC1B_PCLK_16;
-			else {
-				dev_err(codec->dev, "unsupported sampling rate\n");
+				break;
+			default:
+				dev_err(codec->dev,
+					"unsupported sampling rate\n");
 				return -EINVAL;
 			}
 			break;
-- 
2.7.0
