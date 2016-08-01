From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Do not ignore errors if mclk is specified" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:36 +0100
Message-ID: <E1bUGgi-0006UM-Oq@debutante>
References: <1469745781-31057-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469745781-31057-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.comPaul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Do not ignore errors if mclk is specified

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

>From dc6660164410c3eddbc48dccf9b7c5b2def209be Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 28 Jul 2016 15:43:01 -0700
Subject: [PATCH] ASoC: cs53l30: Do not ignore errors if mclk is specified

When the clock is specified, there could be other errors besides
the EPROBE_DEFER so don't ignore them.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 2c0d9c430a8c..227c55643fa5 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -999,8 +999,8 @@ static int cs53l30_i2c_probe(struct i2c_client *client,
 	/* Check if MCLK provided */
 	cs53l30->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(cs53l30->mclk)) {
-		if (PTR_ERR(cs53l30->mclk) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		if (PTR_ERR(cs53l30->mclk) != -ENOENT) {
+			ret = PTR_ERR(cs53l30->mclk);
 			goto error;
 		}
 		/* Otherwise mark the mclk pointer to NULL */
-- 
2.8.1
