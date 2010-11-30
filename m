From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/5] ASoC: tpa6130a2: Simplify power state
	management
Date: Tue, 30 Nov 2010 16:00:00 +0200
Message-ID: <1291125604-10396-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id BBE8B103973
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 15:00:12 +0100 (CET)
In-Reply-To: <1291125604-10396-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Use simpler way to avoid setting the same power state
for the amplifier.
Simplifies the check introduced by patch:
ASoC: tpa6130a2: Fix unbalanced regulator disables

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tpa6130a2.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 9d61a1d..199edf0 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -41,7 +41,7 @@ struct tpa6130a2_data {
 	unsigned char regs[TPA6130A2_CACHEREGNUM];
 	struct regulator *supply;
 	int power_gpio;
-	unsigned char power_state;
+	u8 power_state:1;
 	enum tpa_model id;
 };
 
@@ -116,7 +116,7 @@ static int tpa6130a2_initialize(void)
 	return ret;
 }
 
-static int tpa6130a2_power(int power)
+static int tpa6130a2_power(u8 power)
 {
 	struct	tpa6130a2_data *data;
 	u8	val;
@@ -126,8 +126,10 @@ static int tpa6130a2_power(int power)
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	mutex_lock(&data->mutex);
-	if (power && !data->power_state) {
+	if (power == data->power_state)
+		goto exit;
 
+	if (power) {
 		ret = regulator_enable(data->supply);
 		if (ret != 0) {
 			dev_err(&tpa6130a2_client->dev,
@@ -154,7 +156,7 @@ static int tpa6130a2_power(int power)
 		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
 		val &= ~TPA6130A2_SWS;
 		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
-	} else if (!power && data->power_state) {
+	} else {
 		/* set SWS */
 		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
 		val |= TPA6130A2_SWS;
-- 
1.7.3.2
