From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Add regmap patch to support old
	silicon" to the asoc tree
Date: Thu, 24 Dec 2015 19:18:07 +0000
Message-ID: <E1aCBOp-0008Pc-S7@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1289E260686
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 20:18:26 +0100 (CET)
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

   ASoC: da7219: Add regmap patch to support old silicon

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

>From abd7c894fc41a9a674354e10ed6c55413e1db077 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 23 Dec 2015 13:50:04 +0000
Subject: [PATCH] ASoC: da7219: Add regmap patch to support old silicon

Initial silicon did not have master bias enabled by default, unlike
later HW, so use regmap patch to align with newer defaults.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c6d3b32..9c7e8ec 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1592,9 +1592,14 @@ static void da7219_handle_pdata(struct snd_soc_codec *codec)
 	}
 }
 
+static struct reg_sequence da7219_rev_aa_patch[] = {
+	{ DA7219_REFERENCES, 0x08 },
+};
+
 static int da7219_probe(struct snd_soc_codec *codec)
 {
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+	unsigned int rev;
 	int ret;
 
 	mutex_init(&da7219->lock);
@@ -1604,6 +1609,26 @@ static int da7219_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
+	ret = regmap_read(da7219->regmap, DA7219_CHIP_REVISION, &rev);
+	if (ret) {
+		dev_err(codec->dev, "Failed to read chip revision: %d\n", ret);
+		goto err_disable_reg;
+	}
+
+	switch (rev & DA7219_CHIP_MINOR_MASK) {
+	case 0:
+		ret = regmap_register_patch(da7219->regmap, da7219_rev_aa_patch,
+					    ARRAY_SIZE(da7219_rev_aa_patch));
+		if (ret) {
+			dev_err(codec->dev, "Failed to register AA patch: %d\n",
+				ret);
+			goto err_disable_reg;
+		}
+		break;
+	default:
+		break;
+	}
+
 	/* Handle DT/Platform data */
 	if (codec->dev->of_node)
 		da7219->pdata = da7219_of_to_pdata(codec);
@@ -1774,7 +1799,6 @@ static struct reg_default da7219_reg_defaults[] = {
 	{ DA7219_MIXOUT_R_CTRL, 0x10 },
 	{ DA7219_CHIP_ID1, 0x23 },
 	{ DA7219_CHIP_ID2, 0x93 },
-	{ DA7219_CHIP_REVISION, 0x00 },
 	{ DA7219_IO_CTRL, 0x00 },
 	{ DA7219_GAIN_RAMP_CTRL, 0x00 },
 	{ DA7219_PC_COUNT, 0x02 },
-- 
2.6.4
