From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Parse board ID/revision information from
	WM1250-EV1 board
Date: Fri, 29 Jul 2011 16:28:25 +0100
Message-ID: <1311953305-13007-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9941E1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 17:28:35 +0200 (CEST)
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

The WM1250-EV1 board has an ID chip on it, check the board ID and display
the board revision during startup.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm1250-ev1.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index bcc2089..bbcf9ec 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -56,8 +56,26 @@ static struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
 };
 
 static int __devinit wm1250_ev1_probe(struct i2c_client *i2c,
-				      const struct i2c_device_id *id)
+				      const struct i2c_device_id *i2c_id)
 {
+	int ret, id, board, rev;
+
+	board = i2c_smbus_read_byte_data(i2c, 0);
+	if (board < 0) {
+		dev_err(&i2c->dev, "Failed to read ID: %d\n", ret);
+		return ret;
+	}
+
+	id = (board & 0xfe) >> 2;
+	rev = board & 0x3;
+
+	if (id != 1) {
+		dev_err(&i2c->dev, "Unknown board ID %d\n", id);
+		return -ENODEV;
+	}
+
+	dev_info(&i2c->dev, "revision %d\n", rev);
+
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm1250_ev1,
 				      &wm1250_ev1_dai, 1);
 }
-- 
1.7.5.4
