From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: Add support for mechanical jack insertion
Date: Wed, 10 Dec 2008 13:55:49 +0000
Message-ID: <1228917349-31500-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E6B8244E4
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 14:55:51 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guillem Jover <guillem.jover@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some systems support both mechanical and electrical jack detection,
allowing them to report that a jack is physically present but does
not have any functioning connections. Add a new jack type for these,
allowing user space to report faulty connections.

Thanks to Guillem Jover for the suggestion.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/input.h |    1 +
 include/sound/jack.h  |    1 +
 sound/core/jack.c     |    6 ++++++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 1a958cd..9a6355f 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -660,6 +660,7 @@ struct input_absinfo {
 #define SW_MICROPHONE_INSERT	0x04  /* set = inserted */
 #define SW_DOCK			0x05  /* set = plugged into dock */
 #define SW_LINEOUT_INSERT	0x06  /* set = inserted */
+#define SW_JACK_PHYSICAL_INSERT 0x07  /* set = mechanical switch set */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
diff --git a/include/sound/jack.h b/include/sound/jack.h
index 7cb25f4..2e0315c 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -36,6 +36,7 @@ enum snd_jack_types {
 	SND_JACK_MICROPHONE	= 0x0002,
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
 	SND_JACK_LINEOUT	= 0x0004,
+	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
 };
 
 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 4978db1..7ca905c 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -108,6 +108,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (type & SND_JACK_MICROPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_MICROPHONE_INSERT);
+	if (type & SND_JACK_MECHANICAL)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_JACK_PHYSICAL_INSERT);
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
 	if (err < 0)
@@ -162,6 +165,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_MICROPHONE)
 		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
 				    status & SND_JACK_MICROPHONE);
+	if (jack->type & SND_JACK_MECHANICAL)
+		input_report_switch(jack->input_dev, SW_JACK_PHYSICAL_INSERT,
+				    status & SND_JACK_MECHANICAL);
 
 	input_sync(jack->input_dev);
 }
-- 
1.5.6.5
