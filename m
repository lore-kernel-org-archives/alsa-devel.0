From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Disable regulators on probe()
	failure" to the asoc tree
Date: Wed, 23 Dec 2015 00:12:19 +0000
Message-ID: <E1aBX2R-0008NQ-70@debutante>
References: <013f8a59618a9dfa74f6f983ed6ba4d7bec6a9d0.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9B06266688
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:12:26 +0100 (CET)
In-Reply-To: <013f8a59618a9dfa74f6f983ed6ba4d7bec6a9d0.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
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

   ASoC: da7219: Disable regulators on probe() failure

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

>From 9069bf9bc839d97e07fe17c336eab095c1065cec Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 22 Dec 2015 18:27:51 +0000
Subject: [PATCH] ASoC: da7219: Disable regulators on probe() failure

If codec probe() function fails after supplies have been enabled
it should really tidy up and disable them again. This patch updates
the probe function to do just that.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 319e794d27f6..9136a8b6f593 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1663,10 +1663,12 @@ static int da7219_probe(struct snd_soc_codec *codec)
 	/* Check if MCLK provided */
 	da7219->mclk = devm_clk_get(codec->dev, "mclk");
 	if (IS_ERR(da7219->mclk)) {
-		if (PTR_ERR(da7219->mclk) != -ENOENT)
-			return PTR_ERR(da7219->mclk);
-		else
+		if (PTR_ERR(da7219->mclk) != -ENOENT) {
+			ret = PTR_ERR(da7219->mclk);
+			goto err_disable_reg;
+		} else {
 			da7219->mclk = NULL;
+		}
 	}
 
 	/* Default PC counter to free-running */
@@ -1694,7 +1696,16 @@ static int da7219_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, DA7219_TONE_GEN_CYCLES, DA7219_BEEP_CYCLES_MASK);
 
 	/* Initialise AAD block */
-	return da7219_aad_init(codec);
+	ret = da7219_aad_init(codec);
+	if (ret)
+		goto err_disable_reg;
+
+	return 0;
+
+err_disable_reg:
+	regulator_bulk_disable(DA7219_NUM_SUPPLIES, da7219->supplies);
+
+	return ret;
 }
 
 static int da7219_remove(struct snd_soc_codec *codec)
-- 
2.6.2
