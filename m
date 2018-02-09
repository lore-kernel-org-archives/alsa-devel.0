From: Lassi Ylikojola <lassi.ylikojola@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: add implicit fb quirk for Behringer
 UFX1204
Date: Fri, 9 Feb 2018 16:51:36 +0200
Message-ID: <95a0b1fe-24e3-e902-8452-0b28c2c95315@gmail.com>
References: <0132cbb2-34f8-b85c-383d-d639d938c836@gmail.com>
 <s5htvut5p1q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htvut5p1q.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arvind.yadav.cs@gmail.com, bhumirks@gmail.com, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add quirk to ensure a sync endpoint is properly configured.
This patch is a fix for same symptoms on Behringer UFX1204 as patch
from Albertto Aquirre on Dec 8 2016 for Axe-Fx II.
Resending. Seems that there is a difference between git diff/commit versions 2.7.4 and 2.14.3.
I had to insert a line break with 2.4.13 to align properly(hopefully). 

Signed-off-by: Lassi Ylikojola <lassi.ylikojola@gmail.com>
---
 sound/usb/pcm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b9c9a19f9588..116a6ccc5b31 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -357,6 +357,16 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 
                alts = &iface->altsetting[1];
                goto add_sync_ep;
+       case USB_ID(0x1397, 0x0002):
+               ep = 0x81;
+               iface = usb_ifnum_to_if(dev, 1);
+
+               if (!iface || iface->num_altsetting == 0)
+                       return -EINVAL;
+
+               alts = &iface->altsetting[1];
+               goto add_sync_ep;
+
 
        }
        if (attr == USB_ENDPOINT_SYNC_ASYNC &&
-- 
2.14.3
