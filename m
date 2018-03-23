From: Nobutaka Okabe <nob77413@gmail.com>
Subject: [PATCH 1/3] ALSA: usb-audio: Add native DSD support
	for Luxman DA-06
Date: Fri, 23 Mar 2018 19:18:22 +0900
Message-ID: <20180323101822.6529-1-nob77413@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BB1312673C9
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 11:19:17 +0100 (CET)
Received: by mail-pl0-f68.google.com with SMTP id c11-v6so7161020plo.0
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 03:19:17 -0700 (PDT)
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

Add native DSD support quirk for Luxman DA-06 DAC, by adding the PID/VID 1852:5065.

Rename "is_marantz_denon_dac()" function to "is_itf_usb_dsd_2alts_dac()"
to cover broader device family sharing the same USB audio implementation(*).
For the same reason, rename "is_teac_dsd_dac()" function to "is_itf_usb_dsd_3alts_dac()".

(*)
These devices have the same USB controller "ITF-USB DSD", supplied by INTERFACE Co., Ltd.
"ITF-USB DSD" USB controller has two patterns,

Pattern 1. (2 altsets version)
- Altset 0: for control
- Altset 1: for stream (S32)
- Altset 2: for stream (S32, DSD_U32)

Pattern 2. (3 altsets version)
- Altset 0: for control
- Altset 1: for stream (S16)
- Altset 2: for stream (S32)
- Altset 3: for stream (S32, DSD_U32)

"is_itf_usb_dsd_2alts_dac()" returns true, if the DAC has "Pattern 1" USB controller,
and "is_itf_usb_dsd_3alts_dac()" returns true, if "Pattern2".

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
---
 sound/usb/quirks.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 794224e1d6df..006da37ad0d9 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1149,24 +1149,27 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 	return false;
 }
 
-/* Marantz/Denon USB DACs need a vendor cmd to switch
+/* ITF-USB DSD based DACs need a vendor cmd to switch
  * between PCM and native DSD mode
+ * (2 altsets version)
  */
-static bool is_marantz_denon_dac(unsigned int id)
+static bool is_itf_usb_dsd_2alts_dac(unsigned int id)
 {
 	switch (id) {
 	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
+	case USB_ID(0x1852, 0x5065): /* Luxman DA-06 */
 		return true;
 	}
 	return false;
 }
 
-/* TEAC UD-501/UD-503/NT-503 USB DACs need a vendor cmd to switch
- * between PCM/DOP and native DSD mode
+/* ITF-USB DSD based DACs need a vendor cmd to switch
+ * between PCM and native DSD mode
+ * (3 altsets version)
  */
-static bool is_teac_dsd_dac(unsigned int id)
+static bool is_itf_usb_dsd_3alts_dac(unsigned int id)
 {
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
@@ -1183,7 +1186,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 	struct usb_device *dev = subs->dev;
 	int err;
 
-	if (is_marantz_denon_dac(subs->stream->chip->usb_id)) {
+	if (is_itf_usb_dsd_2alts_dac(subs->stream->chip->usb_id)) {
 		/* First switch to alt set 0, otherwise the mode switch cmd
 		 * will not be accepted by the DAC
 		 */
@@ -1204,7 +1207,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 			break;
 		}
 		mdelay(20);
-	} else if (is_teac_dsd_dac(subs->stream->chip->usb_id)) {
+	} else if (is_itf_usb_dsd_3alts_dac(subs->stream->chip->usb_id)) {
 		/* Vendor mode switch cmd is required. */
 		switch (fmt->altsetting) {
 		case 3: /* DSD mode (DSD_U32) requested */
@@ -1300,10 +1303,10 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
-	/* Marantz/Denon devices with USB DAC functionality need a delay
+	/* ITF-USB DSD based DACs functionality need a delay
 	 * after each class compliant request
 	 */
-	if (is_marantz_denon_dac(chip->usb_id)
+	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
@@ -1390,14 +1393,14 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 		break;
 	}
 
-	/* Denon/Marantz devices with USB DAC functionality */
-	if (is_marantz_denon_dac(chip->usb_id)) {
+	/* ITF-USB DSD based DACs (2 altsets version) */
+	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)) {
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
-	/* TEAC devices with USB DAC functionality */
-	if (is_teac_dsd_dac(chip->usb_id)) {
+	/* ITF-USB DSD based DACs (3 altsets version) */
+	if (is_itf_usb_dsd_3alts_dac(chip->usb_id)) {
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
-- 
2.11.1
