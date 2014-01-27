From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Mon, 27 Jan 2014 14:02:06 +1100
Message-ID: <52E5CC2E.1010000@gmail.com>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080203010404040500010800"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 56521261AB4
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 04:02:35 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id v10so5174331pde.14
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2014 19:02:33 -0800 (PST)
In-Reply-To: <52E53D57.3010700@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080203010404040500010800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/01/14 03:52, Clemens Ladisch wrote:
>> This patch creates a dual endpoint quirk.
>> >The quirk interface needs a second audioformat struct for this to work
>> >which I called ".data2".
> Couldn't you just let .data point to an array of two structs?

Thanks Clemens, I have created a new patch using this suggestion.

Damien

--------------080203010404040500010800
Content-Type: text/x-patch;
 name="0001-Cleaned-up-Digidesign-Mbox-1-patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Cleaned-up-Digidesign-Mbox-1-patch.patch"

This patch creates a dual endpoint quirk.
The quirk uses .data as an array of two structs.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/quirks-table.h |   57 ++++++++++++++++++++++-----------
 sound/usb/quirks.c       |   78 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/usbaudio.h     |    1 +
 3 files changed, 118 insertions(+), 18 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f652b10..bdbc931 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2889,23 +2889,45 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			},
 			{
 				.ifnum = 1,
-				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
-				.data = &(const struct audioformat) {
-					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
-					.channels = 2,
-					.iface = 1,
-					.altsetting = 1,
-					.altset_idx = 1,
-					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
-					.endpoint = 0x02,
-					.ep_attr = 0x01,
-					.rates = SNDRV_PCM_RATE_44100 |
-						 SNDRV_PCM_RATE_48000,
-					.rate_min = 44100,
-					.rate_max = 48000,
-					.nr_rates = 2,
-					.rate_table = (unsigned int[]) {
-						44100, 48000
+				.type = QUIRK_AUDIO_FIXED_DUAL_ENDPOINT,
+				.data = (const struct audioformat[]) {
+					[0] = {
+						.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+						.channels = 2,
+						.iface = 1,
+						.altsetting = 1,
+						.altset_idx = 1,
+						.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
+						.endpoint = 0x02,
+						.ep_attr = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_SYNC,
+						.maxpacksize = 0x130,
+						.rates = SNDRV_PCM_RATE_44100 |
+							 SNDRV_PCM_RATE_48000,
+						.rate_min = 44100,
+						.rate_max = 48000,
+						.nr_rates = 2,
+						.rate_table = (unsigned int[]) {
+							44100, 48000
+						}
+					},
+					[1] = {
+						.formats = SNDRV_PCM_FMTBIT_S24_3BE,
+						.channels = 2,
+						.iface = 1,
+						.altsetting = 1,
+						.altset_idx = 1,
+						.attributes = 0x00,
+						.endpoint = 0x81,
+						.ep_attr = USB_ENDPOINT_XFER_ISOC | USB_ENDPOINT_SYNC_ASYNC,
+						.maxpacksize = 0x130,
+						.rates = SNDRV_PCM_RATE_44100 |
+							 SNDRV_PCM_RATE_48000,
+						.rate_min = 44100,
+						.rate_max = 48000,
+						.nr_rates = 2,
+						.rate_table = (unsigned int[]) {
+							44100, 48000
+						}
 					}
 				}
 			},
@@ -2913,7 +2935,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = -1
 			}
 		}
-
 	}
 },
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 8973070..df2de44 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -387,6 +387,83 @@ static int create_autodetect_quirks(struct snd_usb_audio *chip,
 }
 
 /*
+ * create 2 streams for an interface without proper descriptors but with dual endpoints
+ */
+static int create_fixed_dual_stream_quirk(struct snd_usb_audio *chip,
+				     struct usb_interface *iface,
+				     struct usb_driver *driver,
+				     const struct snd_usb_audio_quirk *quirk)
+{
+	struct audioformat *fp1, *fp2;
+	struct usb_host_interface *alts;
+	int stream1, stream2, err;
+	unsigned *rate_table = NULL;
+
+	fp1 = kmemdup((const struct audioformat*)quirk->data, sizeof(*fp1), GFP_KERNEL);
+	if (!fp1) {
+		snd_printk(KERN_ERR "cannot memdup 1\n");
+		return -ENOMEM;
+	}
+	fp2 = kmemdup((const struct audioformat*)(quirk->data + sizeof(const struct audioformat)), sizeof(*fp2), GFP_KERNEL);
+	if (!fp2) {
+		snd_printk(KERN_ERR "cannot memdup 2\n");
+		return -ENOMEM;
+	}
+	if (fp1->nr_rates > MAX_NR_RATES) {
+		kfree(fp1);
+		kfree(fp2);
+		return -EINVAL;
+	}
+	if (fp1->nr_rates > 0) {
+		rate_table = kmemdup(fp1->rate_table,
+				     sizeof(int) * fp1->nr_rates, GFP_KERNEL);
+		if (!rate_table) {
+			kfree(fp1);
+			kfree(fp2);
+			return -ENOMEM;
+		}
+		fp1->rate_table = rate_table;
+		fp2->rate_table = rate_table;
+	}
+
+	stream1 = (fp1->endpoint & USB_DIR_IN)
+		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	stream2 = (fp2->endpoint & USB_DIR_IN)
+		? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+	err = snd_usb_add_audio_stream(chip, stream1, fp1);
+	if (err < 0) {
+		kfree(fp1);
+		kfree(fp2);
+		kfree(rate_table);
+		return err;
+	}
+	err = snd_usb_add_audio_stream(chip, stream2, fp2);
+	if (err < 0) {
+		kfree(fp1);
+		kfree(fp2);
+		kfree(rate_table);
+		return err;
+	}
+	if (fp1->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
+	    fp1->altset_idx >= iface->num_altsetting ||
+	    fp2->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
+	    fp2->altset_idx >= iface->num_altsetting
+	    ) {
+		kfree(fp1);
+		kfree(fp2);
+		kfree(rate_table);
+		return -EINVAL;
+	}
+	alts = &iface->altsetting[fp1->altset_idx];
+	fp1->datainterval = fp2->datainterval = snd_usb_parse_datainterval(chip, alts);
+	fp1->maxpacksize = fp2->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	usb_set_interface(chip->dev, fp1->iface, 0);
+	snd_usb_init_pitch(chip, fp1->iface, alts, fp1);
+	snd_usb_init_sample_rate(chip, fp1->iface, alts, fp1, fp1->rate_max);
+	return 0;
+}
+
+/*
  * Create a stream for an Edirol UA-700/UA-25/UA-4FX interface.  
  * The only way to detect the sample rate is by looking at wMaxPacketSize.
  */
@@ -528,6 +605,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_FTDI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
+		[QUIRK_AUDIO_FIXED_DUAL_ENDPOINT] = create_fixed_dual_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
 		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
 		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 5d2fe05..4025670 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -86,6 +86,7 @@ enum quirk_type {
 	QUIRK_MIDI_FTDI,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
+	QUIRK_AUDIO_FIXED_DUAL_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UAXX,
 	QUIRK_AUDIO_ALIGN_TRANSFER,
 	QUIRK_AUDIO_STANDARD_MIXER,
-- 
1.7.9.5


--------------080203010404040500010800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080203010404040500010800--
