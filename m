From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [RFC PATCH 5/6] ASoC: sgtl5000: disable internal PLL
	early
Date: Thu, 26 Feb 2015 15:54:32 -0700
Message-ID: <1424991273-10081-6-git-send-email-eric.nelson@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 0968126149E
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 23:54:54 +0100 (CET)
Received: by pabrd3 with SMTP id rd3so17591403pab.1
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 14:54:51 -0800 (PST)
In-Reply-To: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: fabio.estevam@freescale.com, lars@metafoo.de, tiwai@suse.de, Eric Nelson <eric.nelson@boundarydevices.com>, lgirdwood@gmail.com, broonie@kernel.org, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

To handle the soft reboot case, the internal PLL must be
disabled in SGTL5000_CHIP_CLK_CTRL before clearing bits
SGTL5000_VCOAMP_POWERUP and SGTL5000_PLL_POWERUP in
register SGTL5000_CHIP_ANA_POWER.

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 sound/soc/codecs/sgtl5000.c | 9 ++++++++-
 sound/soc/codecs/sgtl5000.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index c373991..5f7dd5d 100644
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
@@ -1248,6 +1247,14 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
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
index 6fdc589..a97e3f4 100644
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
1.9.1
