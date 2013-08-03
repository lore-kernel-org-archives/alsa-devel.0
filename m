From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH v2 6/9] ALSA: usb-audio: do not initialize and
	check implicit_fb
Date: Sat,  3 Aug 2013 10:50:20 +0200
Message-ID: <1375519823-25718-7-git-send-email-eldad@fogrefinery.com>
References: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FA342619EA
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:50:48 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id ji2so452992bkc.38
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:50:48 -0700 (PDT)
In-Reply-To: <1375519823-25718-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Eldad Zack <eldad@fogrefinery.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since implicit_fb is not changed, !implicit_fb will always
be true - it is set only after these checks.
Similarly, there's also no need to set it at the top of the function.

Change the type of implicit_fb to bool (more appropriate).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

---
v2: implicit_fb type set to bool
---
 sound/usb/pcm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c31dbdc..bb2e0f5 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -405,7 +405,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 {
 	int is_playback = subs->direction == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int ep, attr;
-	int implicit_fb = 0;
+	bool implicit_fb;
 	int err;
 
 	/* we need a sync pipe in async OUT or adaptive IN mode */
@@ -432,8 +432,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 	   the audio fields in the endpoint descriptors */
 	if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_ISOC ||
 	    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
-	     get_endpoint(alts, 1)->bSynchAddress != 0 &&
-	     !implicit_fb)) {
+	     get_endpoint(alts, 1)->bSynchAddress != 0)) {
 		snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. bmAttributes %02x, bLength %d, bSynchAddress %02x\n",
 			   dev->devnum, fmt->iface, fmt->altsetting,
 			   get_endpoint(alts, 1)->bmAttributes,
@@ -442,8 +441,7 @@ static int set_sync_endpoint(struct snd_usb_substream *subs,
 		return -EINVAL;
 	}
 	ep = get_endpoint(alts, 1)->bEndpointAddress;
-	if (!implicit_fb &&
-	    get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+	if (get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
 	    ((is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
 	     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
 		snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. is_playback %d, ep %02x, bSynchAddress %02x\n",
-- 
1.8.1.5
