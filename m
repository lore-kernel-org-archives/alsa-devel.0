From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] Fw: Isochronous transfer error on USB3
Date: Thu, 09 Jan 2014 09:17:13 +0100
Message-ID: <52CE5B09.6070203@ladisch.de>
References: <20140108164800.70ea4169@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20140108164800.70ea4169@samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, LMML <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mauro Carvalho Chehab wrote:
> I'm getting an weird behavior with em28xx, especially when the device
> is connected into an audio port.
>
> 	http://git.linuxtv.org/mchehab/experimental.git/blob/refs/heads/em28xx-v4l2-v6:/drivers/media/usb/em28xx/em28xx-audio.c
>
> What happens is that, when I require xawtv3 to use any latency lower
> than 65 ms, the audio doesn't work, as it gets lots of underruns per
> second.

The driver uses five URBs with 64 frames each, so of course it
will not be able to properly handle periods smaller than that.

> FYI, em28xx works at a 48000 KHz sampling rate, and its PM capture Hw
> is described as:
>
> static struct snd_pcm_hardware snd_em28xx_hw_capture = {
> 	.info = SNDRV_PCM_INFO_BLOCK_TRANSFER |
> 		SNDRV_PCM_INFO_MMAP           |
> 		SNDRV_PCM_INFO_INTERLEAVED    |
> 		SNDRV_PCM_INFO_BATCH	      |
> 		SNDRV_PCM_INFO_MMAP_VALID,
>
> 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
>
> 	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_KNOT,

This should be just SNDRV_PCM_RATE_48000.

> 	.period_bytes_min = 64,		/* 12544/2, */

This is wrong (if the driver doesn't install other constraints on the
period length, like the USB audio class driver does).


Regards,
Clemens
