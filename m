From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 12/16] ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
Date: Wed, 10 Jan 2018 22:43:11 -0800
Message-ID: <1515652995-15996-13-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org, arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

AC97 configures most of registers earlier to start a communication
with CODECs in order to successfully initialize CODEC. Currently,
_fsl_ssi_set_dai_fmt() and fsl_ssi_setup_ac97() are called to get
all SSI registers properly set.

Since now the driver has a fsl_ssi_hw_init() to handle all register
initial settings, this patch moves those register settings of AC97
to the fsl_ssi_hw_init() as well.

Meanwhile it applies _fsl_ssi_set_dai_fmt() call to AC97 only since
other formats would be configured via normal set_dai_fmt() directly.

This patch also adds fsl_ssi_hw_clean() to cleanup control bits for
AC97 in the platform remote() function.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 36e370e..178c192 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -982,9 +982,6 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, REG_SSI_SRCR, srcr);
 	regmap_write(regs, REG_SSI_SCR, scr);
 
-	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
-		fsl_ssi_setup_ac97(ssi);
-
 	return 0;
 }
 
@@ -1250,10 +1247,28 @@ static int fsl_ssi_hw_init(struct fsl_ssi *ssi)
 		regmap_update_bits(ssi->regs, REG_SSI_SCR,
 				   SSI_SCR_TCH_EN, SSI_SCR_TCH_EN);
 
+	/* AC97 should start earlier to communicate with CODECs */
+	if (fsl_ssi_is_ac97(ssi)) {
+		_fsl_ssi_set_dai_fmt(ssi->dev, ssi, ssi->dai_fmt);
+		fsl_ssi_setup_ac97(ssi);
+	}
+
 	return 0;
 }
 
 /**
+ * Clear SSI registers
+ */
+static void fsl_ssi_hw_clean(struct fsl_ssi *ssi)
+{
+	/* Disable registers for AC97 */
+	if (fsl_ssi_is_ac97(ssi)) {
+		regmap_write(ssi->regs, REG_SSI_SCR, 0);
+		regmap_write(ssi->regs, REG_SSI_SACNT, 0);
+		regmap_write(ssi->regs, REG_SSI_SOR, 0);
+	}
+}
+/**
  * Make every character in a string lower-case
  */
 static void make_lowercase(char *s)
@@ -1535,9 +1550,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 done:
-	if (ssi->dai_fmt)
-		_fsl_ssi_set_dai_fmt(dev, ssi, ssi->dai_fmt);
-
 	/* Initially configures SSI registers */
 	fsl_ssi_hw_init(ssi);
 
@@ -1582,6 +1594,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 {
 	struct fsl_ssi *ssi = dev_get_drvdata(&pdev->dev);
 
+	fsl_ssi_hw_clean(ssi);
+
 	fsl_ssi_debugfs_remove(&ssi->dbg_stats);
 
 	if (ssi->pdev)
-- 
2.7.4
