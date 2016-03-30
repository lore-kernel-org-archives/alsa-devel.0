From: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] ALSA: usb-audio: Fix double-free in snd_usb_add_audio_stream()
Date: Wed, 30 Mar 2016 21:03:22 +0200
Message-ID: <1459364602-28997-2-git-send-email-vdronov@redhat.com>
References: <1459364602-28997-1-git-send-email-vdronov@redhat.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1459364602-28997-1-git-send-email-vdronov@redhat.com>
Sender: linux-sound-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Cc: Vladis Dronov <vdronov@redhat.com>
List-Id: alsa-devel@alsa-project.org

There is a double-free bug in [snd-usb-audio] module due to alloc/free logic
flaw in snd_usb_add_audio_stream() function. This leads to kernel structures
corruption and panic. Fix the code flow and alloc/free logic so there is no
double-free.

The detailed analysis: https://bugzilla.redhat.com/show_bug.cgi?id=1283358

Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 sound/usb/quirks.c | 17 ++++++++++++-----
 sound/usb/stream.c | 10 ++++++++--
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index fb62bce..1d41b47 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -164,11 +164,6 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		fp->rate_table = rate_table;
 	}

-	stream = (fp->endpoint & USB_DIR_IN)
-		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
-	err = snd_usb_add_audio_stream(chip, stream, fp);
-	if (err < 0)
-		goto error;
 	if (fp->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
 	    fp->altset_idx >= iface->num_altsetting) {
 		err = -EINVAL;
@@ -181,6 +176,17 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		goto error;
 	}

+	stream = (fp->endpoint & USB_DIR_IN)
+		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	err = snd_usb_add_audio_stream(chip, stream, fp);
+	if (err < 0)
+		goto error;
+
+	/* From this point error paths should jump to
+	 * error_after_add_audio_stream: not to error: as fp
+	 * and rate_table will be freed on stream removal
+	 */
+
 	fp->protocol = altsd->bInterfaceProtocol;

 	if (fp->datainterval == 0)
@@ -195,6 +201,7 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
  error:
 	kfree(fp);
 	kfree(rate_table);
+ error_after_add_audio_stream:
 	return err;
 }

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 51258a1..f8ed8b49 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -349,7 +349,10 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,
 		if (err < 0)
 			return err;
 		snd_usb_init_substream(as, stream, fp);
-		return add_chmap(as->pcm, stream, subs);
+		err = add_chmap(as->pcm, stream, subs);
+		if (err < 0)
+			list_del_init(&fp->list);
+		return err;
 	}

 	/* create a new pcm */
@@ -391,7 +394,10 @@ int snd_usb_add_audio_stream(struct snd_usb_audio *chip,

 	snd_usb_proc_pcm_format_add(as);

-	return add_chmap(pcm, stream, &as->substream[stream]);
+	err = add_chmap(pcm, stream, &as->substream[stream]);
+	if (err < 0)
+		list_del_init(&fp->list);
+	return err;
 }

 static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
--
2.5.5

