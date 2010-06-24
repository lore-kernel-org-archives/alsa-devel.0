From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: [PATCH 1/2] ASoC: uda134x: replace a macro with a
	value in platform struct.
Date: Thu, 24 Jun 2010 17:38:50 +0400
Message-ID: <1277386731-31160-1-git-send-email-vzapolskiy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 896F810381D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 15:39:21 +0200 (CEST)
Received: by bwz11 with SMTP id 11so141592bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 06:39:20 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Vladimir Zapolskiy <vzapolskiy@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This change wipes out a hardcoded macro, which enables codec bias
level control. Now is_powered_on_standby value shall be used instead.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
---
 include/sound/uda134x.h    |   12 ++++++++++++
 sound/soc/codecs/uda134x.c |   21 +++++----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/sound/uda134x.h b/include/sound/uda134x.h
index 509efb0..e475659 100644
--- a/include/sound/uda134x.h
+++ b/include/sound/uda134x.h
@@ -18,6 +18,18 @@ struct uda134x_platform_data {
 	struct l3_pins l3;
 	void (*power) (int);
 	int model;
+	/*
+	  ALSA SOC usually puts the device in standby mode when it's not used
+	  for sometime. If you unset is_powered_on_standby the driver will
+	  turn off the ADC/DAC when this callback is invoked and turn it back
+	  on when needed. Unfortunately this will result in a very light bump
+	  (it can be audible only with good earphones). If this bothers you
+	  set is_powered_on_standby, you will have slightly higher power
+	  consumption. Please note that sending the L3 command for ADC is
+	  enough to make the bump, so it doesn't make difference if you
+	  completely take off power from the codec.
+	*/
+	int is_powered_on_standby;
 #define UDA134X_UDA1340 1
 #define UDA134X_UDA1341 2
 #define UDA134X_UDA1344 3
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index e8066b6..5c7b054 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -27,19 +27,6 @@
 #include "uda134x.h"
 
 
-#define POWER_OFF_ON_STANDBY 1
-/*
-  ALSA SOC usually puts the device in standby mode when it's not used
-  for sometime. If you define POWER_OFF_ON_STANDBY the driver will
-  turn off the ADC/DAC when this callback is invoked and turn it back
-  on when needed. Unfortunately this will result in a very light bump
-  (it can be audible only with good earphones). If this bothers you
-  just comment this line, you will have slightly higher power
-  consumption . Please note that sending the L3 command for ADC is
-  enough to make the bump, so it doesn't make difference if you
-  completely take off power from the codec.
- */
-
 #define UDA134X_RATES SNDRV_PCM_RATE_8000_48000
 #define UDA134X_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S20_3LE)
@@ -559,9 +546,11 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 	codec->num_dai = 1;
 	codec->read = uda134x_read_reg_cache;
 	codec->write = uda134x_write;
-#ifdef POWER_OFF_ON_STANDBY
-	codec->set_bias_level = uda134x_set_bias_level;
-#endif
+
+	if (!pd->is_powered_on_standby) {
+		codec->set_bias_level = uda134x_set_bias_level;
+	}
+
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
-- 
1.7.0.4
