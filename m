From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] add Steinberg UR44 USB Audio Interface
 support to quirks-table
Date: Mon, 10 Mar 2014 13:07:48 +0100
Message-ID: <531DAB14.5080201@ladisch.de>
References: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id A9860265086
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:07:50 +0100 (CET)
In-Reply-To: <1394388767-23658-1-git-send-email-cyrus@bobobeach.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrus Harmon <cyrus@bobobeach.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Cyrus Harmon wrote:
> Signed-off-by: Cyrus Harmon <cyrus@bobobeach.com>
> ---
>  sound/usb/quirks-table.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

What kernel version did you test this patch with?


Regards,
Clemens

>
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index f652b10..987ca01 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -436,6 +436,36 @@ YAMAHA_DEVICE(0x105d, NULL),
>  		}
>  	}
>  },
> +{
> +	USB_DEVICE(0x0499, 0x150e),
> +	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> +		/* .vendor_name = "Yamaha", */
> +		/* .product_name = "Steinberg UR44", */
> +		.ifnum = QUIRK_ANY_INTERFACE,
> +		.type = QUIRK_COMPOSITE,
> +		.data = (const struct snd_usb_audio_quirk[]) {
> +			{
> +				.ifnum = 1,
> +				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> +			},
> +			{
> +				.ifnum = 2,
> +				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> +			},
> +			{
> +				.ifnum = 3,
> +				.type = QUIRK_MIDI_YAMAHA
> +			},
> +			{
> +				.ifnum = 4,
> +				.type = QUIRK_IGNORE_INTERFACE
> +			},
> +			{
> +				.ifnum = -1
> +			}
> +		}
> +	}
> +},
>  YAMAHA_DEVICE(0x2000, "DGP-7"),
>  YAMAHA_DEVICE(0x2001, "DGP-5"),
>  YAMAHA_DEVICE(0x2002, NULL),
>
