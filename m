From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] ALSA: hda_intel: disable corb rirb when
 single_cmd active
Date: Thu, 05 Nov 2009 12:42:03 -0700
Message-ID: <4AF32A8B.4050404@boundarydevices.com>
References: <1257276157-7164-1-git-send-email-troy.kisky@boundarydevices.com>	<s5hd43yzov7.wl%tiwai@suse.de>	<4AF1D9D0.9080007@boundarydevices.com>
	<s5h7hu5cv01.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 9124010396C
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:42:18 +0100 (CET)
In-Reply-To: <s5h7hu5cv01.wl%tiwai@suse.de>
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
Cc: pshou@realtek.com.tw, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 04 Nov 2009 12:45:20 -0700,
> Troy Kisky wrote:
>> Takashi Iwai wrote:
>>> At Tue,  3 Nov 2009 12:22:37 -0700,
>>> Troy Kisky wrote:
>>>> Poulsbo(US15W) cannot have any corb registers initialized
>>>> when using single_cmd mode.
>>>> When send_cmd timeout occur, note error.
>>> Could you be more specific?  What errors do you get?
>>>
>>> And, how it goes to single_cmd mode?  The single_cmd mode is very last
>>> resort, and reaching there means already a serious problem.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>> No error messages, but the response read is always 0.
> 
> This is odd.  Something is already wrong, then.
> 
>> For testing, I passed single_cmd=1 as a modules option.
>>
>> HDAudio_03.pdf says, "If implemented, these registers must not be used
>> at the same time as the CORB and RIRB command/response mechanisms, as the operations
>> will conflict."
> 
> I know this, but actually this never be a problem in the real
> hardware.  So, it's left there.

My hardware is real.

> 
>> Plus, if the RIRB irq is enabled, the interrupt routine will print out a
>> spurious interrupt message.

I meant "spurious response"

>>
>> That said, my hardware is switching to single_cmd eventually, even if not
>> passed as a module option. But at least now, when that happens my audio
>> isn't dead.
> 
> It's not dead but living-dead :)
> The single_cmd mode is really only for debugging.  It's never for any
> running system.
> 
> 
> thanks,
> 
> Takashi



I'm all in favor of totally yanking out all the single_cmd related code,
but if you're leaving it in, you should apply this patch.

If you want someone else to verify the bug, can you ask someone with a
US15W to add the module parameter single_cmd=1 ???


I really do not understand your reluctance to change code that is "really only for
debugging." That should make changes less dangerous, not more. Especially
as the change seems like an obvious fix to a minor oversight.

My only hesitation would be that unsolicited responses are not handled when
in single_cmd mode. Should they be disabled as well?

Troy
