From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 05/10] ALSA: usb-audio: use endianness macros
Date: Sun, 31 Mar 2013 17:52:27 +0200
Message-ID: <1364745152-1762-6-git-send-email-eldad@fogrefinery.com>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 086F326171C
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:53:15 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id i18so676095bkv.0
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:53:14 -0700 (PDT)
In-Reply-To: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Replace the endianness conversions with the kernel-wide swabbing macros.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 5e634a2..47b601d 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -252,7 +252,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 			      struct audioformat *fmt, int rate)
 {
 	struct usb_device *dev = chip->dev;
-	unsigned char data[4];
+	u32 data;
 	int err, crate;
 	int clock = snd_usb_clock_find_source(chip, fmt->clock);
 
@@ -266,15 +266,12 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 		return -ENXIO;
 	}
 
-	data[0] = rate;
-	data[1] = rate >> 8;
-	data[2] = rate >> 16;
-	data[3] = rate >> 24;
+	data = cpu_to_le32(rate);
 	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
 				   UAC2_CS_CONTROL_SAM_FREQ << 8,
 				   snd_usb_ctrl_intf(chip) | (clock << 8),
-				   data, sizeof(data))) < 0) {
+				   &data, sizeof(data))) < 0) {
 		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2)\n",
 			   dev->devnum, iface, fmt->altsetting, rate);
 		return err;
@@ -284,13 +281,13 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 				   UAC2_CS_CONTROL_SAM_FREQ << 8,
 				   snd_usb_ctrl_intf(chip) | (clock << 8),
-				   data, sizeof(data))) < 0) {
+				   &data, sizeof(rate))) < 0) {
 		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
 			   dev->devnum, iface, fmt->altsetting);
 		return err;
 	}
 
-	crate = data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
+	crate = le32_to_cpu(data);
 	if (crate != rate)
 		snd_printd(KERN_WARNING "current rate %d is different from the runtime rate %d\n", crate, rate);
 
-- 
1.8.1.5
