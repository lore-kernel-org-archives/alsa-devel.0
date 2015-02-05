From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: Add a helper to add a new attribute
	group to card
Date: Thu,  5 Feb 2015 14:48:21 +0100
Message-ID: <1423144102-24801-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A988264F03
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 14:48:27 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 33F2EAC78
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 13:48:26 +0000 (UTC)
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

For assigning sysfs entries for a card device from the driver,
introduce a new helper function, snd_card_add_dev_attr().  In this
way, we can avoid the possible race between the device registration
and the sysfs addition / removal.

The driver can pass a new attribute group to add freely.  This has to
be called before snd_card_register().

Currently, up to two extra groups can be added.  More than that, it'll
return an error.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  3 +++
 sound/core/init.c    | 31 +++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 58882bfacdd7..da5748289968 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -132,6 +132,7 @@ struct snd_card {
 	struct completion *release_completion;
 	struct device *dev;		/* device assigned to this card */
 	struct device card_dev;		/* cardX object for sysfs */
+	const struct attribute_group *dev_groups[4]; /* assigned sysfs attr */
 	bool registered;		/* card_dev is registered? */
 
 #ifdef CONFIG_PM
@@ -262,6 +263,8 @@ void snd_card_set_id(struct snd_card *card, const char *id);
 int snd_card_register(struct snd_card *card);
 int snd_card_info_init(void);
 int snd_card_info_done(void);
+int snd_card_add_dev_attr(struct snd_card *card,
+			  const struct attribute_group *group);
 int snd_component_add(struct snd_card *card, const char *component);
 int snd_card_file_add(struct snd_card *card, struct file *file);
 int snd_card_file_remove(struct snd_card *card, struct file *file);
diff --git a/sound/core/init.c b/sound/core/init.c
index 96194599e82e..35419054821c 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -181,7 +181,7 @@ void snd_device_initialize(struct device *dev, struct snd_card *card)
 EXPORT_SYMBOL_GPL(snd_device_initialize);
 
 static int snd_card_do_free(struct snd_card *card);
-static const struct attribute_group *card_dev_attr_groups[];
+static const struct attribute_group card_dev_attr_group;
 
 static void release_card_device(struct device *dev)
 {
@@ -269,7 +269,8 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	card->card_dev.parent = parent;
 	card->card_dev.class = sound_class;
 	card->card_dev.release = release_card_device;
-	card->card_dev.groups = card_dev_attr_groups;
+	card->card_dev.groups = card->dev_groups;
+	card->dev_groups[0] = &card_dev_attr_group;
 	err = kobject_set_name(&card->card_dev.kobj, "card%d", idx);
 	if (err < 0)
 		goto __error;
@@ -700,14 +701,32 @@ static struct attribute *card_dev_attrs[] = {
 	NULL
 };
 
-static struct attribute_group card_dev_attr_group = {
+static const struct attribute_group card_dev_attr_group = {
 	.attrs	= card_dev_attrs,
 };
 
-static const struct attribute_group *card_dev_attr_groups[] = {
-	&card_dev_attr_group,
-	NULL
+/**
+ * snd_card_add_dev_attr - Append a new sysfs attribute group to card
+ * @card: card instance
+ * @group: attribute group to append
+ */
+int snd_card_add_dev_attr(struct snd_card *card,
+			  const struct attribute_group *group)
+{
+	int i;
+
+	/* loop for (arraysize-1) here to keep NULL at the last entry */
+	for (i = 0; i < ARRAY_SIZE(card->dev_groups) - 1; i++) {
+		if (!card->dev_groups[i]) {
+			card->dev_groups[i] = group;
+			return 0;
+		}
+	}
+
+	dev_err(card->dev, "Too many groups assigned\n");
+	return -ENOSPC;
 };
+EXPORT_SYMBOL_GPL(snd_card_add_dev_attr);
 
 /**
  *  snd_card_register - register the soundcard
-- 
2.2.2
