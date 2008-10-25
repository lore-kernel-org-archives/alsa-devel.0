From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH1/4] jack: lineout support to jack abstraction
	layer
Date: Sat, 25 Oct 2008 01:05:04 -0400
Message-ID: <4902A900.8080908@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 7B6FC2436E
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 07:05:38 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

This patch introduces support for reporting SW_LINEOUT_INSERT detection events
via the jack abstraction layer.

Also adds a SND_JACK_LINEOUT define to the input system header.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/include/linux/input.h b/include/linux/input.h
index b86fb55..fa9127d 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -657,6 +657,7 @@ struct input_absinfo {
 #define SW_RADIO		SW_RFKILL_ALL	/* deprecated */
 #define SW_MICROPHONE_INSERT	0x04  /* set = inserted */
 #define SW_DOCK			0x05  /* set = plugged into dock */
+#define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index b1b2b8b..7cb25f4 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -35,6 +35,7 @@ enum snd_jack_types {
 	SND_JACK_HEADPHONE	= 0x0001,
 	SND_JACK_MICROPHONE	= 0x0002,
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
+	SND_JACK_LINEOUT	= 0x0004,
 };

 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index bd2d9e6..4978db1 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -102,6 +102,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int
type,
 	if (type & SND_JACK_HEADPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_HEADPHONE_INSERT);
+	if (type & SND_JACK_LINEOUT)
+		input_set_capability(jack->input_dev, EV_SW,
+				     SW_LINEOUT_INSERT);
 	if (type & SND_JACK_MICROPHONE)
 		input_set_capability(jack->input_dev, EV_SW,
 				     SW_MICROPHONE_INSERT);
@@ -153,6 +156,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_HEADPHONE)
 		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
 				    status & SND_JACK_HEADPHONE);
+	if (jack->type & SND_JACK_LINEOUT)
+		input_report_switch(jack->input_dev, SW_LINEOUT_INSERT,
+				    status & SND_JACK_LINEOUT);
 	if (jack->type & SND_JACK_MICROPHONE)
 		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
 				    status & SND_JACK_MICROPHONE);
