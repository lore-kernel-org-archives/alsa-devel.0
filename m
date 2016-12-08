From: Alberto Aguirre <albaguirre@gmail.com>
Subject: [PATCH] ALSA: usb-audio: add implicit fb quirk for
	Axe-Fx II
Date: Thu,  8 Dec 2016 00:36:48 -0600
Message-ID: <20161208063648.28856-1-albaguirre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FBB92673A1
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 07:37:06 +0100 (CET)
Received: by mail-oi0-f66.google.com with SMTP id v84so48765985oie.2
 for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2016 22:37:06 -0800 (PST)
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
Cc: Alberto Aguirre <albaguirre@gmail.com>
List-Id: alsa-devel@alsa-project.org

The Axe-Fx II implicit feedback end point and the data sync endpoint
are in different interface descriptors. Add quirk to ensure a sync
endpoint is properly configured.

Signed-off-by: Alberto Aguirre <albaguirre@gmail.com>
---
 sound/usb/pcm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 44d178e..0fe2d56 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -348,6 +348,16 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 
 		alts = &iface->altsetting[1];
 		goto add_sync_ep;
+	case USB_ID(0x2466, 0x8003):
+		ep = 0x86;
+		iface = usb_ifnum_to_if(dev, 2);
+
+		if (!iface || iface->num_altsetting == 0)
+			return -EINVAL;
+
+		alts = &iface->altsetting[1];
+		goto add_sync_ep;
+
 	}
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
 	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
-- 
2.9.3
