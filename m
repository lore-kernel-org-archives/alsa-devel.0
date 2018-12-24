From: Alison Wang <alison.wang@nxp.com>
Subject: [PATCH] ASoC: sgtl5000: Allow SCLK pad drive strength to be changed
Date: Mon, 24 Dec 2018 15:42:04 +0800
Message-ID: <20181224074204.3895-1-alison.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: alison.wang@nxp.com
List-Id: alsa-devel@alsa-project.org

This patch introduces "sclk-strength" property to allow SCLK pad drive
strength to be changed via device tree.

When running playback test on LS1028ARDB, Tx Frame sync error interrupt
will occur sometimes. Some noises also exist. After changing SCLK pad
drive strength to the maximum value, the issues are gone.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 sound/soc/codecs/sgtl5000.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index add18d6..a6a4748 100644
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
1.7.1
