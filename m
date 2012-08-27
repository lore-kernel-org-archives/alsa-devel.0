From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 04/11] ALSA: implement MEDIA_IOC_ENUM_LINKS
	(1)
Date: Tue, 28 Aug 2012 00:31:19 +0200
Message-ID: <503BF537.8060107@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 4D41B265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:32:16 +0200 (CEST)
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

Allow to retrieve pad information.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/media.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/sound/core/media.c b/sound/core/media.c
index aa94175..96b09a3 100644
--- a/sound/core/media.c
+++ b/sound/core/media.c
@@ -161,6 +161,48 @@ static int snd_media_enum_entities(struct snd_card *card,
 	return copy_to_user(descp, &desc, sizeof(desc));
 }

+static int snd_media_enum_links(struct snd_card *card,
+				struct media_links_enum __user *linksp)
+{
+	struct media_links_enum links;
+	struct snd_media_entity *entity;
+
+	if (copy_from_user(&links, linksp, sizeof(links)))
+		return -EFAULT;
+
+	mutex_lock(&card->media_mutex);
+	entity = search_entity(card, links.entity);
+	mutex_unlock(&card->media_mutex);
+	if (!entity)
+		return -EINVAL;
+
+	if (links.pads) {
+		struct media_pad_desc pad;
+		unsigned int i;
+
+		memset(&pad, 0, sizeof(pad));
+		pad.entity = entity->id;
+
+		pad.flags = MEDIA_PAD_FL_SINK;
+		for (i = 0; i < entity->sinks; i++) {
+			if (copy_to_user(links.pads, &pad, sizeof(pad)))
+				return -EFAULT;
+			links.pads++;
+			pad.index++;
+		}
+
+		pad.flags = MEDIA_PAD_FL_SOURCE;
+		for (i = 0; i < entity->sources; i++) {
+			if (copy_to_user(links.pads, &pad, sizeof(pad)))
+				return -EFAULT;
+			links.pads++;
+			pad.index++;
+		}
+	}
+
+	return 0;
+}
+
 static int snd_media_control_ioctl(struct snd_card *card,
 				   struct snd_ctl_file *ctl_file,
 				   unsigned int cmd, unsigned long arg)
@@ -172,6 +214,8 @@ static int snd_media_control_ioctl(struct snd_card *card,
 		return snd_media_device_info(card, argp);
 	case MEDIA_IOC_ENUM_ENTITIES:
 		return snd_media_enum_entities(card, argp);
+	case MEDIA_IOC_ENUM_LINKS:
+		return snd_media_enum_links(card, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
