From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] [ALSA] usb-audio - Support for Roland GAIA
	SH-01 Synthesizer
Date: Sun, 27 Nov 2011 16:21:04 +0100
Message-ID: <4ED25560.40208@gmail.com>
References: <1322404484.6913.20.camel@darkside>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 582052440C
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 16:21:12 +0100 (CET)
Received: by bkat8 with SMTP id t8so6263281bka.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 07:21:10 -0800 (PST)
In-Reply-To: <1322404484.6913.20.camel@darkside>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John F Leach <jfleach@jfleach.com>
Cc: tiwai@suse.de, alsa-devel <alsa-devel@alsa-project.org>, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 11/27/2011 03:34 PM, John F Leach wrote:
> Added table quirks entry for Roland GAIA SH-01 Synthesizer based upon
> Roland SH-201 table entry as template.  USB MIDI and audio was tested
> with Muse and Audacity.
> 
> Signed-off-by: John F Leach <jfleach@jfleach.com>
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/quirks-table.h |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index b61945f..6380665 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -1400,6 +1400,37 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>  	}
>  },
>  {
> +	/* Roland GAIA SH-01 */
> +	USB_DEVICE(0x0582, 0x0111),

Entries in this list should be ordered by the USB vendor/product ID,
which is not the case judging from the next block:

>  	/* Roland SH-201 */
>  	USB_DEVICE(0x0582, 0x00ad),
>  	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {


Otherwise looks good.

Thanks for sending patches!


Daniel


> +	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> +		.vendor_name = "Roland",
> +		.product_name = "GAIA",
> +		.ifnum = QUIRK_ANY_INTERFACE,
> +		.type = QUIRK_COMPOSITE,
> +		.data = (const struct snd_usb_audio_quirk[]) {
> +			{
> +				.ifnum = 0,
> +				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> +			},
> +			{
> +				.ifnum = 1,
> +				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> +			},
> +			{
> +				.ifnum = 2,
> +                                .type = QUIRK_MIDI_FIXED_ENDPOINT,
> +                                .data = & (const struct
> snd_usb_midi_endpoint_info) {
> +                                       .out_cables = 0x0003,
> +                                       .in_cables  = 0x0003
> +				}
> +			},
> +			{
> +				.ifnum = -1
> +			}
> +		}
> +	}
> +},
> +{
>  	/* Roland SH-201 */
>  	USB_DEVICE(0x0582, 0x00ad),
>  	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
