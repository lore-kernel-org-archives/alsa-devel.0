From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: Boss GT-001
Date: Thu, 08 Oct 2015 01:51:20 +0100
Message-ID: <4797815.2qQzYzeTe7@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop> <1837042.8ri5iYFGVx@kamdesktop>
 <4761108.z7lHdDqPTH@kamdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id DEDA7261531
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 02:51:22 +0200 (CEST)
Received: by wiclk2 with SMTP id lk2so6586200wic.0
 for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2015 17:51:22 -0700 (PDT)
Received: from kamdesktop.localnet ([2001:8b0:be0a:29af::201])
 by smtp.gmail.com with ESMTPSA id r9sm42509045wjz.35.2015.10.07.17.51.21
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 07 Oct 2015 17:51:21 -0700 (PDT)
In-Reply-To: <4761108.z7lHdDqPTH@kamdesktop>
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
List-Id: alsa-devel@alsa-project.org

On Tuesday 06 Oct 2015 20:58:01 Keith A. Milner wrote:
> OK, so it seems that this hardware is substantially the same as the GT-100
> which has previously (and recently) been raised as a problem on ALSA.

I'm getting somewhere...

With the following quirk I am getting audio playback with aplay. I have what 
seems like correct MIDI interfaces working (although not fully tested).

However, recording does not seem to work.

{
	/* Boss GT-001 Guitar Interface */
	USB_DEVICE(0x0582, 0x0187),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		.vendor_name = "Boss",
		.product_name = "GT-001",
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = (const struct snd_usb_audio_quirk[]) {
		  	{
				.ifnum = 0,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = 1,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat) {
					.formats = SNDRV_PCM_FMTBIT_S32_LE,
					.channels = 4,
					.iface = 1,
					.altsetting = 1,
					.altset_idx = 1,
					.endpoint = 0x0d,
					.ep_attr = 0x05,
					.rates = SNDRV_PCM_RATE_44100,
					.rate_min = 44100,
					.rate_max = 44100,
					.nr_rates = 1,
					.rate_table = (unsigned int[]) { 44100 }
				}
			},
			{
				.ifnum = 2,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat) {
					.formats = SNDRV_PCM_FMTBIT_S32_LE,
					.channels = 4,
					.iface = 2,
					.altsetting = 1,
					.altset_idx = 1,
					.endpoint = 0x8e,
					.ep_attr = 0x25,
					.rates = SNDRV_PCM_RATE_44100,
					.rate_min = 44100,
					.rate_max = 44100,
					.nr_rates = 1,
					.rate_table = (unsigned int[]) { 44100 }
				}
			},
			{
				.ifnum = 3,
				.type = QUIRK_MIDI_ROLAND
			},
			{
				.ifnum = 4,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = -1
			}
		}
	}
},

Cheers,

Keith
