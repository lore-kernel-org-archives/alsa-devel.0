From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] ALSA: snd-usb-usx2y: remove bogus frame
	checks
Date: Wed,  2 Oct 2013 17:49:50 +0200
Message-ID: <1380728990-8443-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C6B72654C8
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2013 17:50:02 +0200 (CEST)
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
Cc: tiwai@suse.de, guido.aulisi@gmail.com, nicholas.bailey@glasgow.ac.uk, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The frame check in i_usX2Y_urb_complete() and
i_usX2Y_usbpcm_urb_complete() is bogus and produces false positives as
described in this LAU thread:

  http://linuxaudio.org/mailarchive/lau/2013/5/20/200177

This patch removes the check code entirely.

Cc: fzu@wemgehoertderstaat.de
Reported-by: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/usx2y/usbusx2yaudio.c | 22 +++-------------------
 sound/usb/usx2y/usx2yhwdeppcm.c |  7 +------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 63fb521..6234a51 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -299,19 +299,6 @@ static void usX2Y_error_urb_status(struct usX2Ydev *usX2Y,
 	usX2Y_clients_stop(usX2Y);
 }
 
-static void usX2Y_error_sequence(struct usX2Ydev *usX2Y,
-				 struct snd_usX2Y_substream *subs, struct urb *urb)
-{
-	snd_printk(KERN_ERR
-"Sequence Error!(hcd_frame=%i ep=%i%s;wait=%i,frame=%i).\n"
-"Most probably some urb of usb-frame %i is still missing.\n"
-"Cause could be too long delays in usb-hcd interrupt handling.\n",
-		   usb_get_current_frame_number(usX2Y->dev),
-		   subs->endpoint, usb_pipein(urb->pipe) ? "in" : "out",
-		   usX2Y->wait_iso_frame, urb->start_frame, usX2Y->wait_iso_frame);
-	usX2Y_clients_stop(usX2Y);
-}
-
 static void i_usX2Y_urb_complete(struct urb *urb)
 {
 	struct snd_usX2Y_substream *subs = urb->context;
@@ -328,12 +315,9 @@ static void i_usX2Y_urb_complete(struct urb *urb)
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 0xFFFF)))
-		subs->completed_urb = urb;
-	else {
-		usX2Y_error_sequence(usX2Y, subs, urb);
-		return;
-	}
+
+	subs->completed_urb = urb;
+
 	{
 		struct snd_usX2Y_substream *capsubs = usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE],
 			*playbacksubs = usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index f2a1acd..814d0e8 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -244,13 +244,8 @@ static void i_usX2Y_usbpcm_urb_complete(struct urb *urb)
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 0xFFFF)))
-		subs->completed_urb = urb;
-	else {
-		usX2Y_error_sequence(usX2Y, subs, urb);
-		return;
-	}
 
+	subs->completed_urb = urb;
 	capsubs = usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE];
 	capsubs2 = usX2Y->subs[SNDRV_PCM_STREAM_CAPTURE + 2];
 	playbacksubs = usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
-- 
1.8.3.1
