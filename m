From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ALSA: Use a define for the number of jack
	switch types
Date: Tue,  7 Feb 2012 19:48:47 +0000
Message-ID: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A3A2103CD4
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 20:48:55 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is intended to facilitate the merge of the two jack detection
mechanisms.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/jack.h |    3 +++
 sound/core/jack.c    |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 63c7907..5891657 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -53,6 +53,9 @@ enum snd_jack_types {
 	SND_JACK_BTN_5		= 0x0200,
 };
 
+/* Keep in sync with definitions above */
+#define SND_JACK_SWITCH_TYPES 6
+
 struct snd_jack {
 	struct input_dev *input_dev;
 	int registered;
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 26edf63..471e1e3 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -25,7 +25,7 @@
 #include <sound/jack.h>
 #include <sound/core.h>
 
-static int jack_switch_types[] = {
+static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
 	SW_HEADPHONE_INSERT,
 	SW_MICROPHONE_INSERT,
 	SW_LINEOUT_INSERT,
@@ -128,7 +128,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 
 	jack->type = type;
 
-	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++)
+	for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
 		if (type & (1 << i))
 			input_set_capability(jack->input_dev, EV_SW,
 					     jack_switch_types[i]);
-- 
1.7.9.rc1
