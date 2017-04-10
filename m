From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Allow LRCLK pad drive
	strength to be changed" to the asoc tree
Date: Mon, 10 Apr 2017 20:22:33 +0100
Message-ID: <E1cxetV-0005jz-Rw@debutante>
References: <1491402754-19802-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC9CD266C13
 for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2017 21:22:47 +0200 (CEST)
In-Reply-To: <1491402754-19802-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, max.krummenacher@toradex.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Allow LRCLK pad drive strength to be changed

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

>From 570c70a60f53ca737ead4e5966c446bf0d39fac9 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 5 Apr 2017 11:32:34 -0300
Subject: [PATCH] ASoC: sgtl5000: Allow LRCLK pad drive strength to be changed

Introduce the "lrclk-strength" property to allow LRCLK pad drive strength
to be changed via device tree.

When running a stress playback loop test on a mx6dl wandboard channel
swap can be noticed on about 10% of the times.

While debugging this issue I noticed that when probing the SGTL5000
LRCLK pin with the scope the swap did not happen. After removing
the probe the swap started to happen again.

After changing the LRCLK pad drive strength to the maximum value the
issue is gone.

Same fix works on a mx6dl Colibri board as well.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt |  9 +++++++++
 sound/soc/codecs/sgtl5000.c                          | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 5666da7b8605..7a73a9d62015 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -26,6 +26,15 @@ Optional properties:
 	If this node is not mentioned or the value is unknown, then
 	the value is set to 1.25V.
 
+- lrclk-strength: the LRCLK pad strength. Possible values are:
+0, 1, 2 and 3 as per the table below:
+
+VDDIO		1.8V		2.5V		3.3V
+0 = 		Disable
+1 =		1.66 mA		2.87 mA		4.02  mA
+2 =		3.33 mA		5.74 mA		8.03  mA
+3 =		4.99 mA		8.61 mA		12.05 mA
+
 Example:
 
 codec: sgtl5000@0a {
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1589325855bc..5a2702edeb77 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -99,6 +99,13 @@ enum sgtl5000_micbias_resistor {
 	SGTL5000_MICBIAS_8K = 8,
 };
 
+enum  {
+	I2S_LRCLK_STRENGTH_DISABLE,
+	I2S_LRCLK_STRENGTH_LOW,
+	I2S_LRCLK_STRENGTH_MEDIUM,
+	I2S_LRCLK_STRENGTH_HIGH,
+};
+
 /* sgtl5000 private structure in codec */
 struct sgtl5000_priv {
 	int sysclk;	/* sysclk rate */
@@ -111,6 +118,7 @@ struct sgtl5000_priv {
 	int revision;
 	u8 micbias_resistor;
 	u8 micbias_voltage;
+	u8 lrclk_strength;
 };
 
 /*
@@ -1089,6 +1097,7 @@ static int sgtl5000_enable_regulators(struct i2c_client *client)
 static int sgtl5000_probe(struct snd_soc_codec *codec)
 {
 	int ret;
+	u16 reg;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
 	/* power up sgtl5000 */
@@ -1118,7 +1127,8 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 			SGTL5000_DAC_MUTE_RIGHT |
 			SGTL5000_DAC_MUTE_LEFT);
 
-	snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, 0x015f);
+	reg = ((sgtl5000->lrclk_strength) << SGTL5000_PAD_I2S_LRCLK_SHIFT | 0x5f);
+	snd_soc_write(codec, SGTL5000_CHIP_PAD_STRENGTH, reg);
 
 	snd_soc_write(codec, SGTL5000_CHIP_ANA_CTRL,
 			SGTL5000_HP_ZCD_EN |
@@ -1347,6 +1357,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		}
 	}
 
+	sgtl5000->lrclk_strength = I2S_LRCLK_STRENGTH_LOW;
+	if (!of_property_read_u32(np, "lrclk-strength", &value)) {
+		if (value > I2S_LRCLK_STRENGTH_HIGH)
+			value = I2S_LRCLK_STRENGTH_LOW;
+		sgtl5000->lrclk_strength = value;
+	}
+
 	/* Ensure sgtl5000 will start with sane register values */
 	sgtl5000_fill_defaults(client);
 
-- 
2.11.0
