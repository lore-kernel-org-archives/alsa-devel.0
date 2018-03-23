From: Nobutaka Okabe <nob77413@gmail.com>
Subject: [PATCH 3/3] ALSA: usb-audio: Integrate native DSD
	support for ITF-USB based DACs.
Date: Fri, 23 Mar 2018 19:21:13 +0900
Message-ID: <20180323102113.6624-1-nob77413@gmail.com>
References: <20180323102000.6577-1-nob77413@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id DFA5C2673D2
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 11:21:20 +0100 (CET)
Received: by mail-pl0-f68.google.com with SMTP id f23-v6so7159009plr.10
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 03:21:20 -0700 (PDT)
In-Reply-To: <20180323102000.6577-1-nob77413@gmail.com>
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
Cc: Nobutaka Okabe <nob77413@gmail.com>, Jurgen Kramer <gtmkramer@xs4all.nl>
List-Id: alsa-devel@alsa-project.org

Integrate the native DSD support quirk codes of "ITF-USB DSD" based DACs.

Now, "is_itf_usb_dsd_2alts_dac()" and "is_itf_usb_dsd_3alts_dac()" is integrated
into one function "is_itf_usb_dsd_dac()".
So, remove the logic to distinguish UD-501 and UD-501V2 by the "Product Name".

The integration is possible by changing the following two functions.

- snd_usb_select_mode_quirk():
Change the determination condition of the DSD mode switch command,
from the altset number being used, to the audio format being played.
Actually, this operation is same as playback using ASIO driver in Windows environment.

- snd_usb_interface_dsd_format_quirk():
To which altset supports native DSD is determined by the number of altsets.
Previously, it's a constant "2" or "3".

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
---
 sound/usb/quirks.c | 81 ++++++++++++++----------------------------------------
 1 file changed, 20 insertions(+), 61 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3d2437e88122..57f8e8b09396 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1151,48 +1151,18 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 
 /* ITF-USB DSD based DACs need a vendor cmd to switch
  * between PCM and native DSD mode
- * (2 altsets version)
  */
-static bool is_itf_usb_dsd_2alts_dac(struct snd_usb_audio *chip)
+static bool is_itf_usb_dsd_dac(unsigned int id)
 {
-	char *product = chip->dev->product; /* DAC product name */
-
-	switch (chip->usb_id) {
+	switch (id) {
 	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
 	case USB_ID(0x1852, 0x5065): /* Luxman DA-06 */
-		return true;
-	case USB_ID(0x0644, 0x8043):
-		/* TEAC UD-501 */
-		if (product && strcmp("UD-501", product)) {
-			return true;
-		} else {
-			return false;
-		}
-	}
-	return false;
-}
-
-/* ITF-USB DSD based DACs need a vendor cmd to switch
- * between PCM and native DSD mode
- * (3 altsets version)
- */
-static bool is_itf_usb_dsd_3alts_dac(struct snd_usb_audio *chip)
-{
-	char *product = chip->dev->product; /* DAC product name */
-
-	switch (chip->usb_id) {
+	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-501V2/UD-503/NT-503 */
 	case USB_ID(0x0644, 0x8044): /* Esoteric D-05X */
 	case USB_ID(0x0644, 0x804a): /* TEAC UD-301 */
 		return true;
-	case USB_ID(0x0644, 0x8043):
-		/* TEAC UD-501V2/UD-503/NT-503 */
-		if (product && !strcmp("UD-501", product)) {
-			return true;
-		} else {
-			return false;
-		}
 	}
 	return false;
 }
@@ -1203,7 +1173,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 	struct usb_device *dev = subs->dev;
 	int err;
 
-	if (is_itf_usb_dsd_2alts_dac(subs->stream->chip)) {
+	if (is_itf_usb_dsd_dac(subs->stream->chip->usb_id)) {
 		/* First switch to alt set 0, otherwise the mode switch cmd
 		 * will not be accepted by the DAC
 		 */
@@ -1213,37 +1183,26 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 
 		mdelay(20); /* Delay needed after setting the interface */
 
-		switch (fmt->altsetting) {
-		case 2: /* DSD mode requested */
-		case 1: /* PCM mode requested */
-			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
-					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
-					      fmt->altsetting - 1, 1, NULL, 0);
-			if (err < 0)
-				return err;
-			break;
-		}
-		mdelay(20);
-	} else if (is_itf_usb_dsd_3alts_dac(subs->stream->chip)) {
 		/* Vendor mode switch cmd is required. */
-		switch (fmt->altsetting) {
-		case 3: /* DSD mode (DSD_U32) requested */
+		if (fmt->formats & SNDRV_PCM_FMTBIT_DSD_U32_BE) {
+			/* DSD mode (DSD_U32) requested */
 			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
 					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
 					      1, 1, NULL, 0);
 			if (err < 0)
 				return err;
-			break;
 
-		case 2: /* PCM or DOP mode (S32) requested */
-		case 1: /* PCM mode (S16) requested */
+		} else {
+			/* PCM or DOP mode (S32) requested */
+			/* PCM mode (S16) requested */
 			err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), 0,
 					      USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
 					      0, 1, NULL, 0);
 			if (err < 0)
 				return err;
-			break;
+
 		}
+		mdelay(20);
 	}
 	return 0;
 }
@@ -1323,7 +1282,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	/* ITF-USB DSD based DACs functionality need a delay
 	 * after each class compliant request
 	 */
-	if (is_itf_usb_dsd_2alts_dac(chip)
+	if (is_itf_usb_dsd_dac(chip->usb_id)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
@@ -1349,6 +1308,8 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 					struct audioformat *fp,
 					unsigned int sample_bytes)
 {
+	struct usb_interface *iface;
+
 	/* Playback Designs */
 	if (USB_ID_VENDOR(chip->usb_id) == 0x23ba) {
 		switch (fp->altsetting) {
@@ -1410,15 +1371,13 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		break;
 	}
 
-	/* ITF-USB DSD based DACs (2 altsets version) */
-	if (is_itf_usb_dsd_2alts_dac(chip)) {
-		if (fp->altsetting == 2)
-			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
-	}
+	/* ITF-USB DSD based DACs */
+	if (is_itf_usb_dsd_dac(chip->usb_id)) {
+		iface = usb_ifnum_to_if(chip->dev, fp->iface);
 
-	/* ITF-USB DSD based DACs (3 altsets version) */
-	if (is_itf_usb_dsd_3alts_dac(chip)) {
-		if (fp->altsetting == 3)
+		/* Altsetting 2 support native DSD if the num of altsets is three (0-2),
+		   Altsetting 3 support native DSD if the num of altsets is four (0-3). */
+		if (fp->altsetting == iface->num_altsetting - 1)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
-- 
2.11.1
