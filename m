From: Nobutaka Okabe <nob77413@gmail.com>
Subject: [PATCH 2/3] ALSA: usb-audio: FIX native DSD support
	for TEAC UD-501 DAC
Date: Fri, 23 Mar 2018 19:20:00 +0900
Message-ID: <20180323102000.6577-1-nob77413@gmail.com>
References: <20180323101822.6529-1-nob77413@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 34FB12673D2
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 11:20:18 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id t9so3027798pgo.3
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 03:20:18 -0700 (PDT)
In-Reply-To: <20180323101822.6529-1-nob77413@gmail.com>
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

There are two versions of TEAC UD-501, the normal version and
the vendor updated version(UD-501V2).

They have the same VID/PID, but the num of the altsetting is different,
UD-501 has 2 altsets for stream, and UD-501V2 has 3.

So, add the logic to distinguish them by the Product Name, not by the PID.

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
---
 sound/usb/quirks.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 006da37ad0d9..3d2437e88122 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1153,14 +1153,23 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
  * between PCM and native DSD mode
  * (2 altsets version)
  */
-static bool is_itf_usb_dsd_2alts_dac(unsigned int id)
+static bool is_itf_usb_dsd_2alts_dac(struct snd_usb_audio *chip)
 {
-	switch (id) {
+	char *product = chip->dev->product; /* DAC product name */
+
+	switch (chip->usb_id) {
 	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
 	case USB_ID(0x1852, 0x5065): /* Luxman DA-06 */
 		return true;
+	case USB_ID(0x0644, 0x8043):
+		/* TEAC UD-501 */
+		if (product && strcmp("UD-501", product)) {
+			return true;
+		} else {
+			return false;
+		}
 	}
 	return false;
 }
@@ -1169,13 +1178,21 @@ static bool is_itf_usb_dsd_2alts_dac(unsigned int id)
  * between PCM and native DSD mode
  * (3 altsets version)
  */
-static bool is_itf_usb_dsd_3alts_dac(unsigned int id)
+static bool is_itf_usb_dsd_3alts_dac(struct snd_usb_audio *chip)
 {
-	switch (id) {
-	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
+	char *product = chip->dev->product; /* DAC product name */
+
+	switch (chip->usb_id) {
 	case USB_ID(0x0644, 0x8044): /* Esoteric D-05X */
 	case USB_ID(0x0644, 0x804a): /* TEAC UD-301 */
 		return true;
+	case USB_ID(0x0644, 0x8043):
+		/* TEAC UD-501V2/UD-503/NT-503 */
+		if (product && !strcmp("UD-501", product)) {
+			return true;
+		} else {
+			return false;
+		}
 	}
 	return false;
 }
@@ -1186,7 +1203,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 	struct usb_device *dev = subs->dev;
 	int err;
 
-	if (is_itf_usb_dsd_2alts_dac(subs->stream->chip->usb_id)) {
+	if (is_itf_usb_dsd_2alts_dac(subs->stream->chip)) {
 		/* First switch to alt set 0, otherwise the mode switch cmd
 		 * will not be accepted by the DAC
 		 */
@@ -1207,7 +1224,7 @@ int snd_usb_select_mode_quirk(struct snd_usb_substream *subs,
 			break;
 		}
 		mdelay(20);
-	} else if (is_itf_usb_dsd_3alts_dac(subs->stream->chip->usb_id)) {
+	} else if (is_itf_usb_dsd_3alts_dac(subs->stream->chip)) {
 		/* Vendor mode switch cmd is required. */
 		switch (fmt->altsetting) {
 		case 3: /* DSD mode (DSD_U32) requested */
@@ -1306,7 +1323,7 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	/* ITF-USB DSD based DACs functionality need a delay
 	 * after each class compliant request
 	 */
-	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)
+	if (is_itf_usb_dsd_2alts_dac(chip)
 	    && (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		mdelay(20);
 
@@ -1394,13 +1411,13 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	}
 
 	/* ITF-USB DSD based DACs (2 altsets version) */
-	if (is_itf_usb_dsd_2alts_dac(chip->usb_id)) {
+	if (is_itf_usb_dsd_2alts_dac(chip)) {
 		if (fp->altsetting == 2)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
 
 	/* ITF-USB DSD based DACs (3 altsets version) */
-	if (is_itf_usb_dsd_3alts_dac(chip->usb_id)) {
+	if (is_itf_usb_dsd_3alts_dac(chip)) {
 		if (fp->altsetting == 3)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 	}
-- 
2.11.1
