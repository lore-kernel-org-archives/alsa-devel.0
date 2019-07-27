From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] ALSA: usb-audio: Unify audioformat
	release code
Date: Sat, 27 Jul 2019 11:30:05 +0200
Message-ID: <20190727093006.9870-2-tiwai@suse.de>
References: <20190727093006.9870-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEE1AF80394
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2019 11:30:15 +0200 (CEST)
In-Reply-To: <20190727093006.9870-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Tanu Kaskinen <tanuk@iki.fi>, Alexander Tsoy <alexander@tsoy.me>
List-Id: alsa-devel@alsa-project.org

There are many open code for releasing audioformat object.
Provide a unified helper and call it from the all places.

Only a cleanup, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/stream.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 7ee9d17d0143..963d425004f8 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -28,6 +28,14 @@
 #include "power.h"
 #include "media.h"
 
+static void audioformat_free(struct audioformat *fp)
+{
+	list_del(&fp->list); /* unlink for avoiding double-free */
+	kfree(fp->rate_table);
+	kfree(fp->chmap);
+	kfree(fp);
+}
+
 /*
  * free a substream
  */
@@ -37,11 +45,8 @@ static void free_substream(struct snd_usb_substream *subs)
 
 	if (!subs->num_formats)
 		return; /* not initialized */
-	list_for_each_entry_safe(fp, n, &subs->fmt_list, list) {
-		kfree(fp->rate_table);
-		kfree(fp->chmap);
-		kfree(fp);
-	}
+	list_for_each_entry_safe(fp, n, &subs->fmt_list, list)
+		audioformat_free(fp);
 	kfree(subs->rate_list.list);
 	kfree(subs->str_pd);
 	snd_media_stream_delete(subs);
@@ -832,8 +837,7 @@ snd_usb_get_audioformat_uac12(struct snd_usb_audio *chip,
 	/* ok, let's parse further... */
 	if (snd_usb_parse_audio_format(chip, fp, format,
 					fmt, stream) < 0) {
-		kfree(fp->rate_table);
-		kfree(fp);
+		audioformat_free(fp);
 		return NULL;
 	}
 
@@ -1043,8 +1047,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
 		if (!pd) {
-			kfree(fp->rate_table);
-			kfree(fp);
+			audioformat_free(fp);
 			return NULL;
 		}
 		pd->pd_id = (stream == SNDRV_PCM_STREAM_PLAYBACK) ?
@@ -1063,9 +1066,7 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 		/* ok, let's parse further... */
 		if (snd_usb_parse_audio_format_v3(chip, fp, as, stream) < 0) {
 			kfree(pd);
-			kfree(fp->chmap);
-			kfree(fp->rate_table);
-			kfree(fp);
+			audioformat_free(fp);
 			return NULL;
 		}
 	}
@@ -1184,11 +1185,8 @@ int snd_usb_parse_audio_interface(struct snd_usb_audio *chip, int iface_no)
 			err = snd_usb_add_audio_stream(chip, stream, fp);
 
 		if (err < 0) {
-			list_del(&fp->list); /* unlink for avoiding double-free */
+			audioformat_free(fp);
 			kfree(pd);
-			kfree(fp->rate_table);
-			kfree(fp->chmap);
-			kfree(fp);
 			return err;
 		}
 		/* try to set the interface... */
-- 
2.16.4
