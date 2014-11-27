From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] ASoC: sgtl5000: Remove MCLK restriction
Date: Thu, 27 Nov 2014 13:02:00 -0200
Message-ID: <1417100521-8483-2-git-send-email-festevam@gmail.com>
References: <1417100521-8483-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id EF1002661A7
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 16:02:26 +0100 (CET)
Received: by mail-qg0-f54.google.com with SMTP id q107so3616499qgd.13
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 07:02:26 -0800 (PST)
In-Reply-To: <1417100521-8483-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, craig.mcqueen@beamcommunications.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to the sgtl5000 datasheet the MCLK frequency range restriction of
8 to 27 MHz only applies when the PLL is used - synchronous SYS_MCLK input mode.

When running the codec as slave, the master should generate MCLK in the range of
256*fs, 384*fs or 512*fs, which is called asynchronous SYS_MCLK input mode.

In asynchronous SYS_MCLK we cannot have the 8 to 27 MHz check because if we
want to play a 8KHz sample rate track, with a MCLK of 8k * 512 = 4.096MHz the
current check would return -EINVAL, which is not correct.

Remove the 8 to 27MHz frequency check, since this only applies to the 
synchronous SYS_MCLK input case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 600c072..8dea6b3 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1434,7 +1434,6 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 {
 	struct sgtl5000_priv *sgtl5000;
 	int ret, reg, rev;
-	unsigned int mclk;
 	struct device_node *np = client->dev.of_node;
 	u32 value;
 
@@ -1459,14 +1458,6 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/* SGTL5000 SYS_MCLK should be between 8 and 27 MHz */
-	mclk = clk_get_rate(sgtl5000->mclk);
-	if (mclk < 8000000 || mclk > 27000000) {
-		dev_err(&client->dev, "Invalid SYS_CLK frequency: %u.%03uMHz\n",
-			mclk / 1000000, mclk / 1000 % 1000);
-		return -EINVAL;
-	}
-
 	ret = clk_prepare_enable(sgtl5000->mclk);
 	if (ret)
 		return ret;
-- 
1.9.1
