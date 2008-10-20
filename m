From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH0/2] jack: Add support for SND_JACK_LINEOUT
Date: Mon, 20 Oct 2008 17:39:52 -0400
Message-ID: <48FCFAA8.8070005@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 11B3E24531
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 23:40:23 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Add support to the jack abstraction layer to report 'Line Out' presence insertions.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/include/linux/input.h b/include/linux/input.h
index a5802c9..7323d2f 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -644,6 +644,7 @@ struct input_absinfo {
 #define SW_RADIO		SW_RFKILL_ALL	/* deprecated */
 #define SW_MICROPHONE_INSERT	0x04  /* set = inserted */
 #define SW_DOCK			0x05  /* set = plugged into dock */
+#define SW_LINEOUT_INSERT	0x06  /* set = inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index b1b2b8b..67270ee 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -35,6 +35,8 @@ enum snd_jack_types {
 	SND_JACK_HEADPHONE	= 0x0001,
 	SND_JACK_MICROPHONE	= 0x0002,
 	SND_JACK_HEADSET	= SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,
+	SND_JACK_LINEOUT	= 0x0004,
+	SND_JACK_SWITCH		= SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
 };

 struct snd_jack {
diff --git a/sound/core/jack.c b/sound/core/jack.c
index bd2d9e6..284432f 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -34,6 +34,7 @@ static int snd_jack_dev_free(struct snd_device *device)
 	else
 		input_free_device(jack->input_dev);

+	kfree(jack->id);
 	kfree(jack);

 	return 0;
@@ -87,7 +88,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	if (jack == NULL)
 		return -ENOMEM;

-	jack->id = id;
+	jack->id = kstrdup(id, GFP_KERNEL);

 	jack->input_dev = input_allocate_device();
 	if (jack->input_dev == NULL) {
@@ -102,6 +103,9 @@ int snd_jack_new(struct snd_card *card, const char *id, int
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
@@ -153,6 +157,9 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (jack->type & SND_JACK_HEADPHONE)
 		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
 				    status & SND_JACK_HEADPHONE);
+	if (jack->type & SND_JACK_LINEOUT)
+		input_report_switch(jack->input_dev, SW_LINEOUT_INSERT,
+				    status & SND_JACK_LINEOUT);
 	if (jack->type & SND_JACK_MICROPHONE)
 		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
 				    status & SND_JACK_MICROPHONE);
