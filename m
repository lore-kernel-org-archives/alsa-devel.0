From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] snd-maestro3: Make hardware volume
 buttons an input device
Date: Thu, 22 Apr 2010 17:47:41 +0200
Message-ID: <4BD06F9D.5020809@redhat.com>
References: <1271925425-26615-1-git-send-email-hdegoede@redhat.com>
	<s5h4oj3edjf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 85EFC24515
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 17:46:11 +0200 (CEST)
In-Reply-To: <s5h4oj3edjf.wl%tiwai@suse.de>
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

Hi,

On 04/22/2010 05:02 PM, Takashi Iwai wrote:
> At Thu, 22 Apr 2010 04:37:04 -0400,
> Hans de Goede wrote:
>>
>> While working on the sound suspend / resume problems with my laptop
>> I noticed that the hardware volume handling code in essence just detects
>> key presses, and then does some hardcoded modification of the master volume
>> based on which key is pressed.
>>
>> This made me think that clearly the right thing to do here is just report
>> these keypresses to userspace as keypresses using an input device and let
>> userspace decide what to with them.
>>
>> This patch does this, getting rid of the ugly direct ac97 writes from
>> the tasklet, the ac97lock and the need for using a tasklet in general.
>>
>> As an added bonus the keys now work identical to volume keys on a (usb)
>> keyboard with multimedia keys, providing visual feedback of the volume
>> level change, and a better range of the volume control (with a properly
>> configured desktop environment).
>
> I like the basic idea.  However, two points to be fixed:
>
>   - We need a kconfig to keep the old behavior.  We are not allowed to
>     give any regression in general.
>

Yes, I already thought about this, and sort of expected this comment, but
I opted to start with the straight forward patch.

>   - CONFIG_INPUT is tristate.  It can be a module, thus the dependency
>     is a bit messy.  Imagine you want to build snd-maestro3 into kernel
>     while CONFIG_INPUT=m is given.
>

Ugh, I would say just don't do that, but I understand that that is not an
acceptable answer, and I see you've already provided a solution, thanks.

> A hack to avoid to avoid the dependency is to create a bool Kconfig to
> specify whether input feature is added or not; this is anyway needed
> for the first reason above.  Suppose it CONFIG_SND_MAESTRO3_INPUT.
>
> Then it looks like:
>
> config SND_MAESTRO3_INPUT
> 	bool "enable input device for maestro3 volume switches"
> 	depends on SND_MAESTRO3
> 	depends on INPUT=y || INPUT=SND_MAESTRO3
> 	help
> 	  ....
>
> Then you can use "#ifdef CONFIG_SND_MAESTRO3_INPUT" to determine
> compile condition.  If this isn't defined, keep the old behavior,
> i.e. controlling ac97 registers directly.

Ok, I'll respin this patches taking the above comments into account,
I'll do this either tomorrow or sometime next week.

Regards,

Hans
