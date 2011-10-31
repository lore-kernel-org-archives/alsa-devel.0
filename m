From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/5] ALSA: snd-usb: add support for implicit
	feedback
Date: Mon, 31 Oct 2011 13:10:30 +0100
Message-ID: <1320063030-3502-6-git-send-email-zonque@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E856246AB
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2011 13:10:44 +0100 (CET)
In-Reply-To: <1320063030-3502-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

---
 sound/usb/pcm.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index af21d38..e88abfa 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -312,9 +312,12 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
 	     (! is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
 	    altsd->bNumEndpoints >= 2) {
+		int implicit_fb = (get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_USAGE_MASK)
+				== USB_ENDPOINT_USAGE_IMPLICIT_FB;
 		switch (subs->stream->chip->usb_id) {
 		case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
 		case USB_ID(0x0763, 0x2081):
+			implicit_fb = 1;
 			ep = 0x81;
 			iface = usb_ifnum_to_if(dev, 2);
 			alts = &iface->altsetting[1];
@@ -327,7 +330,8 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		   the audio fields in the endpoint descriptors */
 		if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != 0x01 ||
 		    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
-		     get_endpoint(alts, 1)->bSynchAddress != 0)) {
+		     get_endpoint(alts, 1)->bSynchAddress != 0 &&
+		     !implicit_fb)) {
 			snd_printk(KERN_ERR "%d:%d:%d : invalid synch pipe\n",
 				   dev->devnum, fmt->iface, fmt->altsetting);
 			return -EINVAL;
@@ -335,7 +339,8 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		ep = get_endpoint(alts, 1)->bEndpointAddress;
 		if (get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
 		    (( is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
-		     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
+		     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)) ||
+		     ( is_playback && !implicit_fb))) {
 			snd_printk(KERN_ERR "%d:%d:%d : invalid synch pipe\n",
 				   dev->devnum, fmt->iface, fmt->altsetting);
 			return -EINVAL;
@@ -343,8 +348,9 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 add_sync_ep:
 		subs->sync_endpoint = snd_usb_add_endpoint(subs->stream->chip,
 							   alts, ep, !subs->direction,
-							   SND_USB_ENDPOINT_TYPE_SYNC);
-
+							   implicit_fb ?
+								SND_USB_ENDPOINT_TYPE_DATA :
+								SND_USB_ENDPOINT_TYPE_SYNC);
 		if (!subs->sync_endpoint)
 			return -EINVAL;
 
-- 
1.7.5.4
