From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: [RFC PATCH 2/6] ASoC: sgtl5000: write all default
	registers
Date: Thu, 26 Feb 2015 15:54:29 -0700
Message-ID: <1424991273-10081-3-git-send-email-eric.nelson@boundarydevices.com>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E37B52614BB
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 23:54:44 +0100 (CET)
Received: by pdjy10 with SMTP id y10so16349339pdj.6
 for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2015 14:54:44 -0800 (PST)
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

If an error occurs writing defaults, produce an error message but
continue writing other registers. The failure of a single write should
not cause catastrophic device failure.

In at least one occurrence, I2C writes of CHIP_ANA_POWER was nacked,
though continuing allowed the device to operate properly.

A follow-up patch will remove CHIP_ANA_POWER from the set of default
registers.

Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
---
 sound/soc/codecs/sgtl5000.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8f755e8..2ac4db5 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1188,8 +1188,9 @@ static const struct regmap_config sgtl5000_regmap = {
  * and avoid problems like, not being able to probe after an audio playback
  * followed by a system reset or a 'reboot' command in Linux
  */
-static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
+static void sgtl5000_fill_defaults(struct i2c_client *client)
 {
+	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
 	int i, ret, val, index;
 
 	for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
@@ -1197,10 +1198,10 @@ static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
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
@@ -1333,9 +1334,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	}
 
 	/* Ensure sgtl5000 will start with sane register values */
-	ret = sgtl5000_fill_defaults(sgtl5000);
-	if (ret)
-		goto disable_clk;
+	sgtl5000_fill_defaults(client);
 
 	ret = snd_soc_register_codec(&client->dev,
 			&sgtl5000_driver, &sgtl5000_dai, 1);
-- 
1.9.1
