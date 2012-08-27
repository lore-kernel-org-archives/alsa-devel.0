From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 03/11] ALSA: pcm: add ALSA PCM device
	entities
Date: Tue, 28 Aug 2012 00:30:43 +0200
Message-ID: <503BF513.1020302@ladisch.de>
References: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6B351265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:31:41 +0200 (CEST)
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

Add a helper function for creating entities representing ALSA PCM
devices.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/sound/pcm.h |    6 ++++++
 sound/core/pcm.c    |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 39e26a3..f0a80b7 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -480,6 +480,12 @@ int snd_pcm_new_internal(struct snd_card *card, const char *id, int device,
 		int playback_count, int capture_count,
 		struct snd_pcm **rpcm);
 int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count);
+#ifdef CONFIG_SND_MEDIA
+int snd_pcm_media_entities_create(struct snd_pcm *pcm, int stream,
+				  unsigned int id);
+#else
+#define snd_pcm_media_entities_create(pcm, stream, id)
+#endif

 int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree);

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 1a3070b..a138c57 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -25,11 +25,13 @@
 #include <linux/time.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/media.h>
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
 #include <sound/control.h>
 #include <sound/info.h>
+#include <sound/media.h>

 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>, Abramo Bagnara <abramo@alsa-project.org>");
 MODULE_DESCRIPTION("Midlevel PCM code for ALSA.");
@@ -1136,6 +1138,50 @@ int snd_pcm_notify(struct snd_pcm_notify *notify, int nfree)

 EXPORT_SYMBOL(snd_pcm_notify);

+#ifdef CONFIG_SND_MEDIA
+static int snd_pcm_get_entity_desc(struct snd_card *card,
+				   void *private_data,
+				   struct media_entity_desc *desc)
+{
+	struct snd_pcm_substream *substream = private_data;
+
+	if (memcmp(substream->name, "subdevice #", 11))
+		strlcpy(desc->name, substream->name, sizeof(desc->name));
+	else
+		strlcpy(desc->name, substream->pcm->name, sizeof(desc->name));
+	desc->type = MEDIA_ENT_T_DEVNODE_ALSA;
+	desc->alsa.card = card->number;
+	desc->alsa.device = substream->pcm->device;
+	desc->alsa.subdevice = substream->number;
+
+	return 0;
+}
+
+int snd_pcm_media_entities_create(struct snd_pcm *pcm, int stream,
+				  unsigned int id)
+{
+	struct snd_pcm_str *pstr = &pcm->streams[stream];
+	struct snd_pcm_substream *substream;
+	int err;
+
+	for (substream = pstr->substream;
+	     substream;
+	     substream = substream->next) {
+		err = snd_media_entity_create(
+				pcm->card, snd_pcm_get_entity_desc,
+				id + substream->number,
+				stream == SNDRV_PCM_STREAM_CAPTURE  ? 1 : 0,
+				stream == SNDRV_PCM_STREAM_PLAYBACK ? 1 : 0,
+				substream);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(snd_pcm_media_entities_create);
+#endif
+
 #ifdef CONFIG_PROC_FS
 /*
  *  Info interface
