From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 2/2 v3] ALSA: usb-audio: Add duplex mode for
	Digidesign Mbox 1 and enable mixer
Date: Mon, 10 Nov 2014 18:46:52 +1100
Message-ID: <1415605612-2977-3-git-send-email-damien@zamaudio.com>
References: <1415605612-2977-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 48609260638
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 08:47:25 +0100 (CET)
Received: by mail-pd0-f175.google.com with SMTP id y13so7353362pdi.34
 for <alsa-devel@alsa-project.org>; Sun, 09 Nov 2014 23:47:24 -0800 (PST)
In-Reply-To: <1415605612-2977-1-git-send-email-damien@zamaudio.com>
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
Cc: tiwai@suse.de, Damien Zammit <damien@zamaudio.com>, clemens@ladisch.de
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
is observed by restricting the sample rate apart from the inability to select
a lower rate.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/quirks-table.h | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index c657752..19eee96 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2941,10 +2941,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		.product_name = "MBox",
 		.ifnum = QUIRK_ANY_INTERFACE,
 		.type = QUIRK_COMPOSITE,
-		.data = (const struct snd_usb_audio_quirk[]){
+		.data = &(const struct snd_usb_audio_quirk[]){
 			{
 				.ifnum = 0,
-				.type = QUIRK_IGNORE_INTERFACE,
+				.type = QUIRK_AUDIO_STANDARD_MIXER,
 			},
 			{
 				.ifnum = 1,
@@ -2955,16 +2955,40 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
+				}
+			},
+			{
+				.ifnum = 1,
+				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data = &(const struct audioformat) {
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
 					}
 				}
 			},
@@ -2972,7 +2996,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = -1
 			}
 		}
-
 	}
 },
 
-- 
1.9.1
