From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ALSA: Reduce boilerplate for new jack types
Date: Wed,  7 Jan 2009 20:18:30 +0000
Message-ID: <1231359511-7240-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090107201131.GA6413@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B98A51037E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 21:18:45 +0100 (CET)
In-Reply-To: <20090107201131.GA6413@sirena.org.uk>
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

Use a lookup table rather than explicit code to map input subsystem jack
types into ASoC ones, implemented as suggested by Takashi Iwai.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/jack.h |    3 +++
 sound/core/jack.c    |   44 ++++++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 2e0315c..85266a2 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -30,6 +30,9 @@ struct input_dev;
 /**
  * Jack types which can be reported.  These values are used as a
  * bitmask.
+ *
+ * Note that this must be kept in sync with the lookup table in
+ * sound/core/jack.c.
  */
 enum snd_jack_types {
 	SND_JACK_HEADPHONE	= 0x0001,
diff --git a/sound/core/jack.c b/sound/core/jack.c
index dd4a12d..b2da10c 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -23,6 +23,13 @@
 #include <sound/jack.h>
 #include <sound/core.h>
 
+static int jack_types[] = {
+	SW_HEADPHONE_INSERT,
+	SW_MICROPHONE_INSERT,
+	SW_LINEOUT_INSERT,
+	SW_JACK_PHYSICAL_INSERT,
+};
+
 static int snd_jack_dev_free(struct snd_device *device)
 {
 	struct snd_jack *jack = device->device_data;
@@ -79,6 +86,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 {
 	struct snd_jack *jack;
 	int err;
+	int i;
 	static struct snd_device_ops ops = {
 		.dev_free = snd_jack_dev_free,
 		.dev_register = snd_jack_dev_register,
@@ -100,18 +108,10 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 
 	jack->type = type;
 
-	if (type & SND_JACK_HEADPHONE)
-		input_set_capability(jack->input_dev, EV_SW,
-				     SW_HEADPHONE_INSERT);
-	if (type & SND_JACK_LINEOUT)
-		input_set_capability(jack->input_dev, EV_SW,
-				     SW_LINEOUT_INSERT);
-	if (type & SND_JACK_MICROPHONE)
-		input_set_capability(jack->input_dev, EV_SW,
-				     SW_MICROPHONE_INSERT);
-	if (type & SND_JACK_MECHANICAL)
-		input_set_capability(jack->input_dev, EV_SW,
-				     SW_JACK_PHYSICAL_INSERT);
+	for (i = 0; i < ARRAY_SIZE(jack_types); i++)
+		if (type & (1 << i))
+			input_set_capability(jack->input_dev, EV_SW,
+					     jack_types[i]);
 
 	err = snd_device_new(card, SNDRV_DEV_JACK, jack, &ops);
 	if (err < 0)
@@ -154,21 +154,17 @@ EXPORT_SYMBOL(snd_jack_set_parent);
  */
 void snd_jack_report(struct snd_jack *jack, int status)
 {
+	int i;
+
 	if (!jack)
 		return;
 
-	if (jack->type & SND_JACK_HEADPHONE)
-		input_report_switch(jack->input_dev, SW_HEADPHONE_INSERT,
-				    status & SND_JACK_HEADPHONE);
-	if (jack->type & SND_JACK_LINEOUT)
-		input_report_switch(jack->input_dev, SW_LINEOUT_INSERT,
-				    status & SND_JACK_LINEOUT);
-	if (jack->type & SND_JACK_MICROPHONE)
-		input_report_switch(jack->input_dev, SW_MICROPHONE_INSERT,
-				    status & SND_JACK_MICROPHONE);
-	if (jack->type & SND_JACK_MECHANICAL)
-		input_report_switch(jack->input_dev, SW_JACK_PHYSICAL_INSERT,
-				    status & SND_JACK_MECHANICAL);
+	for (i = 0; i < ARRAY_SIZE(jack_types); i++) {
+		int testbit = 1 << i;
+		if (jack->type & testbit)
+			input_report_switch(jack->input_dev, jack_types[i],
+					    status & testbit);
+	}
 
 	input_sync(jack->input_dev);
 }
-- 
1.5.6.3
