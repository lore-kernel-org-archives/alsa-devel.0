From: Thomas Pugliese <thomas.pugliese@gmail.com>
Subject: [PATCH] ALSA: usb: use multiple packets per urb for
	Wireless USB inbound audio
Date: Tue, 26 Nov 2013 13:58:15 -0600
Message-ID: <1385495895-25189-1-git-send-email-thomas.pugliese@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f176.google.com (mail-ob0-f176.google.com
 [209.85.214.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B168261688
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 21:05:08 +0100 (CET)
Received: by mail-ob0-f176.google.com with SMTP id va2so6266890obc.21
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 12:05:07 -0800 (PST)
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
Cc: tiwai@suse.de, Thomas Pugliese <thomas.pugliese@gmail.com>
List-Id: alsa-devel@alsa-project.org

For Wireless USB audio devices, use multiple isoc packets per URB for
inbound endpoints with a datainterval < 5.  This allows the WUSB host
controller to take advantage of bursting to service endpoints whose
logical polling interval is less than the 4ms minimum polling interval
limit in WUSB.

Signed-off-by: Thomas Pugliese <thomas.pugliese@gmail.com>
---
 sound/usb/endpoint.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index b9ba0fc..83aabea2 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -636,8 +636,22 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 	if (usb_pipein(ep->pipe) ||
 			snd_usb_endpoint_implicit_feedback_sink(ep)) {
 
+		urb_packs = packs_per_ms;
+		/*
+		 * Wireless devices can poll at a max rate of once per 4ms.
+		 * For dataintervals less than 5, increase the packet count to
+		 * allow the host controller to use bursting to fill in the
+		 * gaps.
+		 */
+		if (snd_usb_get_speed(ep->chip->dev) == USB_SPEED_WIRELESS) {
+			int interval = ep->datainterval;
+			while (interval < 5) {
+				urb_packs <<= 1;
+				++interval;
+			}
+		}
 		/* make capture URBs <= 1 ms and smaller than a period */
-		urb_packs = min(max_packs_per_urb, packs_per_ms);
+		urb_packs = min(max_packs_per_urb, urb_packs);
 		while (urb_packs > 1 && urb_packs * maxsize >= period_bytes)
 			urb_packs >>= 1;
 		ep->nurbs = MAX_URBS;
-- 
1.7.10.4
