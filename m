From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ALSA: Rename jack switch table in
	preparation for button support
Date: Wed, 17 Mar 2010 18:23:14 +0000
Message-ID: <1268850195-18964-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100317182242.GA990@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1819A103836
	for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2010 19:23:22 +0100 (CET)
In-Reply-To: <20100317182242.GA990@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Avoids confusion when we have button support.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/core/jack.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index f705eec..f6f091f 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -23,7 +23,7 @@
 #include <sound/jack.h>
 #include <sound/core.h>
 
-static int jack_types[] = {
+static int jack_switch_types[] = {
 	SW_HEADPHONE_INSERT,
 	SW_MICROPHONE_INSERT,
 	SW_LINEOUT_INSERT,
@@ -112,10 +112,10 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 
 	jack->type = type;
 
-	for (i = 0; i < ARRAY_SIZE(jack_types); i++)
+	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++)
 		if (type & (1 << i))
 			input_set_capability(jack->input_dev, EV_SW,
-					     jack_types[i]);
+					     jack_switch_types[i]);
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
 	if (err < 0)
@@ -163,10 +163,11 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (!jack)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(jack_types); i++) {
+	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++) {
 		int testbit = 1 << i;
 		if (jack->type & testbit)
-			input_report_switch(jack->input_dev, jack_types[i],
+			input_report_switch(jack->input_dev,
+					    jack_switch_types[i],
 					    status & testbit);
 	}
 
-- 
1.7.0
