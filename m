From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v4 01/10] usb-audio: replace hardcoded value with const
Date: Wed, 28 Nov 2012 23:55:32 +0100
Message-ID: <1354143341-1623-2-git-send-email-eldad@fogrefinery.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9683C264F06
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 23:55:49 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5643893bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 14:55:49 -0800 (PST)
In-Reply-To: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

In this context, 0x01 is USB_ENDPOINT_XFER_ISOC.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index ef6fa24..ff8cbbf 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -381,7 +381,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 		/* ... and check descriptor size before accessing bSynchAddress
 		   because there is a version of the SB Audigy 2 NX firmware lacking
 		   the audio fields in the endpoint descriptors */
-		if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != 0x01 ||
+		if ((get_endpoint(alts, 1)->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) != USB_ENDPOINT_XFER_ISOC ||
 		    (get_endpoint(alts, 1)->bLength >= USB_DT_ENDPOINT_AUDIO_SIZE &&
 		     get_endpoint(alts, 1)->bSynchAddress != 0 &&
 		     !implicit_fb)) {
-- 
1.7.8.6
