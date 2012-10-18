From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] ALSA: snd-usb: remove unused variable in init_pitch_v2()
Date: Thu, 18 Oct 2012 22:46:23 +0800
Message-ID: <CAPgLHd93+h76d2ABQCAaeM2PEuVQdBSTcuGAk_PG63AjCP0D6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

The variable ep is initialized but never used
otherwise, so remove the unused variable.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/usb/pcm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 55e19e1..f77b87a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -171,11 +171,8 @@ static int init_pitch_v2(struct snd_usb_audio *chip, int iface,
 {
 	struct usb_device *dev = chip->dev;
 	unsigned char data[1];
-	unsigned int ep;
 	int err;
 
-	ep = get_endpoint(alts, 0)->bEndpointAddress;
-
 	data[0] = 1;
 	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_OUT,
