From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: uda134x: Remove
	is_powered_on_standby from platform data
Date: Sun, 23 Nov 2014 15:04:12 +0100
Message-ID: <1416751454-16916-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 6198B2615F7
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 15:04:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

According to its documentation the is_powered_on_standby field of the
uda134x platform data is supposed to prevent the the driver from shutting
down the ADC and DAC in standby mode. This behavior was broken in commit
commit f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support")
almost 5 years ago and all the flag does now is cause the driver to go to
SND_SOC_BIAS_ON in probe, just for the ASoC core to put it back into
SND_SOC_BIAS_STANDBY right after probe.

Apparently the intended behavior has not been missed, so just remove
is_powered_on_standby from the platform data struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/uda134x.h    | 12 ------------
 sound/soc/codecs/uda134x.c |  5 +----
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/sound/uda134x.h b/include/sound/uda134x.h
index e475659..509efb0 100644
--- a/include/sound/uda134x.h
+++ b/include/sound/uda134x.h
@@ -18,18 +18,6 @@ struct uda134x_platform_data {
 	struct l3_pins l3;
 	void (*power) (int);
 	int model;
-	/*
-	  ALSA SOC usually puts the device in standby mode when it's not used
-	  for sometime. If you unset is_powered_on_standby the driver will
-	  turn off the ADC/DAC when this callback is invoked and turn it back
-	  on when needed. Unfortunately this will result in a very light bump
-	  (it can be audible only with good earphones). If this bothers you
-	  set is_powered_on_standby, you will have slightly higher power
-	  consumption. Please note that sending the L3 command for ADC is
-	  enough to make the bump, so it doesn't make difference if you
-	  completely take off power from the codec.
-	*/
-	int is_powered_on_standby;
 #define UDA134X_UDA1340 1
 #define UDA134X_UDA1341 2
 #define UDA134X_UDA1344 3
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 32b2f78..54240f1 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -518,10 +518,7 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 
 	uda134x_reset(codec);
 
-	if (pd->is_powered_on_standby)
-		uda134x_set_bias_level(codec, SND_SOC_BIAS_ON);
-	else
-		uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	if (pd->model == UDA134X_UDA1341) {
 		widgets = uda1341_dapm_widgets;
-- 
1.8.0
