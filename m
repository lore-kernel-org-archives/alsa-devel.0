From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: wm8741: check for error returns from
	wm8741_set_pdata()
Date: Wed, 20 May 2015 10:40:35 +0300
Message-ID: <20150520074035.GB18278@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 92DF426145E
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 09:40:55 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Static checkers complain that "ret" is always zero so the conditions are
never true.

The intention here was clearly to check for errors from
wm8741_set_pdata().  Although, since wm8741_set_pdata() never returns
errors, it doesn't affect runtime.

Fixes: c354b54cfdf6 ('ASoC: wm8741: Add differential mono mode support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index c065ea1..09ff01f 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -613,7 +613,7 @@ static int wm8741_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	wm8741_set_pdata(&i2c->dev, wm8741);
+	ret = wm8741_set_pdata(&i2c->dev, wm8741);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to set pdata: %d\n", ret);
 		return ret;
@@ -679,7 +679,7 @@ static int wm8741_spi_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	wm8741_set_pdata(&spi->dev, wm8741);
+	ret = wm8741_set_pdata(&spi->dev, wm8741);
 	if (ret != 0) {
 		dev_err(&spi->dev, "Failed to set pdata: %d\n", ret);
 		return ret;
