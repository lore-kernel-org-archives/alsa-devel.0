From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ALSA: usb-audio: Add support for
	Akai	MPC Element USB MIDI controller
Date: Thu, 08 Jan 2015 22:56:15 +0100
Message-ID: <54AEFCFF.3060406@ladisch.de>
References: <54AE16D8.6080302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5CB18260568
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 22:57:02 +0100 (CET)
In-Reply-To: <54AE16D8.6080302@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Bonser <misterpib@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Paul Bonser wrote:
> The Akai MPC Element incorrectly reports its bInterfaceClass as 255, but
> otherwise implements the USB MIDI spec correctly.
>
> This adds a quirks-table.h entry which allows the device to be
> recognized as a standard USB MIDI device.
>
> Signed-off-by: Paul Bonser <misterpib@gmail.com>
> ---
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index 8590a32..e869b6c 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -2516,6 +2516,28 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>  	}
>  },
>
> +{
> +	/* Akai MPC Element */
> +	USB_DEVICE(0x09e8, 0x0021),
> +	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> +		.ifnum = QUIRK_ANY_INTERFACE,
> +		.type = QUIRK_COMPOSITE,
> +		.data = & (const struct snd_usb_audio_quirk[]) {
> +			{
> +				.ifnum = 0,
> +				.type = QUIRK_IGNORE_INTERFACE
> +			},
> +			{
> +				.ifnum = 1,
> +				.type = QUIRK_MIDI_STANDARD_INTERFACE
> +			},
> +			{
> +				.ifnum = -1
> +			}
> +		}
> +	}
> +},

Why a composite quirk?  Does a single quirk entry not work?


Regards,
Clemens
