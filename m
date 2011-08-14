From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Correct revision display for WM1250-EV1
	module
Date: Sun, 14 Aug 2011 19:26:32 +0900
Message-ID: <1313317592-18839-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C80924859
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 12:26:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The hardware documentation uses revision numbers starting at 1.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm1250-ev1.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index a98a3ff1..4523c4c 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -74,7 +74,7 @@ static int __devinit wm1250_ev1_probe(struct i2c_client *i2c,
 		return -ENODEV;
 	}
 
-	dev_info(&i2c->dev, "revision %d\n", rev);
+	dev_info(&i2c->dev, "revision %d\n", rev + 1);
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm1250_ev1,
 				      &wm1250_ev1_dai, 1);
-- 
1.7.5.4
