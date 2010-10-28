From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tpa6130a2: Fix unbalanced regulator
	disables
Date: Thu, 28 Oct 2010 14:05:40 +0300
Message-ID: <1288263940-4602-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 71585243D8
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Oct 2010 13:04:41 +0200 (CEST)
Received: by eyg24 with SMTP id 24so985948eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2010 04:04:37 -0700 (PDT)
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

This driver has unbalanced regulator_disable when doing module loading and
unloading. This is because tpa6130a2_probe followed by tpa6130a2_remove
calls twice tpa6130a2_power(0). Fix this by implementing a state checking
in tpa6130a2_power.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/tpa6130a2.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 329acc1..83b5631 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -125,7 +125,7 @@ static int tpa6130a2_power(int power)
 	data = i2c_get_clientdata(tpa6130a2_client);
 
 	mutex_lock(&data->mutex);
-	if (power) {
+	if (power && !data->power_state) {
 		/* Power on */
 		if (data->power_gpio >= 0)
 			gpio_set_value(data->power_gpio, 1);
@@ -153,7 +153,7 @@ static int tpa6130a2_power(int power)
 		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
 		val &= ~TPA6130A2_SWS;
 		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
-	} else {
+	} else if (!power && data->power_state) {
 		/* set SWS */
 		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
 		val |= TPA6130A2_SWS;
-- 
1.7.1
