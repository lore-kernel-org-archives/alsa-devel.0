From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] sound: usb: quirks: Replace mdelay() with
	msleep() and usleep_range()
Date: Fri, 27 Jul 2018 16:55:28 +0800
Message-ID: <20180727085528.5802-1-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f66.google.com (mail-pl0-f66.google.com
 [209.85.160.66])
 by alsa0.perex.cz (Postfix) with ESMTP id CEEF926775C
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 10:55:37 +0200 (CEST)
Received: by mail-pl0-f66.google.com with SMTP id m1-v6so2042482plt.6
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2018 01:55:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, jussi@sonarnerd.net, nob77413@gmail.com, kai.heng.feng@canonical.com, elfring@users.sourceforge.net, daniel@zonque.org, ruslan.bilovol@gmail.com
Cc: alsa-devel@alsa-project.org, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_usb_select_mode_quirk(), snd_usb_set_interface_quirk() and 
snd_usb_ctl_msg_quirk() are never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/usb/quirks.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index acbeb52f6fd6..9eed650c54d4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1181,7 +1181,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 		if (err < 0)
 			return err;
 
-		mdelay(20); /* Delay needed after setting the interface */
+		msleep(20); /* Delay needed after setting the interface */
 
 		/* Vendor mode switch cmd is required. */
 		if (fmt->formats & SNDRV_PCM_FMTBIT_DSD_U32_BE) {
@@ -1202,7 +1202,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 				return err;
 
 		}
-		mdelay(20);
+		msleep(20);
 	}
 	return 0;
 }
@@ -1249,7 +1249,7 @@ void snd_usb_set_interface_quirk(struct usb_device *dev)
 	switch (USB_ID_VENDOR(chip->usb_id)) {
 	case 0x23ba: /* Playback Design */
 	case 0x0644: /* TEAC Corp. */
-		mdelay(50);
+		msleep(50);
 		break;
 	}
 }
@@ -1269,7 +1269,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	 */
 	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
+		msleep(20);
 
 	/*
 	 * "TEAC Corp." products need a 20ms delay after each
@@ -1277,14 +1277,14 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	 */
 	if (USB_ID_VENDOR(chip->usb_id) == 0x0644 &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
+		msleep(20);
 
 	/* ITF-USB DSD based DACs functionality need a delay
 	 * after each class compliant request
 	 */
 	if (is_itf_usb_dsd_dac(chip->usb_id)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(20);
+		msleep(20);
 
 	/* Zoom R16/24, Logitech H650e, Jabra 550a needs a tiny delay here,
 	 * otherwise requests like get/set frequency return as failed despite
@@ -1294,7 +1294,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	     chip->usb_id == USB_ID(0x046d, 0x0a46) ||
 	     chip->usb_id == USB_ID(0x0b0e, 0x0349)) &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
-		mdelay(1);
+		usleep_range(1000, 2000);
 }
 
 /*
-- 
2.17.0
