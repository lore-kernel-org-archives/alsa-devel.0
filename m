From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 2/2] snd-usb-audio: Add duplex mode for
	Digidesign Mbox 1 and enable mixer
Date: Tue,  4 Nov 2014 11:06:37 +1100
Message-ID: <1415059597-18344-3-git-send-email-damien@zamaudio.com>
References: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 16BBA260553
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 01:07:03 +0100 (CET)
Received: by mail-pd0-f170.google.com with SMTP id z10so12542716pdj.29
 for <alsa-devel@alsa-project.org>; Mon, 03 Nov 2014 16:07:03 -0800 (PST)
In-Reply-To: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
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
Cc: Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

This patch provides duplex support for the Digidesign Mbox 1 sound
card and has been a work in progress for about a year.
Users have confirmed on my website that previous versions of this patch
have worked on the hardware and I have been testing extensively.

It also enables the mixer control for providing clock source
selector based on the previous patch.

The sample rate has been hardcoded to 48kHz because it works better with
the S/PDIF sync mode when the sample rate is locked.  This is the
highest rate that the device supports and no loss of functionality
is observed by restricting the sample rate.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/card.h         |  5 ++++
 sound/usb/quirks-table.h | 73 ++++++++++++++++++++++++++++++++----------------
 sound/usb/quirks.c       | 30 ++++++++++++++++++++
 sound/usb/usbaudio.h     |  1 +
 4 files changed, 85 insertions(+), 24 deletions(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 97acb90..a8fe22f 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -33,6 +33,11 @@ struct audioformat {
 	bool dsd_bitrev;		/* reverse the bits of each DSD sample */
 };
 
+struct audioformats {
+	unsigned int n_formats;
+	const struct audioformat *format;
+};
+
 struct snd_usb_substream;
 struct snd_usb_endpoint;
 
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c657752..0b5f4fb 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2937,43 +2937,68 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	/* Thanks to Clemens Ladisch <clemens@ladisch.de> */
 	USB_DEVICE(0x0dba, 0x1000),
 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
-		.vendor_name = "Digidesign",
-		.product_name = "MBox",
-		.ifnum = QUIRK_ANY_INTERFACE,
-		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]){
-			{
-				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE,
-			},
-			{
-				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
+	.vendor_name = "Digidesign",
+	.product_name = "MBox",
+	.ifnum = QUIRK_ANY_INTERFACE,
+	.type = QUIRK_COMPOSITE,
+	.data = (const struct snd_usb_audio_quirk[]) {
+		{
+			.ifnum = 0,
+			.type = QUIRK_AUDIO_STANDARD_MIXER,
+		},
+		{
+			.ifnum = 1,
+			.type = QUIRK_AUDIO_FIXED_MULTI_ENDPOINT,
+			.data = &(const struct audioformats)
+			{
+				.n_formats = 2,
+				.format = (const struct audioformat[]) {
+					{
 					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
 					.channels = 2,
 					.iface = 1,
 					.altsetting = 1,
 					.altset_idx = 1,
-					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.attributes = 0x4,
 					.endpoint = 0x02,
-					.ep_attr = 0x01,
-					.rates = SNDRV_PCM_RATE_44100 |
-						 SNDRV_PCM_RATE_48000,
-					.rate_min = 44100,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_SYNC,
+					.maxpacksize = 0x130,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
 					.rate_max = 48000,
-					.nr_rates = 2,
+					.nr_rates = 1,
 					.rate_table = (unsigned int[]) {
-						44100, 48000
+						48000
+					}
+					},
+					{
+					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+					.channels = 2,
+					.iface = 1,
+					.altsetting = 1,
+					.altset_idx = 1,
+					.attributes = 0x4,
+					.endpoint = 0x81,
+					.ep_attr = USB_ENDPOINT_XFER_ISOC |
+						USB_ENDPOINT_SYNC_ASYNC,
+					.maxpacksize = 0x130,
+					.rates = SNDRV_PCM_RATE_48000,
+					.rate_min = 48000,
+					.rate_max = 48000,
+					.nr_rates = 1,
+					.rate_table = (unsigned int[]) {
+						48000
+					}
 					}
 				}
-			},
-			{
-				.ifnum = -1
 			}
+		},
+		{
+			.ifnum = -1
 		}
-
 	}
+}
 },
 
 /* DIGIDESIGN MBOX 2 */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d2aa45a..90227cd 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -180,6 +180,34 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	return 0;
 }
 
+/*
+ * create N streams for an interface without proper descriptors but with
+ * multiple endpoints
+ */
+static int create_fixed_multi_stream_quirk(struct snd_usb_audio *chip,
+				     struct usb_interface *iface,
+				     struct usb_driver *driver,
+				     const struct snd_usb_audio_quirk *quirk)
+{
+	struct audioformats *fp;
+	int i;
+
+	fp = kmemdup(quirk->data, sizeof(*fp), GFP_KERNEL);
+	if (!fp) {
+		usb_audio_err(chip, "cannot memdup\n");
+		return -ENOMEM;
+	}
+	for (i = 0; i < fp->n_formats; i++) {
+		struct snd_usb_audio_quirk nquirk = {
+			.ifnum = quirk->ifnum,
+			.type = QUIRK_AUDIO_FIXED_MULTI_ENDPOINT,
+			.data = (const struct audioformat *) &fp->format[i]
+		};
+		create_fixed_stream_quirk(chip, iface, driver, &nquirk);
+	}
+	return 0;
+}
+
 static int create_auto_pcm_quirk(struct snd_usb_audio *chip,
 				 struct usb_interface *iface,
 				 struct usb_driver *driver)
@@ -528,6 +556,8 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_FTDI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
+		[QUIRK_AUDIO_FIXED_MULTI_ENDPOINT] =
+			create_fixed_multi_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
 		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
 		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 91d0380..31d8ff0 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -96,6 +96,7 @@ enum quirk_type {
 	QUIRK_MIDI_FTDI,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
+	QUIRK_AUDIO_FIXED_MULTI_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UAXX,
 	QUIRK_AUDIO_ALIGN_TRANSFER,
 	QUIRK_AUDIO_STANDARD_MIXER,
-- 
1.9.1
