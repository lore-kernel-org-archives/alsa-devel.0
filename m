From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] ALSA: hda_intel: disable corb rirb when
 single_cmd active
Date: Fri, 06 Nov 2009 18:01:27 -0700
Message-ID: <4AF4C6E7.8010807@boundarydevices.com>
References: <1257276157-7164-1-git-send-email-troy.kisky@boundarydevices.com>	<s5hd43yzov7.wl%tiwai@suse.de>	<4AF1D9D0.9080007@boundarydevices.com>	<s5h7hu5cv01.wl%tiwai@suse.de>	<4AF32A8B.4050404@boundarydevices.com>	<s5h3a4s86j7.wl%tiwai@suse.de>
	<s5hiqdo80xq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BDB82459E
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 02:01:42 +0100 (CET)
In-Reply-To: <s5hiqdo80xq.wl%tiwai@suse.de>
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
Cc: pshou@realtek.com.tw, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 06 Nov 2009 08:19:08 +0100,
> I wrote:
>> At Thu, 05 Nov 2009 12:42:03 -0700,
>> Troy Kisky wrote:
>>> Takashi Iwai wrote:
>>>> At Wed, 04 Nov 2009 12:45:20 -0700,
>>>> Troy Kisky wrote:
>>>>> Takashi Iwai wrote:
>>>>>> At Tue,  3 Nov 2009 12:22:37 -0700,
>>>>>> Troy Kisky wrote:
>>>>>>> Poulsbo(US15W) cannot have any corb registers initialized
>>>>>>> when using single_cmd mode.
>>>>>>> When send_cmd timeout occur, note error.
>>>>>> Could you be more specific?  What errors do you get?
>>>>>>
>>>>>> And, how it goes to single_cmd mode?  The single_cmd mode is very last
>>>>>> resort, and reaching there means already a serious problem.
>>>>>>
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> Takashi
>>>>>>
>>>>> No error messages, but the response read is always 0.
>>>> This is odd.  Something is already wrong, then.
>>>>
>>>>> For testing, I passed single_cmd=1 as a modules option.
>>>>>
>>>>> HDAudio_03.pdf says, "If implemented, these registers must not be used
>>>>> at the same time as the CORB and RIRB command/response mechanisms, as the operations
>>>>> will conflict."
>>>> I know this, but actually this never be a problem in the real
>>>> hardware.  So, it's left there.
>>> My hardware is real.
>> Yeah, the first hit it seems.
>>
>>>>> Plus, if the RIRB irq is enabled, the interrupt routine will print out a
>>>>> spurious interrupt message.
>>> I meant "spurious response"
>> So your patch alone isn't enough?
>>
>>>>> That said, my hardware is switching to single_cmd eventually, even if not
>>>>> passed as a module option. But at least now, when that happens my audio
>>>>> isn't dead.
>>>> It's not dead but living-dead :)
>>>> The single_cmd mode is really only for debugging.  It's never for any
>>>> running system.
>>>>
>>>>
>>>> thanks,
>>>>
>>>> Takashi
>>>
>>>
>>> I'm all in favor of totally yanking out all the single_cmd related code,
>>> but if you're leaving it in, you should apply this patch.
>> Well, it's no right fix in a strict manner.
>> The right fix would be to remove the reinitialization or the first
>> call of azx_init_cmd_io() (and disable the unsolicited events, too).
> 
> ... like the patch below (untested!)
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 55c7da3..cce837a 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -722,9 +722,10 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
>  		   chip->last_cmd[addr]);
>  	chip->single_cmd = 1;
>  	bus->response_reset = 0;
> -	/* re-initialize CORB/RIRB */
> +	/* release CORB/RIRB */
>  	azx_free_cmd_io(chip);
> -	azx_init_cmd_io(chip);
> +	/* disable unsolicited responses */
> +	azx_writel(chip, GCTL, azx_readl(chip, GCTL) & ~ICH6_GCTL_UNSOL);
>  	return -1;
>  }
>  
> @@ -865,7 +866,9 @@ static int azx_reset(struct azx *chip)
>  	}
>  
>  	/* Accept unsolicited responses */
> -	azx_writel(chip, GCTL, azx_readl(chip, GCTL) | ICH6_GCTL_UNSOL);
> +	if (!chip->single_cmd)
> +		azx_writel(chip, GCTL, azx_readl(chip, GCTL) |
> +			   ICH6_GCTL_UNSOL);
>  
>  	/* detect codecs */
>  	if (!chip->codec_mask) {
> @@ -980,7 +983,8 @@ static void azx_init_chip(struct azx *chip)
>  	azx_int_enable(chip);
>  
>  	/* initialize the codec command I/O */
> -	azx_init_cmd_io(chip);
> +	if (!chip->single_cmd)
> +		azx_init_cmd_io(chip);
>  
>  	/* program the position buffer */
>  	azx_writel(chip, DPLBASE, (u32)chip->posbuf.addr);
> _______________________________________________


This patch works fine for me when passing single_cmd=1.

Thanks for spending your time on something you'd rather not.

Troy
