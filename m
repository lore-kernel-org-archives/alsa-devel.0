From: Eduard Gilmutdinov <edgilmutdinov@gmail.com>
Subject: [RFC PATCH 1/2] Adds a check of the state of endpoints
	on the interface before invoking the usb_set_interface
Date: Tue, 13 May 2014 10:08:50 +0600
Message-ID: <1399954131-26516-2-git-send-email-edgilmutdinov@gmail.com>
References: <1399954131-26516-1-git-send-email-edgilmutdinov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f175.google.com (mail-lb0-f175.google.com
 [209.85.217.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 72ACC2652E5
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 06:09:10 +0200 (CEST)
Received: by mail-lb0-f175.google.com with SMTP id l4so8174347lbv.34
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 21:09:10 -0700 (PDT)
In-Reply-To: <1399954131-26516-1-git-send-email-edgilmutdinov@gmail.com>
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
Cc: mark@xwax.org, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Eduard Gilmutdinov <edgilmutdinov@gmail.com>
---
 sound/usb/pcm.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c62a165..e6edfaf 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -453,7 +453,7 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	struct usb_host_interface *alts;
 	struct usb_interface_descriptor *altsd;
 	struct usb_interface *iface;
-	int err;
+	int err, need_init, i;
 
 	iface = usb_ifnum_to_if(dev, fmt->iface);
 	if (WARN_ON(!iface))
@@ -482,15 +482,28 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	/* set interface */
 	if (subs->interface != fmt->iface ||
 	    subs->altset_idx != fmt->altset_idx) {
-		err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
-		if (err < 0) {
-			dev_err(&dev->dev,
-				"%d:%d: usb_set_interface failed (%d)\n",
-				fmt->iface, fmt->altsetting, err);
-			return -EIO;
+
+		need_init = iface->cur_altsetting != alts;
+
+		if (need_init) {
+			err = usb_set_interface(dev, fmt->iface, fmt->altsetting);
+			if (err < 0) {
+				dev_err(&dev->dev,
+					"%d:%d: usb_set_interface failed (%d)\n",
+					fmt->iface, fmt->altsetting, err);
+				return -EIO;
+			}
+			dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
+				fmt->iface, fmt->altsetting);
+		}
+
+		for (i = 0; i < alts->desc.bNumEndpoints; ++i) {
+			if (alts->endpoint[i].desc.bEndpointAddress == fmt->endpoint)
+				alts->endpoint[i].enabled = 1;
+			else if (need_init)
+				alts->endpoint[i].enabled = 0;
 		}
-		dev_dbg(&dev->dev, "setting usb interface %d:%d\n",
-			fmt->iface, fmt->altsetting);
+
 		subs->interface = fmt->iface;
 		subs->altset_idx = fmt->altset_idx;
 
@@ -1210,11 +1223,25 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream, int direction)
 {
 	struct snd_usb_stream *as = snd_pcm_substream_chip(substream);
 	struct snd_usb_substream *subs = &as->substream[direction];
+	struct usb_interface *iface;
+	struct usb_host_interface *cur_alts;
+	int i, ep_active = 0;
 
 	stop_endpoints(subs, true);
 
 	if (!as->chip->shutdown && subs->interface >= 0) {
-		usb_set_interface(subs->dev, subs->interface, 0);
+		iface = usb_ifnum_to_if(subs->dev, subs->interface);
+		cur_alts = iface->cur_altsetting;
+		for (i = 0; i < cur_alts->desc.bNumEndpoints; ++i) {
+			if (cur_alts->endpoint[i].desc.bEndpointAddress == subs->ep_num)
+				cur_alts->endpoint[i].enabled = 0;
+
+			ep_active += cur_alts->endpoint[i].enabled;
+		}
+
+		if (!ep_active)
+			usb_set_interface(subs->dev, subs->interface, 0);
+
 		subs->interface = -1;
 	}
 
-- 
1.9.2
