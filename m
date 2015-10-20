From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Headphone Mic and PA
Date: Tue, 20 Oct 2015 13:43:56 +0200
Message-ID: <562628FC.4020802@canonical.com>
References: <s5hsi57i3qm.wl-tiwai@suse.de> <5624D1F5.3090005@canonical.com>
 <s5h61233uiv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C161265317
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 13:43:56 +0200 (CEST)
In-Reply-To: <s5h61233uiv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-10-19 14:36, Takashi Iwai wrote:
> On Mon, 19 Oct 2015 13:20:21 +0200,
> David Henningsson wrote:
>>
>>
>>
>> On 2015-10-19 11:53, Takashi Iwai wrote:
>>> Hi David,
>>>
>>> I'm currently checking the bug report regarding PA, and this looks
>>> like an issue with "Headphone Mic" jack control.
>>>
>>> The reported problem is that PA doesn't react properly when both HP
>>> and dock line-out jacks are plugged and line-out is unplugged.  The
>>> machine in question is Dell E7250, and I see that it has only
>>> "Headphone Mic Jack" kctl without "Headphone Jack" kctl.  Is this the
>>> intentional behavior?
>>
>> Yes. The "Headphone Mic Jack" indicates that the jack can be used to
>> indicate either "Headphone" or "Mic".
>
> Hm, OK, that was the trick.  But now I wonder whether this was a right
> choice.  Maybe a more straightforward way (from user-space POV) would
> have been to create two jack ctls (Headphone and Headphone Mic) and
> notify both of them.

Not so sure about that. Then you might get two events, and userspace 
needs to synchronise them, and then understand that it's about the same 
jack.

I think the current solution is better.

>> The additional "Headset Mic
>> Phantom Jack" indicates that headset is a third usage for the jack and
>> there is no hardware that can detect which one of them it is. So it
>> looks correct to me.
>>
>> Also the Dell E7250 is Ubuntu certified, but I don't think docking
>> stations are part of that certification suite (at least not for Dell E7250).
>>
>> I skimmed through the opensuse bug as well. Two notes:
>>
>>    1) Here's a guide of how to generate a PA log, avoiding the autospawn
>> problem: https://wiki.ubuntu.com/PulseAudio/Log
>
> Yeah, but I didn't want to let user touching the config, as people
> often forget to revert :)  But maybe it's better to mention it,
> judging from the people's reaction.
>
>>    2) There is a patch series in the pipeline [2] that Tanu has promised
>> to review, that makes module-switch-on-port-available more aggressive w
>> r t being able to reroute away from unavailable things. I suspect it
>> would help here, but I'm not completely sure.
>
> The last unplug event in the log shows
>
> D: [pulseaudio] module-alsa-card.c: Jack 'Dock Line Out Jack' is now unplugged
> D: [pulseaudio] device-port.c: Setting port analog-output-lineout to status no
> D: [pulseaudio] device-port.c: Setting port analog-output-speaker to status unknown
>
> and no activation happened to analog-output-speaker.  So, yes, your
> patchset might cure this.  But I wonder why this happens only with the
> dock line-out and not with normal headphones...

Could be just unlucky ordering perhaps? Does the just pushed patch help?

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/?id=91313e60a81e96ce976f24c522656c57b4ab94ca

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
