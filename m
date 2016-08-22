From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/3] ALSA: usb: move udh01_fb_quirk setting to
	quirks.c
Date: Mon, 22 Aug 2016 08:53:36 +0200
Message-ID: <1471848818-11860-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 24917265FFA
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 08:53:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: norman.nolte@gmx.net, T.Gresens@intershop.de, clemens@ladisch.de, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

That's a quirk, after all, so move it where to all the other quirks
live.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/usb/endpoint.c | 4 ----
 sound/usb/quirks.c   | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index c07a7ed..4b4ffa0 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -502,10 +502,6 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 			ep->syncinterval = 3;
 
 		ep->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
-
-		if (chip->usb_id == USB_ID(0x0644, 0x8038) /* TEAC UD-H01 */ &&
-		    ep->syncmaxsize == 4)
-			ep->udh01_fb_quirk = 1;
 	}
 
 	list_add_tail(&ep->list, &chip->ep_list);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 6cf1f35..299813f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1216,6 +1216,11 @@ void snd_usb_endpoint_start_quirk(struct snd_usb_endpoint *ep)
 	     ep->chip->usb_id == USB_ID(0x0763, 0x2031)) &&
 	    ep->type == SND_USB_ENDPOINT_TYPE_DATA)
 		ep->skip_packets = 16;
+
+	/* Work around devices that report unreasonable feedback data */
+	if (ep->chip->usb_id == USB_ID(0x0644, 0x8038) /* TEAC UD-H01 */ &&
+	    ep->syncmaxsize == 4)
+		ep->udh01_fb_quirk = 1;
 }
 
 void snd_usb_set_interface_quirk(struct usb_device *dev)
-- 
2.5.5
