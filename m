From: Nobutaka Okabe <nob77413@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Add native DSD support for
	TEAC 501/503 DAC
Date: Tue, 13 Dec 2016 01:24:08 +0900
Message-ID: <1481559848-27750-1-git-send-email-nob77413@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C552266B71
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 17:24:22 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id e9so1411527pgc.1
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 08:24:22 -0800 (PST)
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
Cc: Nobutaka Okabe <nob77413@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds native DSD support for the following devices.

- TEAC NT-503
- TEAC UD-503
- TEAC UD-501

(1)Add quirks for native DSD support for TEAC devices.
(2)A specific vendor command is needed to switch between PCM/DOP and DSD mode, same as Denon/Marantz devices.

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
---
 sound/usb/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 2782155..b3fd238 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1165,6 +1165,18 @@ static bool is_marantz_denon_dac(unsigned int id)
 	return false;
 }
 
+/* TEAC UD-501/UD-503/NT-503 USB DACs need a vendor cmd to switch
+ * between PCM/DOP and native DSD mode
+ */
+static bool is_teac_50X_dac(unsigned int id)
+{
+	switch (id) {
+	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
+		return true;
+	}
+	return false;
+}
+
 int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 			      struct audioformat *fmt)
 {
@@ -1192,6 +1204,26 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 			break;
 		}
 		mdelay(20);
+	} else if (is_teac_50X_dac(subs->stream->chip->usb_id)) {
+		/* Vendor mode switch cmd is required. */
+		switch (fmt->altsetting) {
+		case 3: /* DSD mode (DSD_U32) requested */
+			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
+					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+					      1, 1, NULL, 0);
+			if (err < 0)
+				return err;
+			break;
+
+		case 2: /* PCM or DOP mode (S32) requested */
+		case 1: /* PCM mode (S16) requested */
+			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
+					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
+					      0, 1, NULL, 0);
+			if (err < 0)
+				return err;
+			break;
+		}
 	}
 	return 0;
 }
@@ -1337,5 +1369,11 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
+	/* TEAC devices with USB DAC functionality */
+	if (is_teac_50X_dac(chip->usb_id)) {
+		if (fp->altsetting == 3)
+			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
+	}
+
 	return 0;
 }
-- 
2.7.4
