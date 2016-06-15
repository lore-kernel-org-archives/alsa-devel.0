From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Write all default registers"
	to the asoc tree
Date: Wed, 15 Jun 2016 15:38:33 +0100
Message-ID: <E1bDBxh-0006xN-O0@finisterre>
References: <1424991273-10081-3-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13D772657ED
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:38:46 +0200 (CEST)
In-Reply-To: <1424991273-10081-3-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric@nelint.com>
Cc: fabio.estevam@freescale.com, Clemens Gruber <clemens.gruber@pqgruber.com>, lars@metafoo.de, tiwai@suse.de, Eric Nelson <eric.nelson@boundarydevices.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, jean-michel.hautbois@vodalys.com, Fabio Estevam <fabio.estevam@nxp.com>, rmk+kernel@arm.linux.org.uk, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Write all default registers

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

>From f219b16959ee3df2fd49f09493b3f6b28487c416 Mon Sep 17 00:00:00 2001
From: Eric Nelson <eric@nelint.com>
Date: Tue, 7 Jun 2016 01:14:49 +0200
Subject: [PATCH] ASoC: sgtl5000: Write all default registers

If an error occurs writing defaults, produce an error message but
continue writing other registers. The failure of a single write should
not cause catastrophic device failure.

In at least one occurrence, I2C writes of CHIP_ANA_POWER were nacked,
though continuing allowed the device to operate properly.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 77bdd1daa322..56d61a212083 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1219,8 +1219,9 @@ static const struct regmap_config sgtl5000_regmap = {
  * and avoid problems like, not being able to probe after an audio playback
  * followed by a system reset or a 'reboot' command in Linux
  */
-static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
+static void sgtl5000_fill_defaults(struct i2c_client *client)
 {
+	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
 	int i, ret, val, index;
 
 	for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
@@ -1228,10 +1229,10 @@ static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
 		index = sgtl5000_reg_defaults[i].reg;
 		ret = regmap_write(sgtl5000->regmap, index, val);
 		if (ret)
-			return ret;
+			dev_err(&client->dev,
+				"%s: error %d setting reg 0x%02x to 0x%04x\n",
+				__func__, ret, index, val);
 	}
-
-	return 0;
 }
 
 static int sgtl5000_i2c_probe(struct i2c_client *client,
@@ -1364,9 +1365,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	}
 
 	/* Ensure sgtl5000 will start with sane register values */
-	ret = sgtl5000_fill_defaults(sgtl5000);
-	if (ret)
-		goto disable_clk;
+	sgtl5000_fill_defaults(client);
 
 	ret = snd_soc_register_codec(&client->dev,
 			&sgtl5000_driver, &sgtl5000_dai, 1);
-- 
2.8.1
