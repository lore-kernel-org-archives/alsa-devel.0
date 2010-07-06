From: Felix Homann <fexpop@web.de>
Subject: [PATCH - Fix Fast Track Ultra series: 44.1/88.1 kHz
 1/Fix playback/capture issues and related chrashes at 44100 Hz and 88200 Hz
 for M-Audio Fast Track Ultra series.
Date: Tue, 06 Jul 2010 10:05:06 +0200
Message-ID: <4C32E3B2.5080707@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090100050500090907030802"
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Felix Homann <fexpop@web.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090100050500090907030802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes issues with M-Audio's Fast Track Ultra series:

* devices now work at 44100 and 88200 Hz
* apparently, fixes some crashes, too

This is based on a patch posted by user 'dhubsith' on the M-Audio user 
forum.

Sorry for not sending via 'git send-email': I just don't get it...

Kind regards,

Felix

--------------090100050500090907030802
Content-Type: text/x-patch;
 name="0001-fix-sample-rates-ftu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fix-sample-rates-ftu.patch"

>From 57cd7afd0b0fbccd80acab16e617cf8a844e37d1 Mon Sep 17 00:00:00 2001
From: Felix <fexpop@web.de>
Date: Tue, 6 Jul 2010 09:16:17 +0200
Subject: [PATCH - Fix Fast Track Ultra series: 44.1/88.1 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and 88200 Hz for M-Audio Fast Track Ultra series.


Signed-off-by: Felix <fexpop@web.de>

diff --git a/usb/endpoint.c b/usb/endpoint.c
index 1a701f1..bb9f938 100644
--- a/usb/endpoint.c
+++ b/usb/endpoint.c
@@ -404,8 +404,6 @@ int snd_usb_parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 			break;
 		case USB_ID(0x041e, 0x3020): /* Creative SB Audigy 2 NX */
 		case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
-		case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra 8 */
-		case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
 			/* doesn't set the sample rate attribute, but supports it */
 			fp->attributes |= UAC_EP_CS_ATTR_SAMPLE_RATE;
 			break;
diff --git a/usb/quirks-table.h b/usb/quirks-table.h
index f8797f6..af9c2a1 100644
--- a/usb/quirks-table.h
+++ b/usb/quirks-table.h
@@ -1827,10 +1827,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 {
-	USB_DEVICE(0x0763, 0x2080),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		USB_DEVICE(0x0763, 0x2081),
+		.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "M-Audio", */
-		/* .product_name = "Fast Track Ultra 8", */
+		/* .product_name = "Fast Track Ultra", */
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
 		.data = & (const struct snd_usb_audio_quirk[]) {
@@ -1840,11 +1840,51 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 8,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x01,
+					.ep_attr = 0x01,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200, 96000
+					}
+				}
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 8,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x81,
+					.ep_attr = 0x01,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200, 96000
+					}
+				}
 			},
 			/* interface 3 (MIDI) is standard compliant */
 			{
@@ -1855,7 +1895,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 },
 {
 	USB_DEVICE(0x0763, 0x2081),
-	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
 		/* .vendor_name = "M-Audio", */
 		/* .product_name = "Fast Track Ultra 8R", */
 		.ifnum = QUIRK_ANY_INTERFACE,
@@ -1867,11 +1907,51 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 8,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x01,
+					.ep_attr = 0x01,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+							44100, 48000, 88200, 96000
+					}
+				}
 			},
 			{
 				.ifnum = 2,
-				.type = QUIRK_AUDIO_STANDARD_INTERFACE
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = & (const struct audioformat) {
+					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.channels = 8,
+					.iface = 2,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint = 0x81,
+					.ep_attr = 0x01,
+					.rates = SNDRV_PCM_RATE_44100 |
+						SNDRV_PCM_RATE_48000 |
+						SNDRV_PCM_RATE_88200 |
+						SNDRV_PCM_RATE_96000,
+					.rate_min = 44100,
+					.rate_max = 96000,
+					.nr_rates = 4,
+					.rate_table = (unsigned int[]) {
+						44100, 48000, 88200, 96000
+					}
+				}
 			},
 			/* interface 3 (MIDI) is standard compliant */
 			{
-- 
1.7.0.4


--------------090100050500090907030802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090100050500090907030802--
