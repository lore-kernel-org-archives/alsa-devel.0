From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb: added VOX ToneLab ST midi
 handling
Date: Mon, 12 Dec 2011 11:48:10 +0100
Message-ID: <4EE5DBEA.40706@gmail.com>
References: <1323113266-23322-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BBD13244AA
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 11:48:15 +0100 (CET)
Received: by eaaa11 with SMTP id a11so1773933eaa.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 02:48:13 -0800 (PST)
In-Reply-To: <1323113266-23322-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

may I ping you on this once more? :)

Thanks,
Daniel


On 12/05/2011 08:27 PM, Daniel Mack wrote:
> From: Sergiusz Urbaniak <sergiusz.urbaniak@gmail.com>
> 
> Signed-off-by: Sergiusz Urbaniak <sergiusz.urbaniak@googlemail.com>
> ---
> 
> Sergiusz writes:
> 
> Hi,
> 
> I posted the message below to the mailing list, but it still is in the
> approval queue since I'm not a mailing list member.
> 
> In case this gets forgotten or stuck in a spam queue could you please
> consider my patch for kernel inclusion? This works really great with
> my Tonelab ST! I can even imagine to write a lib/CLI/GTK based app to
> control the Tonelab now :-)
> 
> Thanks,
> Sergiusz Urbaniak
> 
>  sound/usb/quirks-table.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index b61945f..57c9b94 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -2305,6 +2305,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>  	}
>  },
>  
> +{
> +	USB_DEVICE_VENDOR_SPEC(0x0944, 0x0201),
> +	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> +		.vendor_name = "KORG, Inc.",
> +		/* .product_name = "ToneLab ST", */
> +		.ifnum = 3,
> +		.type = QUIRK_MIDI_STANDARD_INTERFACE,
> +	}
> +},
> +
>  /* AKAI devices */
>  {
>  	USB_DEVICE(0x09e8, 0x0062),
