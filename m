From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] usx2y: Fix typo in usbusx2yaudio.c and usx2yhwdeppcm.c
Date: Wed, 15 Feb 2012 00:13:24 +0900
Message-ID: <1329232404-2440-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, standby24x7@gmail.com
List-Id: alsa-devel@alsa-project.org

Correct spelling "propably" to "probably" in
sound/usb/usx2y/usbusx2yaudio.c and usx2yhwdeppcm.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/usb/usx2y/usbusx2yaudio.c |    4 ++--
 sound/usb/usx2y/usx2yhwdeppcm.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index 6ffb371..520ef96 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -80,7 +80,7 @@ static int usX2Y_urb_capt_retire(struct snd_usX2Y_substream *subs)
 		cp = (unsigned char*)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
 		if (urb->iso_frame_desc[i].status) { /* active? hmm, skip this */
 			snd_printk(KERN_ERR "active frame status %i. "
-				   "Most propably some hardware problem.\n",
+				   "Most probably some hardware problem.\n",
 				   urb->iso_frame_desc[i].status);
 			return urb->iso_frame_desc[i].status;
 		}
@@ -300,7 +300,7 @@ static void usX2Y_error_sequence(struct usX2Ydev *usX2Y,
 {
 	snd_printk(KERN_ERR
 "Sequence Error!(hcd_frame=%i ep=%i%s;wait=%i,frame=%i).\n"
-"Most propably some urb of usb-frame %i is still missing.\n"
+"Most probably some urb of usb-frame %i is still missing.\n"
 "Cause could be too long delays in usb-hcd interrupt handling.\n",
 		   usb_get_current_frame_number(usX2Y->dev),
 		   subs->endpoint, usb_pipein(urb->pipe) ? "in" : "out",
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index a51340f..ad27f68 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -74,7 +74,7 @@ static int usX2Y_usbpcm_urb_capt_retire(struct snd_usX2Y_substream *subs)
 	}
 	for (i = 0; i < nr_of_packs(); i++) {
 		if (urb->iso_frame_desc[i].status) { /* active? hmm, skip this */
-			snd_printk(KERN_ERR "activ frame status %i. Most propably some hardware problem.\n", urb->iso_frame_desc[i].status);
+			snd_printk(KERN_ERR "activ frame status %i. Most probably some hardware problem.\n", urb->iso_frame_desc[i].status);
 			return urb->iso_frame_desc[i].status;
 		}
 		lens += urb->iso_frame_desc[i].actual_length / usX2Y->stride;
-- 
1.7.6.5
