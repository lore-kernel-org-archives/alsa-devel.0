From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Improve error handling for
	regulator supplies" to the asoc tree
Date: Mon, 05 Oct 2015 16:11:04 +0100
Message-ID: <E1Zj7Ps-0000uJ-V9@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BB6E26069D
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 17:11:28 +0200 (CEST)
In-Reply-To: 
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

   ASoC: da7219: Improve error handling for regulator supplies

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

>From 4e929134eb8271abc9c52c371e056debfea6898b Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 5 Oct 2015 15:10:04 +0100
Subject: [PATCH] ASoC: da7219: Improve error handling for regulator supplies

Currently if bulk_enable() of supplies fails, the code still goes on
to try and put the device into active state, and set expected IO
voltage of the device. This doesn't really make sense so code now
returns on bulk_enable() failure, with an error message. Also,
to help with debug, failure to get supplies also provides an error
message.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 76f8fc2..c86a833 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1554,8 +1554,10 @@ static int da7219_handle_supplies(struct snd_soc_codec *codec)
 
 	ret = devm_regulator_bulk_get(codec->dev, DA7219_NUM_SUPPLIES,
 				      da7219->supplies);
-	if (ret)
+	if (ret) {
+		dev_err(codec->dev, "Failed to get supplies");
 		return ret;
+	}
 
 	/* Determine VDDIO voltage provided */
 	vddio = da7219->supplies[DA7219_SUPPLY_VDDIO].consumer;
@@ -1567,6 +1569,10 @@ static int da7219_handle_supplies(struct snd_soc_codec *codec)
 
 	/* Enable main supplies */
 	ret = regulator_bulk_enable(DA7219_NUM_SUPPLIES, da7219->supplies);
+	if (ret) {
+		dev_err(codec->dev, "Failed to enable supplies");
+		return ret;
+	}
 
 	/* Ensure device in active mode */
 	snd_soc_write(codec, DA7219_SYSTEM_ACTIVE, DA7219_SYSTEM_ACTIVE_MASK);
@@ -1574,7 +1580,7 @@ static int da7219_handle_supplies(struct snd_soc_codec *codec)
 	/* Update IO voltage level range */
 	snd_soc_write(codec, DA7219_IO_CTRL, io_voltage_lvl);
 
-	return ret;
+	return 0;
 }
 
 static void da7219_handle_pdata(struct snd_soc_codec *codec)
-- 
2.5.0
