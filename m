From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: Use static groups for id and number
	card sysfs attr files
Date: Wed, 12 Feb 2014 12:20:12 +0100
Message-ID: <1392204013-12334-3-git-send-email-tiwai@suse.de>
References: <1392204013-12334-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E4342650C1
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:20:14 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8D427ABF7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:20:14 +0000 (UTC)
In-Reply-To: <1392204013-12334-1-git-send-email-tiwai@suse.de>
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

... instead of calling device_create_file() manually.
No functional change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 2c0301811828..46a9e7cb1c04 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -157,6 +157,7 @@ static int get_slot_from_bitmask(int mask, int (*check)(struct module *, int),
 }
 
 static int snd_card_do_free(struct snd_card *card);
+static const struct attribute_group *card_dev_attr_groups[];
 
 static void release_card_device(struct device *dev)
 {
@@ -245,6 +246,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	card->card_dev.parent = parent;
 	card->card_dev.class = sound_class;
 	card->card_dev.release = release_card_device;
+	card->card_dev.groups = card_dev_attr_groups;
 	err = kobject_set_name(&card->card_dev.kobj, "card%d", idx);
 	if (err < 0)
 		goto __error;
@@ -671,8 +673,7 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static struct device_attribute card_id_attrs =
-	__ATTR(id, S_IRUGO | S_IWUSR, card_id_show_attr, card_id_store_attr);
+static DEVICE_ATTR(id, S_IRUGO | S_IWUSR, card_id_show_attr, card_id_store_attr);
 
 static ssize_t
 card_number_show_attr(struct device *dev,
@@ -682,8 +683,22 @@ card_number_show_attr(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%i\n", card ? card->number : -1);
 }
 
-static struct device_attribute card_number_attrs =
-	__ATTR(number, S_IRUGO, card_number_show_attr, NULL);
+static DEVICE_ATTR(number, S_IRUGO, card_number_show_attr, NULL);
+
+static struct attribute *card_dev_attrs[] = {
+	&dev_attr_id.attr,
+	&dev_attr_number.attr,
+	NULL
+};
+
+static struct attribute_group card_dev_attr_group = {
+	.attrs	= card_dev_attrs,
+};
+
+static const struct attribute_group *card_dev_attr_groups[] = {
+	&card_dev_attr_group,
+	NULL
+};
 
 /**
  *  snd_card_register - register the soundcard
@@ -737,15 +752,6 @@ int snd_card_register(struct snd_card *card)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_REGISTER);
 #endif
-	if (card->registered) {
-		err = device_create_file(&card->card_dev, &card_id_attrs);
-		if (err < 0)
-			return err;
-		err = device_create_file(&card->card_dev, &card_number_attrs);
-		if (err < 0)
-			return err;
-	}
-
 	return 0;
 }
 
-- 
1.8.5.2
