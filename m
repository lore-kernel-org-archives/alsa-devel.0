From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH] ALSA: Add support for TV-out to the jack
	reporting API
Date: Wed, 17 Dec 2008 14:04:33 +0200
Message-ID: <1229515473-24289-1-git-send-email-ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BA3A24131
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 13:04:27 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, ext-jani.1.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Add support for reporting new jack types SND_JACK_TVOUT and
SND_JACK_AVOUT (a combination of LINEOUT and TVOUT) to the jack
reporting API.

Also add the corresponding SW_TVOUT_INSERT switch to the input system
header.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 include/linux/input.h |    1 +
 include/sound/jack.h  |    2 ++
 sound/core/jack.c     |    6 ++++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index abd223b..ea5b224 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -646,6 +646,7 @@ struct input_absinfo {
 #define SW_DOCK			0x05  /* set = plugged into dock */
 #define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_JACK_PHYSICAL_INSERT 0x07  /* set = mechanical switch set */
+#define SW_TVOUT_INSERT		0x08  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
diff --git a/include/sound/jack.h b/include/sound/jack.h
index 2e0315c..69fc1f0 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -37,6 +37,8 @@ enum snd_jack_types {
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
 	SND_JACK_LINEOUT	= 0x0004,
 	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
+	SND_JACK_TVOUT		= 0x0010,
+	SND_JACK_AVOUT		= SND_JACK_LINEOUT | SND_JACK_TVOUT,
 };
 
 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 7ca905c..23c3f3e 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -105,6 +105,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (type & SND_JACK_LINEOUT)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_LINEOUT_INSERT);
+	if (type & SND_JACK_TVOUT)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_TVOUT_INSERT);
 	if (type & SND_JACK_MICROPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_MICROPHONE_INSERT);
@@ -162,6 +165,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_LINEOUT)
 		input_report_switch(jack->input_dev, SW_LINEOUT_INSERT,
 				    status & SND_JACK_LINEOUT);
+	if (jack->type & SND_JACK_TVOUT)
+		input_report_switch(jack->input_dev, SW_TVOUT_INSERT,
+				    status & SND_JACK_TVOUT);
 	if (jack->type & SND_JACK_MICROPHONE)
 		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
 				    status & SND_JACK_MICROPHONE);
-- 
1.6.0.4
