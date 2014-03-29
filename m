From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Sat, 29 Mar 2014 16:35:23 +1100
Message-ID: <53365B9B.2050402@gmail.com>
References: <52E5254A.8090308@gmail.com> <52E53D57.3010700@ladisch.de>
 <52E5CC2E.1010000@gmail.com> <5314EDA1.5040101@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040205020705000905020300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 82FC726164D
 for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2014 06:36:06 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id fb1so5894699pad.15
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 22:36:05 -0700 (PDT)
In-Reply-To: <5314EDA1.5040101@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040205020705000905020300
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/14 08:01, Daniel Mack wrote:
> Hi Damien,
> 
> Thanks for your patch! See my two comments below.
> 
> On 01/27/2014 04:02 AM, Damien Zammit wrote:
>> On 27/01/14 03:52, Clemens Ladisch wrote:
>>>>>> This patch creates a dual endpoint quirk.
>>>>>>>> The quirk interface needs a second audioformat struct for this to work
>>>>>>>> which I called ".data2".
>>>> Couldn't you just let .data point to an array of two structs?
>> Thanks Clemens, I have created a new patch using this suggestion.
> 
> [...]
> 
>> +	fp2 = kmemdup((const struct audioformat*)(quirk->data + sizeof(const struct audioformat)), sizeof(*fp2), GFP_KERNEL);
>> +	if (!fp2) {
>> +		snd_printk(KERN_ERR "cannot memdup 2\n");
>> +		return -ENOMEM;
>> +	}
>> +	if (fp1->nr_rates > MAX_NR_RATES) {
>> +		kfree(fp1);
>> +		kfree(fp2);
> 
> Please do proper error unwinding here with jump labels rather than
> open-coding the kfree() calls from multiple places.
> 
> Also, I wonder whether a more generic quirk type to set up a dynamic
> number of fixed interfaces wouldn't be nicer. IOW, add a field to struct
> snd_usb_audio_quirk to denote the number of array members in quirk->data
> and call the quirk type QUIRK_AUDIO_FIXED_MULTI_ENDPOINT or something.
> Then, rewrite the logic to iterate over the interfaces in a loop. That
> might also make the code more readable.

Hi Daniel, Clemens,
I have addressed the above issues, please find attached my new patch.
I did a proper git log message that describes my changes.  I am keen to
get this reviewed and hopefully accepted soon.
I did a clean clone of Takashi's 'sound' (for-next) and applied my
changes on top of that.

Damien


--------------040205020705000905020300
Content-Type: text/x-patch;
 name="0001-PATCH-ALSA-usb-audio-Capture-and-duplex-support-for-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-PATCH-ALSA-usb-audio-Capture-and-duplex-support-for-.pa";
 filename*1="tch"

>From c20460de3a3d5635451f030a966cb7666866a7a1 Mon Sep 17 00:00:00 2001
From: Damien Zammit <damien@zamaudio.com>
Date: Sat, 29 Mar 2014 16:01:47 +1100
Subject: [PATCH] [PATCH] ALSA: usb-audio - Capture and duplex support for
 Digidesign Mbox 1 sound card

A few revisions of this patch have been made.  This patch provides support for usb cards
which have their streams on multiple endpoints within the same interface.
In particular, it provides duplex mode support for Digidesign Mbox 1.

I followed ALSA dev team's suggestion of making it work for N endpoints
rather than hardcoding it to two, and improved error handling has been provided.
An extra parameter has been added as requested to the usbaudio quirk struct 'epmulti'
to give the number of endpoints within a multi interface.

Signed-off-by: Damien Zammit <damien@zamaudio.com>
---
 sound/usb/quirks-table.h |   58 +++++++++++++++++++++++-----------
 sound/usb/quirks.c       |   79 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/usbaudio.h     |    2 ++
 3 files changed, 121 insertions(+), 18 deletions(-)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index f652b10..e41b8a2 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2889,23 +2889,46 @@ YAMAHA_DEVICE(0x7010, "UB99"),
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
+				.type = QUIRK_AUDIO_FIXED_MULTI_ENDPOINT,
+				.epmulti = 2,
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
@@ -2913,7 +2936,6 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 				.ifnum = -1
 			}
 		}
-
 	}
 },
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7c57f22..affbced 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -180,6 +180,84 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	return 0;
 }
 
