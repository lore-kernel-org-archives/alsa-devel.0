From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tpa6130a2: Revisit power-up sequence
Date: Mon,  8 Nov 2010 10:57:57 +0200
Message-ID: <1289206677-11886-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 935C12433F
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 09:57:48 +0100 (CET)
Received: by ewy22 with SMTP id 22so2768126ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2010 00:57:48 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

There are no known problems with current power-up sequence which first sets
the /shutdown pin high and then enables the supply. However, swap the order
so that the device is kept in shutdown/reset mode during the supply voltage
transition since slowly rising voltages can usually cause problems if the
device is not kept in reset.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index f9a92ea..9b98107 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -126,16 +126,15 @@ static int tpa6130a2_power(int power)
 
 	mutex_lock(&data->mutex);
 	if (power && !data->power_state) {
-		/* Power on */
-		if (data->power_gpio >= 0)
-			gpio_set_value(data->power_gpio, 1);
-
 		ret = regulator_enable(data->supply);
 		if (ret != 0) {
 			dev_err(&tpa6130a2_client->dev,
 				"Failed to enable supply: %d\n", ret);
 			goto exit;
 		}
+		/* Power on */
+		if (data->power_gpio >= 0)
+			gpio_set_value(data->power_gpio, 1);
 
 		data->power_state = 1;
 		ret = tpa6130a2_initialize();
-- 
1.7.2.3
