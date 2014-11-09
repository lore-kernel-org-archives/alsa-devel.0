From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] snd-usb-audio: Add duplex mode
	for	Digidesign Mbox 1 and enable mixer
Date: Sun, 09 Nov 2014 15:04:42 +0100
Message-ID: <545F747A.7090002@ladisch.de>
References: <1415059597-18344-1-git-send-email-damien@zamaudio.com>	<1415059597-18344-3-git-send-email-damien@zamaudio.com>	<s5ha9442z6d.wl-tiwai@suse.de>
 <545E1C21.3090803@gmail.com> <s5hk3343f6y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D4C7D26050B
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 15:04:55 +0100 (CET)
In-Reply-To: <s5hk3343f6y.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Damien Zammit wrote:
>> On 07/11/14 01:15, Takashi Iwai wrote:
>>> Hmm, can we achieve this without introducing the new audioformats
>>> thing, e.g. with COMPOSITE, instead?
>>
>> I don't think COMPOSITE will work because the same interface has
>> multiple endpoints.  My code provides a framework for other devices with
>> the same issue.  I was told previously that this was the problem with
>> getting my previous attempt into the kernel.  Or is this doable without
>> adding a struct?
>
> I think the only point is the check in create_composite_quirk(), where
> it marks the iface as claimed and skips the next entry that has been
> already claimed.  However, the current code looks inconsistent -- it
> allows multiple entries only if the iface matches with the current
> one.  Fixing it like below would make things working.
>
> It's a quick idea, so a bit more reviews would be needed, though.
> Clemens, what do you think?

Reviewed-by: Clemens Ladisch <clemens@ladisch.de>

> ---
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -58,9 +58,17 @@ static int create_composite_quirk(struct snd_usb_audio *chip,
>  		err = snd_usb_create_quirk(chip, iface, driver, quirk);
>  		if (err < 0)
>  			return err;
> -		if (quirk->ifnum != probed_ifnum)
> +	}
> +
> +	for (quirk = quirk->data; quirk->ifnum >= 0; ++quirk) {
> +		iface = usb_ifnum_to_if(chip->dev, quirk->ifnum);
> +		if (!iface)
> +			continue;
> +		if (quirk->ifnum != probed_ifnum &&
> +		    !usb_interface_claimed(iface))
>  			usb_driver_claim_interface(driver, iface, (void *)-1L);
>  	}
> +
>  	return 0;
>  }
>
