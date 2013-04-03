From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 05/10] ALSA: usb-audio: use endianness macros
Date: Wed,  3 Apr 2013 23:18:53 +0200
Message-ID: <1365023938-1461-6-git-send-email-eldad@fogrefinery.com>
References: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B7F265E00
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:21 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id ik5so1090893bkc.6
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:21 -0700 (PDT)
In-Reply-To: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Replace the endianness conversions with the kernel-wide swabbing macros
in get/set_sample_rate_v2.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index e3ccf3d..013b346 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -251,21 +251,21 @@ static int get_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 			      int altsetting, int clock)
 {
 	struct usb_device *dev = chip->dev;
-	unsigned char data[4];
+	__le32 data;
 	int err;
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
 			      UAC2_CS_CONTROL_SAM_FREQ << 8,
 			      snd_usb_ctrl_intf(chip) | (clock << 8),
-			      data, sizeof(data));
+			      &data, sizeof(data));
 	if (err < 0) {
 		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
 			   dev->devnum, iface, altsetting);
 		return 0;
 	}
 
-	return data[0] | (data[1] << 8) | (data[2] << 16) | (data[3] << 24);
+	return le32_to_cpu(data);
 }
 
 static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
@@ -273,7 +273,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 			      struct audioformat *fmt, int rate)
 {
 	struct usb_device *dev = chip->dev;
-	unsigned char data[4];
+	__le32 data;
 	int err, cur_rate, prev_rate;
 	int clock = snd_usb_clock_find_source(chip, fmt->clock);
 
@@ -289,15 +289,12 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 
 	prev_rate = get_sample_rate_v2(chip, iface, fmt->altsetting, clock);
 
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
-- 
1.8.1.5
