From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel-pdmic: add missing clk_disable_unprepare() on error in atmel_pdmic_cpu_dai_startup()" to the asoc tree
Date: Fri, 12 Aug 2016 13:29:54 +0100
Message-ID: <E1bYBb0-0002kA-Ve@debutante>
References: <1470837201-12232-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470837201-12232-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel-pdmic: add missing clk_disable_unprepare() on error in atmel_pdmic_cpu_dai_startup()

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

>From 61743bfaf061e253a58a3a2f22659405cc95939a Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Wed, 10 Aug 2016 13:53:21 +0000
Subject: [PATCH] ASoC: atmel-pdmic: add missing clk_disable_unprepare() on
 error in atmel_pdmic_cpu_dai_startup()

Add the missing clk_disable_unprepare() before return from
atmel_pdmic_cpu_dai_startup() in the error handling case.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-pdmic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 4cce36e07360..8b4beb07ca43 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -115,8 +115,10 @@ static int atmel_pdmic_cpu_dai_startup(struct snd_pcm_substream *substream,
 		return ret;
 
 	ret =  clk_prepare_enable(dd->pclk);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(dd->gclk);
 		return ret;
+	}
 
 	/* Clear all bits in the Control Register(PDMIC_CR) */
 	regmap_write(dd->regmap, PDMIC_CR, 0);
-- 
2.8.1
