From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 02/11] ALSA: implement
	MEDIA_IOC_ENUM_ENTITIES
Date: Tue, 28 Aug 2012 00:30:07 +0200
Message-ID: <503BF4EF.5010907@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0595D265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:31:06 +0200 (CEST)
In-Reply-To: <503BF48E.1090100@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Allow drivers to create entities.  To avoid bloat, the snd_media_entity
structure stores only basic information and retrieves the full entitiy
information on demand with a callback.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/core.h  |    5 ++
 include/sound/media.h |   23 ++++++++++
 sound/core/init.c     |    4 ++
 sound/core/media.c    |  114 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 1 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 5eca6f5..072b642 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -51,7 +51,8 @@ struct snd_media_card_ops;
 typedef int __bitwise snd_device_type_t;
 #define	SNDRV_DEV_TOPLEVEL	((__force snd_device_type_t) 0)
 #define	SNDRV_DEV_CONTROL	((__force snd_device_type_t) 1)
-#define	SNDRV_DEV_LOWLEVEL_PRE	((__force snd_device_type_t) 2)
+#define	SNDRV_DEV_MEDIA		((__force snd_device_type_t) 2)
+#define	SNDRV_DEV_LOWLEVEL_PRE	((__force snd_device_type_t) 3)
 #define	SNDRV_DEV_LOWLEVEL_NORMAL ((__force snd_device_type_t) 0x1000)
 #define	SNDRV_DEV_PCM		((__force snd_device_type_t) 0x1001)
 #define	SNDRV_DEV_RAWMIDI	((__force snd_device_type_t) 0x1002)
@@ -149,6 +150,8 @@ struct snd_card {

 #ifdef CONFIG_SND_MEDIA
 	const struct snd_media_card_ops *media_ops;
+	struct mutex media_mutex;
+	struct list_head media_entities;
 #endif
 };

diff --git a/include/sound/media.h b/include/sound/media.h
index d196219..65dd068 100644
--- a/include/sound/media.h
+++ b/include/sound/media.h
@@ -23,16 +23,29 @@
 #include <linux/init.h>

 struct snd_card;
+struct snd_media_entity;
 struct media_device_info;
+struct media_entity_desc;

 struct snd_media_card_ops {
 	int (*get_info)(struct snd_card *card, struct media_device_info *info);
 };

+typedef int (*snd_media_entity_get_desc_t)(struct snd_card *card,
+					   void *private_data,
+					   struct media_entity_desc *desc);
+
 #ifdef CONFIG_SND_MEDIA

 #define snd_card_set_media_ops(card, ops) ((card)->media_ops = (ops))

+int snd_media_entity_create(struct snd_card *card,
+			    snd_media_entity_get_desc_t get_desc,
+			    unsigned int id,
+			    unsigned int sinks, unsigned int sources,
+			    void *private_data);
+
+int snd_media_create(struct snd_card *card);
 void __init snd_media_init(void);
 void __exit snd_media_exit(void);

@@ -40,6 +53,16 @@ void __exit snd_media_exit(void);

 #define snd_card_set_media_ops(card, ops)

+static inline int snd_media_entity_create(struct snd_card *card,
+					  snd_media_entity_get_desc_t get_desc,
+					  unsigned int id,
+					  unsigned int sinks, unsigned int sources,
+					  void *private_data)
+{ return 0; }
+
+
+static inline int snd_media_create(struct snd_card *card)
+{ return 0; }
 static inline void snd_media_init()
 { }
 static inline void snd_media_exit()
