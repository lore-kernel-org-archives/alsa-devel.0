From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix warning in WM1250-EV1 driver
Date: Wed, 10 Aug 2011 00:25:38 +0900
Message-ID: <1312903538-21151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BEBAB24478
	for <alsa-devel@Alsa-project.org>;
	Tue,  9 Aug 2011 17:25:43 +0200 (CEST)
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
Cc: alsa-devel@Alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm1250-ev1.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index bbcf9ec..a98a3ff1 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -58,12 +58,12 @@ static struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
 static int __devinit wm1250_ev1_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *i2c_id)
 {
-	int ret, id, board, rev;
+	int id, board, rev;
 
 	board = i2c_smbus_read_byte_data(i2c, 0);
 	if (board < 0) {
-		dev_err(&i2c->dev, "Failed to read ID: %d\n", ret);
-		return ret;
+		dev_err(&i2c->dev, "Failed to read ID: %d\n", board);
+		return board;
 	}
 
 	id = (board & 0xfe) >> 2;
-- 
1.7.5.4
