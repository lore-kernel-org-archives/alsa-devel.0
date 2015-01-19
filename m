From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/17] ALSA: line6: Remove superfluous
	out-of-memory error messages
Date: Mon, 19 Jan 2015 16:54:41 +0100
Message-ID: <1421682891-11594-8-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D8BD26145E
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

Kernel already shows the error in the common path.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  | 4 +---
 sound/usb/line6/driver.c   | 6 +-----
 sound/usb/line6/midi.c     | 5 +----
 sound/usb/line6/playback.c | 4 +---
 sound/usb/line6/variax.c   | 4 +---
 5 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 1970ab57cb6f..727b31876d48 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -402,10 +402,8 @@ int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm)
 		urb = line6pcm->urb_audio_in[i] =
 		    usb_alloc_urb(LINE6_ISO_PACKETS, GFP_KERNEL);
 
-		if (urb == NULL) {
-			dev_err(line6->ifcdev, "Out of memory\n");
+		if (urb == NULL)
 			return -ENOMEM;
-		}
 
 		urb->dev = line6->usbdev;
 		urb->pipe =
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 23d504f4b6bc..b8f5134dcec2 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -190,7 +190,6 @@ int line6_send_raw_message_async(struct usb_line6 *line6, const char *buffer,
 
 	if (urb == NULL) {
 		kfree(msg);
-		dev_err(line6->ifcdev, "Out of memory\n");
 		return -ENOMEM;
 	}
 
@@ -215,10 +214,8 @@ int line6_version_request_async(struct usb_line6 *line6)
 
 	buffer = kmemdup(line6_request_version,
 			sizeof(line6_request_version), GFP_ATOMIC);
-	if (buffer == NULL) {
-		dev_err(line6->ifcdev, "Out of memory");
+	if (buffer == NULL)
 		return -ENOMEM;
-	}
 
 	retval = line6_send_raw_message_async(line6, buffer,
 					      sizeof(line6_request_version));
@@ -593,7 +590,6 @@ int line6_probe(struct usb_interface *interface,
 		line6->urb_listen = usb_alloc_urb(0, GFP_KERNEL);
 
 		if (line6->urb_listen == NULL) {
-			dev_err(&interface->dev, "Out of memory\n");
 			ret = -ENOMEM;
 			goto err_destruct;
 		}
diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index ebca5ebcfecc..f333cef5d2d7 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -121,16 +121,13 @@ static int send_midi_async(struct usb_line6 *line6, unsigned char *data,
 
 	urb = usb_alloc_urb(0, GFP_ATOMIC);
 
-	if (urb == NULL) {
-		dev_err(line6->ifcdev, "Out of memory\n");
+	if (urb == NULL)
 		return -ENOMEM;
-	}
 
 	transfer_buffer = kmemdup(data, length, GFP_ATOMIC);
 
 	if (transfer_buffer == NULL) {
 		usb_free_urb(urb);
-		dev_err(line6->ifcdev, "Out of memory\n");
 		return -ENOMEM;
 	}
 
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 8fc2dedbeb52..5a7fe409a3b9 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -558,10 +558,8 @@ int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm)
 		urb = line6pcm->urb_audio_out[i] =
 		    usb_alloc_urb(LINE6_ISO_PACKETS, GFP_KERNEL);
 
-		if (urb == NULL) {
-			dev_err(line6->ifcdev, "Out of memory\n");
+		if (urb == NULL)
 			return -ENOMEM;
-		}
 
 		urb->dev = line6->usbdev;
 		urb->pipe =
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index 0c852bb1e76c..9a9c7e48e24f 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -260,10 +260,8 @@ static int variax_try_init(struct usb_interface *interface,
 	variax->buffer_activate = kmemdup(variax_activate,
 					  sizeof(variax_activate), GFP_KERNEL);
 
-	if (variax->buffer_activate == NULL) {
-		dev_err(&interface->dev, "Out of memory\n");
+	if (variax->buffer_activate == NULL)
 		return -ENOMEM;
-	}
 
 	/* initialize audio system: */
 	err = line6_init_audio(&variax->line6);
-- 
2.2.1
