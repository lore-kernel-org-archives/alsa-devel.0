From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PC Beep or PC Speaker or just Beep? and HDA Beep
 code...
Date: Mon, 16 Nov 2009 10:20:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911161002110.4806@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.0910221740280.5519@eeebox2.perex-int.cz>
	<s5h1vklythl.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031147520.5500@eeebox2.perex-int.cz>
	<s5hiqdrlu8n.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031235130.5500@eeebox2.perex-int.cz>
	<s5heioflt08.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911031510170.5500@eeebox2.perex-int.cz>
	<alpine.LNX.2.00.0911121056030.4806@eeebox2.perex-int.cz>
	<s5hmy2sc8l8.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911121203190.4806@eeebox2.perex-int.cz>
	<s5hiqdgc7pg.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911121219080.4806@eeebox2.perex-int.cz>
	<s5heio4c71x.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0911121236440.4806@eeebox2.perex-int.cz>
	<s5haaysc56b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5038410380A
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 10:20:09 +0100 (CET)
In-Reply-To: <s5haaysc56b.wl%tiwai@suse.de>
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

On Thu, 12 Nov 2009, Takashi Iwai wrote:

> At Thu, 12 Nov 2009 12:44:17 +0100 (CET),
> Jaroslav Kysela wrote:
>>
>> On Thu, 12 Nov 2009, Takashi Iwai wrote:
>>
>>> At Thu, 12 Nov 2009 12:24:27 +0100 (CET),
>>> Jaroslav Kysela wrote:
>>>>
>>>> On Thu, 12 Nov 2009, Takashi Iwai wrote:
>>>>
>>>>> At Thu, 12 Nov 2009 12:06:57 +0100 (CET),
>>>>> Jaroslav Kysela wrote:
>>>>>>
>>>>>> On Thu, 12 Nov 2009, Takashi Iwai wrote:
>>>>>>
>>>>>>> IOW, I'm fine with an additional implementation for the dynamic beep
>>>>>>> on/off.  But, the mixer interface doesn't look like the best interface
>>>>>>> to me.
>>>>>>
>>>>>> I would prefer something which is comfortable for user. The module
>>>>>> parameter or sysfs file is not a good way to explain users how they can
>>>>>> change the beep behaviour.
>>>>>
>>>>> A module parameter would be easy enough for most users who really care
>>>>> things like beep :)
>>>>
>>>> Nope. You expect that all users knows how to change module parameters. I'm
>>>> sorry, but I'm lazy to explain in bugzilla many times, how to change the
>>>> kernel module parameter (it's enough to explain model= for HDA). But 'turn
>>>> off "Beep" in alsamixer or any ALSA-aware mixer app' is quite shorther and
>>>> intuitive.
>>>
>>> But because of this "easy-to-use", the switch can be soo easily
>>> changed unintentionally.  So, we are speaking roughly the same thing
>>> of both good and bad sides.
>>>
>>> And here I'm more concerned about the bad side than the good side.
>>
>> Ok, take another look:
>>
>> If you have an USB input device (mouse for example), how you can force the
>> user to not plug in / plug out the device to USB port?
>
> This is a different issue.  It's the physical connection, and the system
> explicitly allows the hotplugging.
>
> Or, a different aspect: suppose you don't want to use USB mouse but
> only PS/2 mouse.  How would you suggest?  You blame kernel or X that
> it doesn't provide the one-click solution to suppress the USB mouse?
>
>> With my latest
>> change postponing the input device unregistration, the code is quite
>> robust and even keyboard repeat should not make much hassle, because the
>> input device will not be quickly unregistered in this case.
>
> I see it but still I'm not convinced by this dynamic registration.
> The input layer registration is escalated to sysfs, which is parsed by
> udev, whatever...  It's no more only the thing inside the kernel.

Almost all users won't touch the control switch after initial setup.

I added module parameter beep_mode to snd-hda-intel which allows to 
specify all three modes (always unregistered, always registered, dynamic).
Default is "always registered" as in previous implementation.

ALSA: hda - add beep_mode module parameter
http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=cffb566ba294a2593f932b7b7b12fb386ac161f4

It's a compromise to allow selection of accepted behaviour from user.

other HDA beep patches:

[ALSA] hda_intel: Digital PC Beep - change behaviour for input layer
[ALSA] hda_intel: Digital PC Beep - delay input device unregistration
[ALSA] hda: beep - add missing cancel_delayed_work

Please, add these four patches to your tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
