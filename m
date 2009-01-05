From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH] ALSA: Add support for video out to the jack
	reporting API
Date: Mon,  5 Jan 2009 10:37:22 +0200
Message-ID: <1231144642-7689-1-git-send-email-ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 64B5424341
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 09:37:05 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, ext-jani.1.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Add support for reporting new jack types SND_JACK_VIDEOOUT and
SND_JACK_AVOUT (a combination of LINEOUT and VIDEOOUT) to the jack
reporting API.

Also add the corresponding SW_VIDEOOUT_INSERT switch to the input system
header.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 include/linux/input.h |    1 +
 include/sound/jack.h  |    2 ++
 sound/core/jack.c     |    6 ++++++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 9a6355f..adc1332 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -661,6 +661,7 @@ struct input_absinfo {
 #define SW_DOCK			0x05  /* set = plugged into dock */
 #define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_JACK_PHYSICAL_INSERT 0x07  /* set = mechanical switch set */
+#define SW_VIDEOOUT_INSERT	0x08  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
diff --git a/include/sound/jack.h b/include/sound/jack.h
index 2e0315c..283c975 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -37,6 +37,8 @@ enum snd_jack_types {
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
 	SND_JACK_LINEOUT	= 0x0004,
 	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
+	SND_JACK_VIDEOOUT	= 0x0010,
+	SND_JACK_AVOUT		= SND_JACK_LINEOUT | SND_JACK_VIDEOOUT,
 };
 
 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index dd4a12d..e1de195 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -106,6 +106,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (type & SND_JACK_LINEOUT)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_LINEOUT_INSERT);
+	if (type & SND_JACK_VIDEOOUT)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_VIDEOOUT_INSERT);
 	if (type & SND_JACK_MICROPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_MICROPHONE_INSERT);
@@ -163,6 +166,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_LINEOUT)
 		input_report_switch(jack->input_dev, SW_LINEOUT_INSERT,
 				    status & SND_JACK_LINEOUT);
+	if (jack->type & SND_JACK_VIDEOOUT)
+		input_report_switch(jack->input_dev, SW_VIDEOOUT_INSERT,
+				    status & SND_JACK_VIDEOOUT);
 	if (jack->type & SND_JACK_MICROPHONE)
 		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
 				    status & SND_JACK_MICROPHONE);
-- 
1.6.0.4
