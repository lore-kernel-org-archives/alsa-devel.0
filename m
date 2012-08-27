From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 05/11] ALSA: implement MEDIA_IOC_ENUM_LINKS
	(2)
Date: Tue, 28 Aug 2012 00:31:53 +0200
Message-ID: <503BF559.7090204@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 174CD265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:32:52 +0200 (CEST)
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

Allow drivers to create links between entities.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/core.h  |    3 ++
 include/sound/media.h |   11 ++++++
 sound/core/media.c    |   86 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 072b642..f6577ec 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -43,6 +43,7 @@ struct module;
 struct device;
 struct device_attribute;
 struct snd_media_card_ops;
+struct snd_media_link;

 /* device allocation stuff */

@@ -152,6 +153,8 @@ struct snd_card {
 	const struct snd_media_card_ops *media_ops;
 	struct mutex media_mutex;
 	struct list_head media_entities;
+	unsigned int media_links_count;
+	struct snd_media_link *media_links;
 #endif
 };

diff --git a/include/sound/media.h b/include/sound/media.h
index 65dd068..ebb7c7d 100644
--- a/include/sound/media.h
+++ b/include/sound/media.h
@@ -44,6 +44,11 @@ int snd_media_entity_create(struct snd_card *card,
 			    unsigned int id,
 			    unsigned int sinks, unsigned int sources,
 			    void *private_data);
+int snd_media_link_create(struct snd_card *card,
+			  unsigned int source_entity,
+			  unsigned int source_pad,
+			  unsigned int sink_entity,
+			  unsigned int sink_pad);

 int snd_media_create(struct snd_card *card);
 void __init snd_media_init(void);
@@ -59,6 +64,12 @@ static inline int snd_media_entity_create(struct snd_card *card,
 					  unsigned int sinks, unsigned int sources,
 					  void *private_data)
 { return 0; }
+static inline int snd_media_link_create(struct snd_card *card,
+					unsigned int source_entity,
+					unsigned int source_pad,
+					unsigned int sink_entity,
+					unsigned int sink_pad)
+{ return 0; }


 static inline int snd_media_create(struct snd_card *card)
diff --git a/sound/core/media.c b/sound/core/media.c
index 96b09a3..aa90848 100644
--- a/sound/core/media.c
+++ b/sound/core/media.c
@@ -36,6 +36,13 @@ struct snd_media_entity {
 	unsigned int sinks, sources;
 };

+struct snd_media_link {
+	unsigned int source_entity;
+	unsigned int sink_entity;
+	unsigned short source_pad;
+	unsigned short sink_pad;
+};
+
 static struct snd_media_entity *search_entity(struct snd_card *card,
 					      unsigned int id)
 {
@@ -82,6 +89,47 @@ int snd_media_entity_create(struct snd_card *card,
 }
 EXPORT_SYMBOL(snd_media_entity_create);

+int snd_media_link_create(struct snd_card *card,
+			  unsigned int source_entity,
+			  unsigned int source_pad,
+			  unsigned int sink_entity,
+			  unsigned int sink_pad)
+{
+	struct snd_media_link link;
+	struct snd_media_link *links;
+	size_t new_size = 0;
+
+	link.source_entity = source_entity;
+	link.sink_entity = sink_entity;
+	link.source_pad = source_pad;
+	link.sink_pad = sink_pad;
+
+	mutex_lock(&card->media_mutex);
+
+	if (card->media_links) {
+		size_t allocated = ksize(card->media_links);
+		if (allocated < (card->media_links_count + 1) * sizeof(link))
+			new_size = allocated * 2;
+	} else {
+		new_size = 4 * sizeof(link);
+	}
+	if (new_size > 0) {
+		links = krealloc(card->media_links, new_size, GFP_KERNEL);
+		if (!links) {
+			mutex_unlock(&card->media_mutex);
+			return -ENOMEM;
+		}
+		card->media_links = links;
+	}
+
+	card->media_links[card->media_links_count++] = link;
+
+	mutex_unlock(&card->media_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_media_link_create);
+
 static int snd_media_dev_free(struct snd_device *device)
 {
 	struct snd_card *card = device->device_data;
@@ -94,6 +142,8 @@ static int snd_media_dev_free(struct snd_device *device)
 		kfree(e);
 	}

+	kfree(card->media_links);
+
 	return 0;
 }

@@ -136,6 +186,7 @@ static int snd_media_enum_entities(struct snd_card *card,
 {
 	struct media_entity_desc desc;
 	struct snd_media_entity *entity;
+	unsigned int i;
 	int err;

 	if (copy_from_user(&desc, descp, sizeof(desc)))
@@ -152,7 +203,13 @@ static int snd_media_enum_entities(struct snd_card *card,
 	desc.flags = 0;
 	desc.group_id = 0;
 	desc.pads = entity->sinks + entity->sources;
+
 	desc.links = 0;
+	mutex_lock(&card->media_mutex);
+	for (i = 0; i < card->media_links_count; i++)
+		if (card->media_links[i].source_entity == desc.id)
+			desc.links++;
+	mutex_unlock(&card->media_mutex);

 	err = entity->get_desc(card, entity->private_data, &desc);
 	if (err < 0)
@@ -200,6 +257,35 @@ static int snd_media_enum_links(struct snd_card *card,
 		}
 	}

+	if (links.links) {
+		struct media_link_desc desc;
+		struct snd_media_link *link;
+		unsigned int i;
+
+		memset(&desc, 0, sizeof(desc));
+		desc.source.entity = links.entity;
+		desc.source.flags = MEDIA_PAD_FL_SOURCE;
+		desc.sink.flags = MEDIA_PAD_FL_SINK;
+		desc.flags = MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE;
+
+		mutex_lock(&card->media_mutex);
+		for (i = 0; i < card->media_links_count; i++) {
+			link = &card->media_links[i];
+			if (link->source_entity != links.entity)
+				continue;
+
+			desc.source.index = link->source_pad;
+			desc.sink.entity = link->sink_entity;
+			desc.sink.index = link->sink_pad;
+			if (copy_to_user(links.links, &desc, sizeof(desc))) {
+				mutex_unlock(&card->media_mutex);
+				return -EFAULT;
+			}
+			links.links++;
+		}
+		mutex_unlock(&card->media_mutex);
+	}
+
 	return 0;
 }
