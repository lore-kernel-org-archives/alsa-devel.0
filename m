From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v1 11/15] ASoC: fsl_ssi: Setup AC97 in dai_probe()
Date: Tue, 19 Dec 2017 09:00:15 -0800
Message-ID: <1513702819-42310-12-git-send-email-nicoleotsuka@gmail.com>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, mail@maciej.szmigiero.name, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

AC97 configures some registers earlier to start a communication
with CODECs, so this patch moves those register settings to the
dai_probe() as well, along with other register configurations.

It also applies _fsl_ssi_set_dai_fmt() to AC97 only since other
formats would be configured via fsl_ssi_set_dai_fmt() directly.

Meanwhile, this patch adds fsl_ssi_dai_ac97_remove() to cleanup
some control bits for AC97.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4673709..2fdae78 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -977,9 +977,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, REG_SSI_SRCR, srcr);
 	regmap_write(regs, REG_SSI_SCR, scr);
 
-	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
-		fsl_ssi_setup_ac97(ssi);
-
 	return 0;
 }
 
@@ -1108,6 +1105,26 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 		regmap_update_bits(ssi->regs, REG_SSI_SCR,
 				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
 
+	/* AC97 should start earlier to communicate with CODECs */
+	if (fsl_ssi_is_ac97(ssi)) {
+		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		fsl_ssi_setup_ac97(ssi);
+	}
+
+	return 0;
+}
+
+/**
+ * Disable register bits for AC97
+ */
+static int fsl_ssi_dai_ac97_remove(struct snd_soc_dai *dai)
+{
+	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(dai);
+
+	regmap_write(ssi->regs, REG_SSI_SCR, 0);
+	regmap_write(ssi->regs, REG_SSI_SACNT, 0);
+	regmap_write(ssi->regs, REG_SSI_SOR, 0);
+
 	return 0;
 }
 
@@ -1147,6 +1164,7 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.bus_control = true,
 	.probe = fsl_ssi_dai_probe,
+	.remove = fsl_ssi_dai_ac97_remove,
 	.playback = {
 		.stream_name = "AC97 Playback",
 		.channels_min = 2,
@@ -1524,9 +1542,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
-	if (ssi->dai_fmt)
-		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
-
 	if (fsl_ssi_is_ac97(ssi)) {
 		u32 ssi_idx;
 
-- 
2.7.4
