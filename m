From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Allow SCLK pad drive strength
	to be changed" to the asoc tree
Date: Mon,  7 Jan 2019 18:57:40 +0000 (GMT)
Message-ID: <20190107185740.6A32A1127491@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 79136266AD7
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:57:41 +0100 (CET)
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
To: Alison Wang <alison.wang@nxp.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Allow SCLK pad drive strength to be changed

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5dc4ca2996840db569e43d00420c10499140274a Mon Sep 17 00:00:00 2001
From: Alison Wang <alison.wang@nxp.com>
Date: Wed, 26 Dec 2018 08:59:53 +0800
Subject: [PATCH] ASoC: sgtl5000: Allow SCLK pad drive strength to be changed

This patch introduces "sclk-strength" property to allow SCLK pad drive
strength to be changed via device tree.

When running playback test on LS1028ARDB, Tx Frame sync error interrupt
will occur sometimes. Some noises also exist. After changing SCLK pad
drive strength to the maximum value, the issues are gone.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sgtl5000.txt    |  9 +++++++++
 sound/soc/codecs/sgtl5000.c                   | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9c58f724396a..9d9ff5184939 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -37,6 +37,15 @@ VDDIO		1.8V		2.5V		3.3V
 2 =		3.33 mA		5.74 mA		8.03  mA
 3 =		4.99 mA		8.61 mA		12.05 mA
 
+- sclk-strength: the SCLK pad strength. Possible values are:
+0, 1, 2 and 3 as per the table below:
+
+VDDIO		1.8V		2.5V		3.3V
+0 = 		Disable
+1 =		1.66 mA		2.87 mA		4.02  mA
+2 =		3.33 mA		5.74 mA		8.03  mA
+3 =		4.99 mA		8.61 mA		12.05 mA
+
 Example:
 
 sgtl5000: codec@a {
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index add18d6d77da..a6a4748c97f9 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -116,6 +116,13 @@ enum  {
 	I2S_LRCLK_STRENGTH_HIGH,
 };
 
+enum  {
+	I2S_SCLK_STRENGTH_DISABLE,
+	I2S_SCLK_STRENGTH_LOW,
+	I2S_SCLK_STRENGTH_MEDIUM,
+	I2S_SCLK_STRENGTH_HIGH,
+};
+
 /* sgtl5000 private structure in codec */
 struct sgtl5000_priv {
 	int sysclk;	/* sysclk rate */
@@ -129,6 +136,7 @@ struct sgtl5000_priv {
 	u8 micbias_resistor;
 	u8 micbias_voltage;
 	u8 lrclk_strength;
+	u8 sclk_strength;
 };
 
 /*
@@ -1302,7 +1310,9 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 			SGTL5000_DAC_MUTE_RIGHT |
 			SGTL5000_DAC_MUTE_LEFT);
 
-	reg = ((sgtl5000->lrclk_strength) << SGTL5000_PAD_I2S_LRCLK_SHIFT | 0x5f);
+	reg = ((sgtl5000->lrclk_strength) << SGTL5000_PAD_I2S_LRCLK_SHIFT |
+	       (sgtl5000->sclk_strength) << SGTL5000_PAD_I2S_SCLK_SHIFT |
+	       0x1f);
 	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH, reg);
 
 	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
@@ -1542,6 +1552,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		sgtl5000->lrclk_strength = value;
 	}
 
+	sgtl5000->sclk_strength = I2S_SCLK_STRENGTH_LOW;
+	if (!of_property_read_u32(np, "sclk-strength", &value)) {
+		if (value > I2S_SCLK_STRENGTH_HIGH)
+			value = I2S_SCLK_STRENGTH_LOW;
+		sgtl5000->sclk_strength = value;
+	}
+
 	/* Ensure sgtl5000 will start with sane register values */
 	sgtl5000_fill_defaults(client);
 
-- 
2.20.1
