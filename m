From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/17] ALSA: line6: Drop superfluous snd_device
	for PCM
Date: Mon, 19 Jan 2015 16:54:37 +0100
Message-ID: <1421682891-11594-4-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46B9526129B
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Instead of handling the card-specific resource in snd_device, attach
it into pcm->private_data and release it directly in private_free.
This simplifies the code and structure.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 53 ++++++++++++++++++---------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 626b6c158023..520cf540e83c 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -351,24 +351,21 @@ static void line6_cleanup_pcm(struct snd_pcm *pcm)
 			usb_free_urb(line6pcm->urb_audio_in[i]);
 		}
 	}
+	kfree(line6pcm);
 }
 
 /* create a PCM device */
-static int snd_line6_new_pcm(struct snd_line6_pcm *line6pcm)
+static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	err = snd_pcm_new(line6pcm->line6->card,
-			  (char *)line6pcm->line6->properties->name,
-			  0, 1, 1, &pcm);
+	err = snd_pcm_new(line6->card, (char *)line6->properties->name,
+			  0, 1, 1, pcm_ret);
 	if (err < 0)
 		return err;
-
-	pcm->private_data = line6pcm;
-	pcm->private_free = line6_cleanup_pcm;
-	line6pcm->pcm = pcm;
-	strcpy(pcm->name, line6pcm->line6->properties->name);
+	pcm = *pcm_ret;
+	strcpy(pcm->name, line6->properties->name);
 
 	/* set operators */
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
@@ -380,13 +377,6 @@ static int snd_line6_new_pcm(struct snd_line6_pcm *line6pcm)
 					      snd_dma_continuous_data
 					      (GFP_KERNEL), 64 * 1024,
 					      128 * 1024);
-
-	return 0;
-}
-
-/* PCM device destructor */
-static int snd_line6_pcm_free(struct snd_device *device)
-{
 	return 0;
 }
 
@@ -423,23 +413,25 @@ EXPORT_SYMBOL_GPL(line6_pcm_disconnect);
 int line6_init_pcm(struct usb_line6 *line6,
 		   struct line6_pcm_properties *properties)
 {
-	static struct snd_device_ops pcm_ops = {
-		.dev_free = snd_line6_pcm_free,
-	};
-
 	int i, err;
 	unsigned ep_read = line6->properties->ep_audio_r;
 	unsigned ep_write = line6->properties->ep_audio_w;
+	struct snd_pcm *pcm;
 	struct snd_line6_pcm *line6pcm;
 
 	if (!(line6->properties->capabilities & LINE6_CAP_PCM))
 		return 0;	/* skip PCM initialization and report success */
 
-	line6pcm = kzalloc(sizeof(*line6pcm), GFP_KERNEL);
+	err = snd_line6_new_pcm(line6, &pcm);
+	if (err < 0)
+		return err;
 
-	if (line6pcm == NULL)
+	line6pcm = kzalloc(sizeof(*line6pcm), GFP_KERNEL);
+	if (!line6pcm)
 		return -ENOMEM;
 
+	line6pcm->pcm = pcm;
+	line6pcm->properties = properties;
 	line6pcm->volume_playback[0] = line6pcm->volume_playback[1] = 255;
 	line6pcm->volume_monitor = 255;
 	line6pcm->line6 = line6;
@@ -451,23 +443,16 @@ int line6_init_pcm(struct usb_line6 *line6,
 			usb_maxpacket(line6->usbdev,
 				usb_sndisocpipe(line6->usbdev, ep_write), 1));
 
-	line6pcm->properties = properties;
-	line6->line6pcm = line6pcm;
-
-	/* PCM device: */
-	err = snd_device_new(line6->card, SNDRV_DEV_PCM, line6, &pcm_ops);
-	if (err < 0)
-		return err;
-
-	err = snd_line6_new_pcm(line6pcm);
-	if (err < 0)
-		return err;
-
 	spin_lock_init(&line6pcm->lock_audio_out);
 	spin_lock_init(&line6pcm->lock_audio_in);
 	spin_lock_init(&line6pcm->lock_trigger);
 	line6pcm->impulse_period = LINE6_IMPULSE_DEFAULT_PERIOD;
 
+	line6->line6pcm = line6pcm;
+
+	pcm->private_data = line6pcm;
+	pcm->private_free = line6_cleanup_pcm;
+
 	err = line6_create_audio_out_urbs(line6pcm);
 	if (err < 0)
 		return err;
-- 
2.2.1
