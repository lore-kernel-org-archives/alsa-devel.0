From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Improve error checking of mclk
	enable/disable" to the asoc tree
Date: Wed, 07 Oct 2015 12:18:22 +0100
Message-ID: <E1Zjmjm-0006QY-CN@finisterre>
References: <413ccdb3a8f209045fad3063e10919a6e6ccb757.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 84D6C265D47
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 13:18:59 +0200 (CEST)
In-Reply-To: <413ccdb3a8f209045fad3063e10919a6e6ccb757.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Improve error checking of mclk enable/disable

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

>From ba856fbd602175d386ab5a4fc0fdd89b912546cb Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 7 Oct 2015 11:57:14 +0100
Subject: [PATCH] ASoC: da7219: Improve error checking of mclk enable/disable

Should only try to enable/disable the provided mclk, during bias
level changes, if it's not NULL. Also return value of
clk_prepare_enable() should be checked and dealt with accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index adcc079..abba4b3 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1494,6 +1494,7 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1502,7 +1503,14 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			/* MCLK */
-			clk_prepare_enable(da7219->mclk);
+			if (da7219->mclk) {
+				ret = clk_prepare_enable(da7219->mclk);
+				if (ret) {
+					dev_err(codec->dev,
+						"Failed to enable mclk\n");
+					return ret;
+				}
+			}
 
 			/* Master bias */
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
@@ -1528,7 +1536,8 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* MCLK */
-		clk_disable_unprepare(da7219->mclk);
+		if (da7219->mclk)
+			clk_disable_unprepare(da7219->mclk);
 		break;
 	}
 
-- 
2.5.0
