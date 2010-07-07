From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Wed, 07 Jul 2010 16:23:02 +0200
Message-ID: <4C348DC6.7070602@ladisch.de>
References: <4C32E3B2.5080707@web.de> <4C344340.8060804@web.de>
	<4C3476BD.4090702@ladisch.de> <4C347EF7.2030401@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 887AA244CC
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 16:23:03 +0200 (CEST)
In-Reply-To: <4C347EF7.2030401@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <fexpop@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> Am 07.07.2010 14:44, schrieb Clemens Ladisch:
>> (I have the suspicion that we don't actually need a AUDIO_FIXED_ENDPOINT
>> quirk for these devices.)
> 
> Something must be in this AUDIO_FIXED_ENDPOINT quirk, since the device 
> now works properly and stable @44.1/88.2 kHz. I don't know the exact 
> reason, since I really don't understand all this stuff.

There must be some difference, and I'd really like to know what it is.
Please load the driver with the patch below, with and without the
AUDIO_FIXED_ENDPOINT patch, and show what it prints to the system log.


Regards,
Clemens

--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -196,6 +196,7 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 			hwc_debug("All rates were zero. Skipping format!\n");
 			return -1;
 		}
+		print_hex_dump_bytes("rates ", DUMP_PREFIX_OFFSET, fp->rates, sizeof(int) * nr_rates);
 	} else {
 		/* continuous rates */
 		fp->rates = SNDRV_PCM_RATE_CONTINUOUS;
@@ -480,6 +481,7 @@ int snd_usb_parse_audio_format(struct snd_usb_audio *chip, struct audioformat *f
 	fp->fmt_type = fmt->bFormatType;
 	if (err < 0)
 		return err;
+	print_hex_dump_bytes("format ", DUMP_PREFIX_OFFSET, fp, sizeof(*fp));
 #if 1
 	/* FIXME: temporary hack for extigy/audigy 2 nx/zs */
 	/* extigy apparently supports sample rates other than 48k
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 9a9da09..6be2bfc 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -142,6 +142,7 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 		}
 		memcpy(rate_table, fp->rate_table, sizeof(int) * fp->nr_rates);
 		fp->rate_table = rate_table;
+		print_hex_dump_bytes("rates ", DUMP_PREFIX_OFFSET, fp->rate_table, sizeof(int) * fp->nr_rates);
 	}
 
 	stream = (fp->endpoint & USB_DIR_IN)
@@ -161,6 +162,7 @@ static int create_fixed_stream_quirk(struct snd_usb_audio *chip,
 	alts = &iface->altsetting[fp->altset_idx];
 	fp->datainterval = snd_usb_parse_datainterval(chip, alts);
 	fp->maxpacksize = le16_to_cpu(get_endpoint(alts, 0)->wMaxPacketSize);
+	print_hex_dump_bytes("format ", DUMP_PREFIX_OFFSET, fp, sizeof(*fp));
 	usb_set_interface(chip->dev, fp->iface, 0);
 	snd_usb_init_pitch(chip, fp->iface, alts, fp);
 	snd_usb_init_sample_rate(chip, fp->iface, alts, fp, fp->rate_max);
