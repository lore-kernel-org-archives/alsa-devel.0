From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/14] ALSA: Add a helper to initialize device
Date: Mon,  2 Feb 2015 11:24:27 +0100
Message-ID: <1422872678-4815-4-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 75FBD26050C
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AD342ACA9
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:39 +0000 (UTC)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Introduce a new helper function snd_device_initialize() to initialize
the device object for sound devices.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  2 ++
 sound/core/init.c    | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/sound/core.h b/include/sound/core.h
index 39d14234961d..de7a878217d7 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -207,6 +207,8 @@ extern struct class *sound_class;
 
 void snd_request_card(int card);
 
+void snd_device_initialize(struct device *dev, struct snd_card *card);
+
 int snd_register_device_for_dev(int type, struct snd_card *card, int dev,
 				const struct file_operations *f_ops,
 				void *private_data, struct device *device,
diff --git a/sound/core/init.c b/sound/core/init.c
index 074875d68c15..2f730efe97b6 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -157,6 +157,25 @@ static int get_slot_from_bitmask(int mask, int (*check)(struct module *, int),
 	return mask; /* unchanged */
 }
 
+static void default_release(struct device *dev)
+{
+}
+
+/**
+ * snd_device_initialize - Initialize struct device for sound devices
+ * @dev: device to initialize
+ * @card: card to assign, optional
+ */
+void snd_device_initialize(struct device *dev, struct snd_card *card)
+{
+	device_initialize(dev);
+	if (card)
+		dev->parent = &card->card_dev;
+	dev->class = sound_class;
+	dev->release = default_release;
+}
+EXPORT_SYMBOL_GPL(snd_device_initialize);
+
 static int snd_card_do_free(struct snd_card *card);
 static const struct attribute_group *card_dev_attr_groups[];
 
-- 
2.2.2
