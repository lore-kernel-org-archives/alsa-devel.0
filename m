From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: jack: Unregister input device at
	disconnection
Date: Thu, 14 Nov 2013 15:49:40 +0100
Message-ID: <1384440580-29234-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EC5F261A27
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 15:49:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The recent change in sysfs triggered a kernel WARNING at unloading a
sound driver like

  WARNING: CPU: 3 PID: 2247 at fs/sysfs/group.c:214 sysfs_remove_group+0xe8/0xf0()
  sysfs group ffffffff81ab7b20 not found for kobject 'event14'

for each jack instance.  It's because the unregistration of jack input
device is done in dev_free callback, which is called after
snd_card_disconnect().  Since device_unregister(card->card_dev) is
called in snd_card_disconnect(), the whole sysfs entries belonging to
card->card_dev have been already removed recursively.  Thus this
results in a warning as input_unregister_device() yet tries to
unregister the already removed sysfs entry.

For fixing this mess, we need to unregister the jack input device at
dev_disconnect callback so that it's called before unregistering the
card->card_dev.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/jack.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index b35fe7345c20..8658578eb584 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -34,12 +34,12 @@ static int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
 	SW_LINEIN_INSERT,
 };
 
-static int snd_jack_dev_free(struct snd_device *device)
+static int snd_jack_dev_disconnect(struct snd_device *device)
 {
 	struct snd_jack *jack = device->device_data;
 
-	if (jack->private_free)
-		jack->private_free(jack);
+	if (!jack->input_dev)
+		return 0;
 
 	/* If the input device is registered with the input subsystem
 	 * then we need to use a different deallocator. */
@@ -47,6 +47,18 @@ static int snd_jack_dev_free(struct snd_device *device)
 		input_unregister_device(jack->input_dev);
 	else
 		input_free_device(jack->input_dev);
+	jack->input_dev = NULL;
+	return 0;
+}
+
+static int snd_jack_dev_free(struct snd_device *device)
+{
+	struct snd_jack *jack = device->device_data;
+
+	if (jack->private_free)
+		jack->private_free(jack);
+
+	snd_jack_dev_disconnect(device);
 
 	kfree(jack->id);
 	kfree(jack);
@@ -110,6 +122,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 	static struct snd_device_ops ops = {
 		.dev_free = snd_jack_dev_free,
 		.dev_register = snd_jack_dev_register,
+		.dev_disconnect = snd_jack_dev_disconnect,
 	};
 
 	jack = kzalloc(sizeof(struct snd_jack), GFP_KERNEL);
-- 
1.8.4.2
