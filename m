From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PC Beep or PC Speaker or just Beep? and HDA Beep
 code...
Date: Tue, 3 Nov 2009 15:16:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911031510170.5500@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0910221740280.5519@eeebox2.perex-int.cz>
	<s5h1vklythl.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031147520.5500@eeebox2.perex-int.cz>
	<s5hiqdrlu8n.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031235130.5500@eeebox2.perex-int.cz>
	<s5heioflt08.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 41F30103810
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 15:16:09 +0100 (CET)
In-Reply-To: <s5heioflt08.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Nov 2009, Takashi Iwai wrote:

> At Tue, 3 Nov 2009 12:43:17 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> On Tue, 3 Nov 2009, Takashi Iwai wrote:
>>
>>> At Tue, 3 Nov 2009 12:01:57 +0100 (CET),
>>> Jaroslav Kysela wrote:
>>>>
>>>> On Fri, 30 Oct 2009, Takashi Iwai wrote:
>>>>
>>>>> At Thu, 22 Oct 2009 17:50:10 +0200 (CEST),
>>>>> Jaroslav Kysela wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>>  	I'm changing the behaviour of Beep / PC Beep controls for HDA
>>>>>> drivers (comments?):
>>>>>>
>>>>>> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=d605dbeed1b102136513e09e95217e8dc19c800d
>>>>>
>>>>> Well, IMHO, the fundamental problem is that there is no logic to
>>>>> select the beep device in the input layer.  A few line of code to
>>>>> drivers/char/keyboard.c would do that.
>>>>
>>>> Yes, it would be good to have possibility to configure which input device
>>>> will receive beep events.
>>>
>>> I had even a patch somewhere... I need to dig down my archive.
>>>
>>>>> Regarding your change: I'm afraid that too frequent attach/detach
>>>>> calls aren't good.
>>>>
>>>> What's too frequent? The attach/detach is called only when Beep mute
>>>> control is toggled. I don't think that user will toggle this control as
>>>> more as once in a normal system setup. The default value is "muted"
>>>> (no registration) anyway.
>>>
>>> Heh, you can't expect how odd things users would do.
>>> I can foresee this too frequent toggling can happen simply, e.g. key
>>> auto-repeating on a mute button.
>>>
>>>> I would really like to have the HDA Beep registration to input layer
>>>> configurable at runtime. The control layer seems good for this job.
>>>> I can eventually add one more control with name like "Beep Register
>>>> Switch", but the "Beep Playback Switch" does this job well.
>>>
>>> Well, the biggest problem in your patch is that its re-register the
>>> input device.  When you watch the kernel message, you'll find that the
>>> new input device is added at each time you toggle the beep switch,
>>>  input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input6
>>>  input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input7
>>>  ...
>>> With frequent toggles, you can reach to a very high number very
>>> easily.
>>
>> I don't see a problem. If you find the behaviour too risky, we can limit
>> the register/unregister calls in time. Like one register call in one
>> second.
>
> Oh no, that'd be very strange behavior as an mixer element.

I recoded patch to delay the detach only to get consistent and abuse 
prone behaviour:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=ba9c08c61338f298df34445715287beeca94b024
http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=0633c8e977b7708ea122392d87cc15ca448fc5d5

The HDA beep output is muted immediately, of course.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
