From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 06/11] ALSA: implement MEDIA_IOC_SETUP_LINK
Date: Tue, 28 Aug 2012 00:32:31 +0200
Message-ID: <503BF57F.6060703@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6FB47265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:33:28 +0200 (CEST)
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

Just for compatibility with the media controller API, implement the
setup link ioctl, which does not actually do anything.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/media.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/sound/core/media.c b/sound/core/media.c
index aa90848..cbc51d9 100644
--- a/sound/core/media.c
+++ b/sound/core/media.c
@@ -289,6 +289,45 @@ static int snd_media_enum_links(struct snd_card *card,
 	return 0;
 }

+static int snd_media_setup_link(struct snd_card *card,
+				struct media_link_desc __user *descp)
+{
+	struct media_link_desc desc;
+	struct snd_media_entity *source, *sink;
+	struct snd_media_link *link;
+	unsigned int i;
+	int err;
+
+	if (copy_from_user(&desc, descp, sizeof(desc)))
+		return -EFAULT;
+
+	if (desc.flags != (MEDIA_LNK_FL_ENABLED | MEDIA_LNK_FL_IMMUTABLE))
+		return -EINVAL;
+
+	mutex_lock(&card->media_mutex);
+	source = search_entity(card, desc.source.entity);
+	sink   = search_entity(card, desc.sink.entity);
+	mutex_unlock(&card->media_mutex);
+	if (!source || !sink)
+		return -EINVAL;
+
+	err = -EINVAL;
+	mutex_lock(&card->media_mutex);
+	for (i = 0; i < card->media_links_count; i++) {
+		link = &card->media_links[i];
+		if (link->source_entity == desc.source.entity &&
+		    link->sink_entity == desc.sink.entity &&
+		    link->source_pad == desc.source.index &&
+		    link->sink_pad == desc.sink.index) {
+			err = 0;
+			break;
+		}
+	}
+	mutex_unlock(&card->media_mutex);
+
+	return err;
+}
+
 static int snd_media_control_ioctl(struct snd_card *card,
 				   struct snd_ctl_file *ctl_file,
 				   unsigned int cmd, unsigned long arg)
@@ -302,6 +341,8 @@ static int snd_media_control_ioctl(struct snd_card *card,
 		return snd_media_enum_entities(card, argp);
 	case MEDIA_IOC_ENUM_LINKS:
 		return snd_media_enum_links(card, argp);
+	case MEDIA_IOC_SETUP_LINK:
+		return snd_media_setup_link(card, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