diff --git a/sound/core/init.c b/sound/core/init.c
index d8ec849..e16ef16 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -32,6 +32,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
+#include <sound/media.h>

 /* monitor files for graceful shutdown (hotplug) */
 struct snd_monitor_file {
@@ -224,6 +225,9 @@ int snd_card_create(int idx, const char *xid,
 		snd_printk(KERN_ERR "unable to register control minors\n");
 		goto __error;
 	}
+	err = snd_media_create(card);
+	if (err < 0)
+		goto __error_ctl;
 	err = snd_info_card_create(card);
 	if (err < 0) {
 		snd_printk(KERN_ERR "unable to create card info\n");
diff --git a/sound/core/media.c b/sound/core/media.c
index 6ceb12a..aa94175 100644
--- a/sound/core/media.c
+++ b/sound/core/media.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/media.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
@@ -27,6 +28,87 @@
 #include <sound/control.h>
 #include <sound/media.h>

+struct snd_media_entity {
+	struct list_head list;
+	snd_media_entity_get_desc_t get_desc;
+	void *private_data;
+	unsigned int id;
+	unsigned int sinks, sources;
+};
+
+static struct snd_media_entity *search_entity(struct snd_card *card,
+					      unsigned int id)
+{
+	struct snd_media_entity *e;
+	bool next = id & MEDIA_ENT_ID_FLAG_NEXT;
+
+	id &= ~MEDIA_ENT_ID_FLAG_NEXT;
+	if (next)
+		id++;
+
+	list_for_each_entry(e, &card->media_entities, list)
+		if (e->id >= id)
+			return next || e->id == id ? e : NULL;
+
+	return NULL;
+}
+
+int snd_media_entity_create(struct snd_card *card,
+			    snd_media_entity_get_desc_t get_desc,
+			    unsigned int id,
+			    unsigned int sinks, unsigned int sources,
+			    void *private_data)
+{
+	struct snd_media_entity *entity;
+	struct list_head *pos;
+
+	entity = kzalloc(sizeof(*entity), GFP_KERNEL);
+	if (!entity)
+		return -ENOMEM;
+	entity->get_desc = get_desc;
+	entity->id = id;
+	entity->sinks = sinks;
+	entity->sources = sources;
+	entity->private_data = private_data;
+
+	mutex_lock(&card->media_mutex);
+	list_for_each_prev(pos, &card->media_entities)
+		if (list_entry(pos, struct snd_media_entity, list)->id < id)
+			break;
+	list_add(&entity->list, pos);
+	mutex_unlock(&card->media_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_media_entity_create);
+
+static int snd_media_dev_free(struct snd_device *device)
+{
+	struct snd_card *card = device->device_data;
+	struct snd_media_entity *e;
+
+	while (!list_empty(&card->media_entities)) {
+		e = list_first_entry(&card->media_entities,
+				     struct snd_media_entity, list);
+		list_del(&e->list);
+		kfree(e);
+	}
+
+	return 0;
+}
+
+int snd_media_create(struct snd_card *card)
+{
+	static struct snd_device_ops ops = {
+		.dev_free = snd_media_dev_free,
+	};
+
+	mutex_init(&card->media_mutex);
+	INIT_LIST_HEAD(&card->media_entities);
+
+	return snd_device_new(card, SNDRV_DEV_MEDIA, card, &ops);
+}
+
 static int snd_media_device_info(struct snd_card *card,
 				 struct media_device_info __user *infop)
 {
@@ -49,6 +131,36 @@ static int snd_media_device_info(struct snd_card *card,
 	return copy_to_user(infop, &info, sizeof(info));
 }

+static int snd_media_enum_entities(struct snd_card *card,
+				   struct media_entity_desc __user *descp)
+{
+	struct media_entity_desc desc;
+	struct snd_media_entity *entity;
+	int err;
+
+	if (copy_from_user(&desc, descp, sizeof(desc)))
+		return -EFAULT;
+
+	mutex_lock(&card->media_mutex);
+	entity = search_entity(card, desc.id);
+	mutex_unlock(&card->media_mutex);
+	if (!entity)
+		return -EINVAL;
+
+	desc.id = entity->id;
+	desc.revision = 0;
+	desc.flags = 0;
+	desc.group_id = 0;
+	desc.pads = entity->sinks + entity->sources;
+	desc.links = 0;
+
+	err = entity->get_desc(card, entity->private_data, &desc);
+	if (err < 0)
+		return err;
+
+	return copy_to_user(descp, &desc, sizeof(desc));
+}
+
 static int snd_media_control_ioctl(struct snd_card *card,
 				   struct snd_ctl_file *ctl_file,
 				   unsigned int cmd, unsigned long arg)
@@ -58,6 +170,8 @@ static int snd_media_control_ioctl(struct snd_card *card,
 	switch (cmd) {
 	case MEDIA_IOC_DEVICE_INFO:
 		return snd_media_device_info(card, argp);
+	case MEDIA_IOC_ENUM_ENTITIES:
+		return snd_media_enum_entities(card, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
