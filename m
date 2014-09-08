From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 08 Sep 2014 11:26:31 +0200
Message-ID: <540D7647.6040704@canonical.com>
References: <540C76E0.9050808@gmail.com> <540D61C4.90206@canonical.com>
 <540D6CFE.808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B8BF126007E
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 11:26:22 +0200 (CEST)
In-Reply-To: <540D6CFE.808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org



On 2014-09-08 10:46, Alexander E. Patrakov wrote:
> 08.09.2014 13:59, David Henningsson wrote:
>
> (First of all, a big thanks for being the first to talk constructively
> about the important problem of rewindability classes!)
>
>> On 2014-09-07 17:16, Alexander E. Patrakov wrote:
>>> Hello.
>>>
>>> (TL;DR: nothing really new except the strawman proposal about threads
>>> and the note about interaction of variable sample rate with
>>> rewindability)
>>
>> So, having looked this through another time, it looks like we have three
>> categories of ALSA devices, from rewindability point of view:
>>
>>   1) Not rewindable at all.
>>
>>   2) Rewindable down to the period size.
>>
>>   3) Rewindable even further than the nearest period, down to DMA
>> transfer sizes or something else. This also requires the .pointer to
>> have better granularity than the period size.
>>
>> So I think any is_seekable() call or flag should indicate whether the
>> device is case 1), 2) or 3). And for case 3) perhaps also some indicator
>> of the actual rewind granularity and/or safeguard. This should be enough
>> for PA to be able to pick a suitable default latency.
>
> So far, I agree. The big question now is: do we have enough correct data
> from the kernel to decide between cases 2 and 3? I am definitely not
> qualified enough to answer this or to add such interface, though.

I'm quite certain that we don't have enough information coming through 
from the kernel. It's something we need to add if we end up deciding to 
implement hw_params_is_seekable.

>> Case 1) is simple. Just let snd_pcm_rewindable return 0 and
>> snd_pcm_rewind fail. If it doesn't, just fix it. (The extplug problem
>> could be solved by PA having ifdefs depending on alsa-lib version,
>> rather than making snd_pcm_rewind and snd_pcm_rewindable behave
>> inconsistent.)
>
> OK. But I don't think that the ifdef proposal is sufficient. If I
> understand correctly, it only covers the "new PA on old alsa-lib"
> problem, because we can't add these ifdefs to old PA. That's still
> progress! But the "keep the old implementation of rewind" was for the
> opposite problem - old PA on new alsa-lib which rightfully refuses to
> rewind.
>
>> For case 2) you seem to suggest to emulate case 3) by using either a
>> low-latency thread, or by increasing the number of interrupts from the
>> hardware. Either method will inevitably increase power consumption, and
>> the former might also increase the risk of glitches. Therefore I think
>> this is replacing something bad with something worse, because I would
>> value low power consumption higher than better rewinding.
>
> There is a slight misunderstanding above. I indeed proposed (and
> retracted the proposal when I knew that it happens on mobile devices) to
> emulate case 3 in case 2 by increasing the number of interrupts from the
> hardware. The proposal of a low-latency background thread was about
> emulating case 3 on case 1, and, so far, I have not retracted it, but I
> may do so in the future.

Right. I guess the low-latency background thread can be used to emulate 
3) on top of both 1) and 2).

> This, if enabled unconditionally, indeed would lead to
> unnecessary power consumption increase for those applications that don't
> use rewinds. But for applications that want low latency or dynamic
> latency, there is no other way to get it, so it is wrong to talk about
> power consumption increase for such applications.

Uhm, is the set of applications that want "low or dynamic latency" 
necessarily the same as the set that want rewinds?

But that might be more of an academic question, I guess PA is the only 
one that does rewinds currently. Or are there more apps out there that 
do rewinds?

I'm not sure I buy this point completely, but I can't come up with a 
good counterexample either, so maybe you're right.

> My argument is that, in the case of
> PulseAudio, these emulations would just create an unnecessary layer of
> complexity.  PulseAudio actively wants to know the device type (via the
> is_seekable() call), so it is reasonable for it to also deal with
> consequences, without the need for additional processing in the driver
> or for an extra thread.

Agreed.

>> I understand that you have a mathematically perfect approach to this, as
>> well as other algorithms. This would indeed be the best goal, but given
>> an imperfect world, where we're forced to choose between
>>   1) no rewinding at all
>>   2) imperfect rewinding in the sense that it sometimes can produce
>> hearable artifacts
>>
>> ...I'm not sure 1) is always the right choice...
>
> Should we have a snd_pcm_open (or whatever else) flag for accepting
> imperfect rewind results? [anyway, I would say "no" to using it in
> PulseAudio]

Well, if we had one, and it defaulted to the old behaviour, I suppose 
that would solve the new alsa-lib on old PA problem? But I'm not sure 
it's worth the added complexity.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
