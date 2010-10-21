From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: tpa6130a2: Error handling for broken chip
Date: Thu, 21 Oct 2010 15:03:03 +0300
Message-ID: <1287662583-17809-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C2FB24386
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 14:03:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Correct/Implement handling of broken chip.
Fail the i2c_prope if the communication with the chip
fails.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 99b70e5..329acc1 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -98,16 +98,21 @@ static u8 tpa6130a2_read(int reg)
 	return data->regs[reg];
 }
 
-static void tpa6130a2_initialize(void)
+static int tpa6130a2_initialize(void)
 {
 	struct tpa6130a2_data *data;
-	int i;
+	int i, ret = 0;
 
 	BUG_ON(tpa6130a2_client == NULL);
 	data = i2c_get_clientdata(tpa6130a2_client);
 
-	for (i = 1; i < TPA6130A2_REG_VERSION; i++)
-		tpa6130a2_i2c_write(i, data->regs[i]);
+	for (i = 1; i < TPA6130A2_REG_VERSION; i++) {
+		ret = tpa6130a2_i2c_write(i, data->regs[i]);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
 }
 
 static int tpa6130a2_power(int power)
@@ -133,7 +138,16 @@ static int tpa6130a2_power(int power)
 		}
 
 		data->power_state = 1;
-		tpa6130a2_initialize();
+		ret = tpa6130a2_initialize();
+		if (ret < 0) {
+			dev_err(&tpa6130a2_client->dev,
+				"Failed to initialize chip\n");
+			if (data->power_gpio >= 0)
+				gpio_set_value(data->power_gpio, 0);
+			regulator_disable(data->supply);
+			data->power_state = 0;
+			goto exit;
+		}
 
 		/* Clear SWS */
 		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
@@ -375,7 +389,9 @@ int tpa6130a2_add_controls(struct snd_soc_codec *codec)
 {
 	struct	tpa6130a2_data *data;
 
-	BUG_ON(tpa6130a2_client == NULL);
+	if (tpa6130a2_client == NULL)
+		return -ENODEV;
+
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	snd_soc_dapm_new_controls(codec, tpa6130a2_dapm_widgets,
-- 
1.7.3.1
