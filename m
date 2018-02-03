From: Lassi Ylikojola <lassi.ylikojola@gmail.com>
Subject: [PATCH] ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204
Date: Sat, 3 Feb 2018 16:42:40 +0200
Message-ID: <0132cbb2-34f8-b85c-383d-d639d938c836@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, arvind.yadav.cs@gmail.com, lassi.ylikojola@gmail.com, bhumirks@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add quirk to ensure a sync endpoint is properly configured.
This patch is a fix for same symptoms on Behringer UFX1204 as patch
from Albertto Aquirre on Dec 8 2016 for Axe-Fx II.

Signed-off-by: Lassi Ylikojola <lassi.ylikojola@gmail.com>
---
 sound/usb/pcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b9c9a19f9588..2d8b9e19e99b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -352,6 +352,15 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
                ep = 0x86;
                iface = usb_ifnum_to_if(dev, 2);
 
+               if (!iface || iface->num_altsetting == 0)
+                       return -EINVAL;
+
+               alts = &iface->altsetting[1];
+               goto add_sync_ep;
+       case USB_ID(0x1397, 0x0002): /* Behringer UFX1204 */
+               ep = 0x81;
+               iface = usb_ifnum_to_if(dev, 1);
+
                if (!iface || iface->num_altsetting == 0)
                        return -EINVAL;
 
-- 
2.14.3
