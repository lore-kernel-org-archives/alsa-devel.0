From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 13/15] ASoC: twl6040: Increase timeout for
	power up
Date: Mon, 6 Dec 2010 18:18:18 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B8D6710395D
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:18:20 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

After coming back from suspend, the timeout waiting for Phoenix
chip to complete its power up sequence is not enough, which leaves
the codec cache value for some registers in an outdated state.

Increase the timeout value to wait for the power up sequence
to correclty complete.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index bfb8dec..a8bad49 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1187,7 +1187,7 @@ static int twl6040_power_up_completion(struct snd_soc_codec *codec,
 	u8 intid;
 
 	time_left = wait_for_completion_timeout(&priv->ready,
-				msecs_to_jiffies(48));
+				msecs_to_jiffies(144));
 
 	if (!time_left) {
 		twl_i2c_read_u8(TWL_MODULE_AUDIO_VOICE, &intid,
-- 
1.7.0.4
