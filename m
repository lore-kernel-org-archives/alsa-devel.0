From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-audio: Correct way to do a mixer quirk?
Date: Mon, 20 Feb 2012 09:07:59 +0100
Message-ID: <4F41FF5F.8040409@ladisch.de>
References: <alpine.LNX.2.01.1202192059040.7408@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 6077D103CB5
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 09:05:13 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id F2D312111D
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2012 03:05:12 -0500 (EST)
In-Reply-To: <alpine.LNX.2.01.1202192059040.7408@stax.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@pogo.org.uk>
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Hills wrote:
> The Electrix Ebox-44 is a new USB interface, but the MIXER_UNIT descriptor
> is broken and refers to a non-existing unit_id.
>
> I worked around it with the patch below to remove the additional entry,
> and the device seems to work as expected.
>
> But inserting code here is probably not desirable -- I imagine I need to
> turn this into a quirk of some sort. Am I correct?
>
> And what is the best way to do this?
>
> * It doesn't appear I can use quirks-table.h to adjust the content
>   of a mixer unit (the bNrInPins attribute)
>
> * It seems that to use mixer_quirks.c would require a function to
>   create the whole mixer
>
> It's possible I'm incorrect on the above, though. Can anyone advise on how
> to make this fix in the correct way?

I'd suggest to change the code to not abort if a unit doesn't exist.


Regards,
Clemens


> ---
>  AudioControl Interface Descriptor:
>     bLength                15
>     bDescriptorType        36
>     bDescriptorSubtype      4 (MIXER_UNIT)
>     bUnitID                 6
>     bNrInPins               3         <-- should be 2
>     baSourceID( 0)          5
>     baSourceID( 1)          4
>     baSourceID( 2)          2         <-- bogus entry
>
> ---
>  sound/usb/mixer.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 8147ffc..ab3ccca 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -1387,6 +1387,9 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid, void *r
>  		return 0;
>  	}
>
> +	if (state->chip->usb_id == USB_ID(0x200c, 0x1018) && unitid == 6)
> +		input_pins = 2;
> +
>  	num_ins = 0;
>  	ich = 0;
>  	for (pin = 0; pin < input_pins; pin++) {
