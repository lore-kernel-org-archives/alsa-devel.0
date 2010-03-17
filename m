From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ALSA: Add support for key reporting via
	the jack interface
Date: Wed, 17 Mar 2010 18:23:15 +0000
Message-ID: <1268850195-18964-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100317182242.GA990@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32462103841
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

Some devices provide support for detection of a small number of
buttons on their jacks. One common implementation provides a single
button, implemented by shorting the microphone to ground and detected
along with microphone presence detection by detecting varying current
draws on the microphone bias signal.

Provide support for up to three buttons via the jack interface. These
default to reporting BTN_n but an API is provided to allow these to
be remapped to other keys by the machine driver where it knows what
the keys are. More keys can be added with ease if required.

This is only intended to support simple accessory button designs. If
the interface is limiting then either creating a child device for the
accessory or accessing the input device in the jack directly is
recommended.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/jack.h |    8 ++++++
 sound/core/jack.c    |   60 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index f236e42..d90b9fa 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -42,6 +42,11 @@ enum snd_jack_types {
 	SND_JACK_MECHANICAL	= 0x0008, /* If detected separately */
 	SND_JACK_VIDEOOUT	= 0x0010,
 	SND_JACK_AVOUT		= SND_JACK_LINEOUT | SND_JACK_VIDEOOUT,
+
+	/* Kept separate from switches to facilitate implementation */
+	SND_JACK_BTN_0		= 0x4000,
+	SND_JACK_BTN_1		= 0x2000,
+	SND_JACK_BTN_2		= 0x1000,
 };
 
 struct snd_jack {
@@ -50,6 +55,7 @@ struct snd_jack {
 	int type;
 	const char *id;
 	char name[100];
+	unsigned int key[3];   /* Keep in sync with definitions above */
 	void *private_data;
 	void (*private_free)(struct snd_jack *);
 };
@@ -59,6 +65,8 @@ struct snd_jack {
 int snd_jack_new(struct snd_card *card, const char *id, int type,
 		 struct snd_jack **jack);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent);
+int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
+		     int keytype);
 
 void snd_jack_report(struct snd_jack *jack, int status);
 
diff --git a/sound/core/jack.c b/sound/core/jack.c
index f6f091f..3813e7b 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -55,7 +55,7 @@ static int snd_jack_dev_register(struct snd_device *device)
 {
 	struct snd_jack *jack = device->device_data;
 	struct snd_card *card = device->card;
-	int err;
+	int err, i;
 
 	snprintf(jack->name, sizeof(jack->name), "%s %s",
 		 card->shortname, jack->id);
@@ -65,6 +65,19 @@ static int snd_jack_dev_register(struct snd_device *device)
 	if (!jack->input_dev->dev.parent)
 		jack->input_dev->dev.parent = snd_card_get_device_link(card);
 
+	/* Add capabilities for any keys that are enabled */
+	for (i = 0; i < ARRAY_SIZE(jack->key); i++) {
+		int testbit = SND_JACK_BTN_0 >> i;
+
+		if (!(jack->type & testbit))
+			continue;
+
+		if (!jack->key[i])
+			jack->key[i] = BTN_0 + i;
+
+		input_set_capability(jack->input_dev, EV_KEY, jack->key[i]);
+	}
+
 	err = input_register_device(jack->input_dev);
 	if (err == 0)
 		jack->registered = 1;
@@ -151,6 +164,43 @@ void snd_jack_set_parent(struct snd_jack *jack, struct device *parent)
 EXPORT_SYMBOL(snd_jack_set_parent);
 
 /**
+ * snd_jack_set_key - Set a key mapping on a jack
+ *
+ * @jack:    The jack to configure
+ * @type:    Jack report type for this key
+ * @keytype: Input layer key type to be reported
+ *
+ * Map a SND_JACK_BTN_ button type to an input layer key, allowing
+ * reporting of keys on accessories via the jack abstraction.  If no
+ * mapping is provided but keys are enabled in the jack type then
+ * BTN_n numeric buttons will be reported.
+ *
+ * Note that this is intended to be use by simple devices with small
+ * numbers of keys that can be reported.  It is also possible to
+ * access the input device directly - devices with complex input
+ * capabilities on accessories should consider doing this rather than
+ * using this abstraction.
+ *
+ * This function may only be called prior to registration of the jack.
+ */
+int snd_jack_set_key(struct snd_jack *jack, enum snd_jack_types type,
+		     int keytype)
+{
+	int key = fls(SND_JACK_BTN_0) - fls(type);
+
+	WARN_ON(jack->registered);
+
+	if (!keytype || key >= ARRAY_SIZE(jack->key))
+		return -EINVAL;
+
+	jack->type |= type;
+	jack->key[key] = keytype;
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_jack_set_key);
+
+/**
  * snd_jack_report - Report the current status of a jack
  *
  * @jack:   The jack to report status for
@@ -163,6 +213,14 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	if (!jack)
 		return;
 
+	for (i = 0; i < ARRAY_SIZE(jack->key); i++) {
+		int testbit = SND_JACK_BTN_0 >> i;
+
+		if (jack->type & testbit)
+			input_report_key(jack->input_dev, jack->key[i],
+					 status & testbit);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++) {
 		int testbit = 1 << i;
 		if (jack->type & testbit)
-- 
1.7.0
