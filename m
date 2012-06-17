From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: snd-usb: fix sync pipe check
Date: Sun, 17 Jun 2012 13:44:27 +0200
Message-ID: <1339933467-12479-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id F0EF2243B6
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2012 13:45:04 +0200 (CEST)
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Fix a bogus sanity check for sync pipe in pcm.c. This flaw was
introduced during the streaming logic refactorization.

While at it, improve the error messages that are generated in such cases.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-and-tested-by: <ben@b1c1l1.com>
---
 sound/usb/pcm.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index cdf8b76..fc7ce7c 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -354,17 +354,21 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
 		     get_endpoint(alts, 1)->bSynchAddress != 0 &&
 		     !implicit_fb)) {
-			snd_printk(KERN_ERR "%d:%d:%d : invalid synch pipe\n",
-				   dev->devnum, fmt->iface, fmt->altsetting);
+			snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. bmAttributes %02x, bLength %d, bSynchAddress %02x\n",
+				   dev->devnum, fmt->iface, fmt->altsetting,
+				   get_endpoint(alts, 1)->bmAttributes,
+				   get_endpoint(alts, 1)->bLength,
+				   get_endpoint(alts, 1)->bSynchAddress);
 			return -EINVAL;
 		}
 		ep = get_endpoint(alts, 1)->bEndpointAddress;
-		if (get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
+		if (!implicit_fb &&
+		    get_endpoint(alts, 0)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
 		    (( is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress | USB_DIR_IN)) ||
-		     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)) ||
-		     ( is_playback && !implicit_fb))) {
-			snd_printk(KERN_ERR "%d:%d:%d : invalid synch pipe\n",
-				   dev->devnum, fmt->iface, fmt->altsetting);
+		     (!is_playback && ep != (unsigned int)(get_endpoint(alts, 0)->bSynchAddress & ~USB_DIR_IN)))) {
+			snd_printk(KERN_ERR "%d:%d:%d : invalid sync pipe. is_playback %d, ep %02x, bSynchAddress %02x\n",
+				   dev->devnum, fmt->iface, fmt->altsetting,
+				   is_playback, ep, get_endpoint(alts, 0)->bSynchAddress);
 			return -EINVAL;
 		}
 
-- 
1.7.10.2
