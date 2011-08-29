From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] sound: usb: mixer: increase control transfer timeout
Date: Mon, 29 Aug 2011 14:10:26 +0300
Message-ID: <1314616226-15942-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

100ms might not be enough for slower devices. Increasing
timeout to 1000ms doesn't seem like overkill.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---

Not sure this information is valid on a commit log, but I
have a FPGA-platform which I use to test my USB controller
and when that's running on FS, this message fails because
control message times out before controller has the opportunity
to complete all three phases of the SETUP transaction.

 sound/usb/mixer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index cdd19d7..a3cbc98 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -296,7 +296,7 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request, int v
 		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
-				    buf, val_len, 100) >= val_len) {
+				    buf, val_len, 1000) >= val_len) {
 			*value_ret = convert_signed_value(cval, snd_usb_combine_bytes(buf, val_len));
 			snd_usb_autosuspend(cval->mixer->chip);
 			return 0;
-- 
1.7.6.396.ge0613

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