+/*
+ * create N streams for an interface without proper descriptors but with multiple endpoints
+ */
+static int create_fixed_multi_stream_quirk(struct snd_usb_audio *chip,
+				     struct usb_interface *iface,
+				     struct usb_driver *driver,
+				     const struct snd_usb_audio_quirk *quirk)
+{
+	struct audioformat **fp;
+	struct usb_host_interface *alts = NULL;
+	int *stream;
+	int err, i;
+	unsigned *rate_table = NULL;
+	int rates_found;
+	rates_found = 0;
+
+	stream = (int*) kmalloc(sizeof(int) * quirk->epmulti, GFP_KERNEL);
+	if (!stream)
+		goto err_mem;
+	fp = (struct audioformat**) kmalloc(sizeof((const struct audioformat*)quirk->data) * quirk->epmulti, GFP_KERNEL);
+	if (!(fp))
+		goto err_mem;
+
+	for (i = 0; i < quirk->epmulti; ++i) {
+		fp[i] = kmemdup((const struct audioformat*)(quirk->data + i*sizeof(const struct audioformat)), sizeof(*fp[i]), GFP_KERNEL);
+		if (!(fp[i])) {
+			usb_audio_err(chip, "cannot memdup %d\n", i);
+			goto err_mem;
+		}
+		if (fp[i]->nr_rates > MAX_NR_RATES) {
+			err = -EINVAL;
+			goto err_rates;
+		}
+		if (fp[i]->nr_rates > 0 && !rates_found) {
+			rate_table = kmemdup(fp[i]->rate_table,
+				     sizeof(int) * fp[i]->nr_rates, GFP_KERNEL);
+			rates_found = 1;
+		}
+		if (!rate_table) {
+			err = -ENOMEM;
+			goto err_rates;
+		}
+		fp[i]->rate_table = rate_table;
+
+		stream[i] = (fp[i]->endpoint & USB_DIR_IN)
+			? SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
+
+		err = snd_usb_add_audio_stream(chip, stream[i], fp[i]);
+		if (err < 0)
+			goto err_ratetable;
+
+		if (fp[i]->iface != get_iface_desc(&iface->altsetting[0])->bInterfaceNumber ||
+		    fp[i]->altset_idx >= iface->num_altsetting) {
+			err = -EINVAL;
+			goto err_ratetable;
+		}
+		alts = &iface->altsetting[fp[0]->altset_idx];
+		fp[i]->datainterval = snd_usb_parse_datainterval(chip, alts);
+		fp[i]->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	}
+	usb_set_interface(chip->dev, fp[0]->iface, 0);
+	snd_usb_init_pitch(chip, fp[0]->iface, alts, fp[0]);
+	snd_usb_init_sample_rate(chip, fp[0]->iface, alts, fp[0], fp[0]->rate_max);
+	return 0;
+
+err_mem:
+	return -ENOMEM;
+err_ratetable:
+	kfree(rate_table);
+err_rates:
+	for (i = 0; i < quirk->epmulti; ++i)
+		if(fp[i])
+			kfree(fp[i]);
+	kfree(fp);
+	kfree(stream);
+	return err;
+}
+
 static int create_auto_pcm_quirk(struct snd_usb_audio *chip,
 				 struct usb_interface *iface,
 				 struct usb_driver *driver)
@@ -528,6 +606,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 		[QUIRK_MIDI_FTDI] = create_any_midi_quirk,
 		[QUIRK_AUDIO_STANDARD_INTERFACE] = create_standard_audio_quirk,
 		[QUIRK_AUDIO_FIXED_ENDPOINT] = create_fixed_stream_quirk,
+		[QUIRK_AUDIO_FIXED_MULTI_ENDPOINT] = create_fixed_multi_stream_quirk,
 		[QUIRK_AUDIO_EDIROL_UAXX] = create_uaxx_quirk,
 		[QUIRK_AUDIO_ALIGN_TRANSFER] = create_align_transfer_quirk,
 		[QUIRK_AUDIO_STANDARD_MIXER] = create_standard_mixer_quirk,
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 25c4c7e..a516ca3 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -95,6 +95,7 @@ enum quirk_type {
 	QUIRK_MIDI_FTDI,
 	QUIRK_AUDIO_STANDARD_INTERFACE,
 	QUIRK_AUDIO_FIXED_ENDPOINT,
+	QUIRK_AUDIO_FIXED_MULTI_ENDPOINT,
 	QUIRK_AUDIO_EDIROL_UAXX,
 	QUIRK_AUDIO_ALIGN_TRANSFER,
 	QUIRK_AUDIO_STANDARD_MIXER,
@@ -108,6 +109,7 @@ struct snd_usb_audio_quirk {
 	int16_t ifnum;
 	uint16_t type;
 	const void *data;
+	uint16_t epmulti;
 };
 
 #define combine_word(s)    ((*(s)) | ((unsigned int)(s)[1] << 8))
-- 
1.7.9.5


--------------040205020705000905020300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040205020705000905020300--
