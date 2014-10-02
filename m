From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Do a sanity check on SYS_MCLK
Date: Thu,  2 Oct 2014 17:36:05 -0300
Message-ID: <1412282165-1500-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f43.google.com (mail-yh0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 57F3226167D
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 22:36:38 +0200 (CEST)
Received: by mail-yh0-f43.google.com with SMTP id f10so993752yha.30
 for <alsa-devel@alsa-project.org>; Thu, 02 Oct 2014 13:36:37 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to the sgtl5000 datasheet the valid range for SYS_MCLK is from 8 to
27 MHz.

Add a sanity check prior to enabling SYS_MCLK.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index a604a22..1470437 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1414,6 +1414,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 {
 	struct sgtl5000_priv *sgtl5000;
 	int ret, reg, rev;
+	unsigned int mclk;
 
 	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
 								GFP_KERNEL);
@@ -1437,6 +1438,14 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* SGTL5000 SYS_MCLK should be between 8 and 27 MHz */
+	mclk = clk_get_rate(sgtl5000->mclk);
+	if (mclk < 8000000 || mclk > 27000000) {
+		dev_err(&client->dev, "Invalid SYS_CLK frequency: %u.%03uMHz\n",
+			mclk / 1000000, mclk / 1000 % 1000);
+		return -EINVAL;
+	}
+
 	ret = clk_prepare_enable(sgtl5000->mclk);
 	if (ret)
 		return ret;
-- 
1.9.1
