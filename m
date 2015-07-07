From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98090: Check for
	clk_prepare_enable() error" to the asoc tree
Date: Tue, 07 Jul 2015 19:30:51 +0100
Message-ID: <E1ZCXdr-0001TM-Ck@debutante>
References: <1434826553-11484-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3EF72604AC
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 20:31:00 +0200 (CEST)
In-Reply-To: <1434826553-11484-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98090: Check for clk_prepare_enable() error

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

>From 9acc7f08716b98730e1ead7e785fb0f3ad3a2d07 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Sat, 20 Jun 2015 15:55:50 -0300
Subject: [PATCH] ASoC: max98090: Check for clk_prepare_enable() error

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 78268f0514e9..1697340c3842 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -1801,10 +1801,13 @@ static int max98090_set_bias_level(struct snd_soc_codec *codec,
 		if (IS_ERR(max98090->mclk))
 			break;
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON)
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
 			clk_disable_unprepare(max98090->mclk);
-		else
-			clk_prepare_enable(max98090->mclk);
+		} else {
+			ret = clk_prepare_enable(max98090->mclk);
+			if (ret)
+				return ret;
+		}
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-- 
2.1.4
