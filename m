From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Disable internal PLL early"
	to the asoc tree
Date: Wed, 15 Jun 2016 15:38:26 +0100
Message-ID: <E1bDBxa-0006vK-6n@finisterre>
References: <1424991273-10081-6-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B68D265546
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:38:43 +0200 (CEST)
In-Reply-To: <1424991273-10081-6-git-send-email-eric.nelson@boundarydevices.com>
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

   ASoC: sgtl5000: Disable internal PLL early

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

>From 08dea16e0960ea5caf7876045b747145cb677096 Mon Sep 17 00:00:00 2001
From: Eric Nelson <eric@nelint.com>
Date: Tue, 7 Jun 2016 01:14:51 +0200
Subject: [PATCH] ASoC: sgtl5000: Disable internal PLL early

To handle the soft reboot case, the internal PLL must be
disabled in SGTL5000_CHIP_CLK_CTRL before clearing bits
SGTL5000_VCOAMP_POWERUP and SGTL5000_PLL_POWERUP in
register SGTL5000_CHIP_ANA_POWER.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 9 ++++++++-
 sound/soc/codecs/sgtl5000.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 42f2eb62664e..0916bb46ccf2 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -38,7 +38,6 @@
 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_CHIP_DIG_POWER,		0x0000 },
-	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
 	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
 	{ SGTL5000_CHIP_SSS_CTRL,		0x0010 },
 	{ SGTL5000_CHIP_ADCDAC_CTRL,		0x020c },
@@ -1279,6 +1278,14 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
 	sgtl5000->revision = rev;
 
+	/* reconfigure the clocks in case we're using the PLL */
+	ret = regmap_write(sgtl5000->regmap,
+			   SGTL5000_CHIP_CLK_CTRL,
+			   SGTL5000_CHIP_CLK_CTRL_DEFAULT);
+	if (ret)
+		dev_err(&client->dev,
+			"Error %d initializing CHIP_CLK_CTRL\n", ret);
+
 	/* Follow section 2.2.1.1 of AN3663 */
 	ana_pwr = SGTL5000_ANA_POWER_DEFAULT;
 	if (sgtl5000->num_supplies <= VDDD) {
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 1be82379c689..22f3442af982 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -92,6 +92,7 @@
 /*
  * SGTL5000_CHIP_CLK_CTRL
  */
+#define SGTL5000_CHIP_CLK_CTRL_DEFAULT		0x0008
 #define SGTL5000_RATE_MODE_MASK			0x0030
 #define SGTL5000_RATE_MODE_SHIFT		4
 #define SGTL5000_RATE_MODE_WIDTH		2
-- 
2.8.1
