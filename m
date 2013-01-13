From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 2/3] ALSA: usb-audio: M-Audio FT C400 skip
	packet quirk
Date: Sun, 13 Jan 2013 23:02:03 +0100
Message-ID: <1358114524-5152-3-git-send-email-eldad@fogrefinery.com>
References: <1358114524-5152-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 4421E265113
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 23:02:23 +0100 (CET)
Received: by mail-bk0-f46.google.com with SMTP id q16so1685550bkw.19
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2013 14:02:22 -0800 (PST)
In-Reply-To: <1358114524-5152-1-git-send-email-eldad@fogrefinery.com>
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
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Attain constant real-world latency by skipping 16 data packets.
The number of packets to be skipped was found by trial and error.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index acc12f0..ace0210 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -859,6 +859,17 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 	if ((le16_to_cpu(ep->chip->dev->descriptor.idVendor) == 0x23ba) &&
 	    ep->type == SND_USB_ENDPOINT_TYPE_SYNC)
 		ep->skip_packets = 4;
+
+	/*
+	 * M-Audio Fast Track C400 - when packets are not skipped, real world
+	 * latency varies by approx. +/- 50 frames (at 96KHz) each time the
+	 * stream is (re)started. When skipping packets 16 at endpoint start
+	 * up, the real world latency is stable within +/- 1 frame (also
+	 * across power cycles).
+	 */
+	if (ep->chip->usb_id == USB_ID(0x0763, 0x2030) &&
+	    ep->type == SND_USB_ENDPOINT_TYPE_DATA)
+		ep->skip_packets = 16;
 }
 
 void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
-- 
1.7.12.4
