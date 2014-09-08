From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 08 Sep 2014 16:21:02 +0600
Message-ID: <540D830E.70802@gmail.com>
References: <540C76E0.9050808@gmail.com> <540D61C4.90206@canonical.com>
 <540D6CFE.808@gmail.com> <540D7647.6040704@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id AAF2426528B
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 12:19:42 +0200 (CEST)
Received: by mail-lb0-f170.google.com with SMTP id u10so98431lbd.29
 for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2014 03:19:41 -0700 (PDT)
In-Reply-To: <540D7647.6040704@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

08.09.2014 15:26, David Henningsson wrote:
> On 2014-09-08 10:46, Alexander E. Patrakov wrote:
>> 08.09.2014 13:59, David Henningsson wrote:
>>
>> (First of all, a big thanks for being the first to talk constructively
>> about the important problem of rewindability classes!)
>>
>>> On 2014-09-07 17:16, Alexander E. Patrakov wrote:
>>>> Hello.
>>>>
>>>> (TL;DR: nothing really new except the strawman proposal about threads
>>>> and the note about interaction of variable sample rate with
>>>> rewindability)
>>>
>>> So, having looked this through another time, it looks like we have three
>>> categories of ALSA devices, from rewindability point of view:
>>>
>>>   1) Not rewindable at all.
>>>
>>>   2) Rewindable down to the period size.
>>>
>>>   3) Rewindable even further than the nearest period, down to DMA
>>> transfer sizes or something else. This also requires the .pointer to
>>> have better granularity than the period size.
>>>
>>> So I think any is_seekable() call or flag should indicate whether the
>>> device is case 1), 2) or 3). And for case 3) perhaps also some indicator
>>> of the actual rewind granularity and/or safeguard. This should be enough
>>> for PA to be able to pick a suitable default latency.
>>
>> So far, I agree. The big question now is: do we have enough correct data
>> from the kernel to decide between cases 2 and 3? I am definitely not
>> qualified enough to answer this or to add such interface, though.
>
> I'm quite certain that we don't have enough information coming through
> from the kernel. It's something we need to add if we end up deciding to
> implement hw_params_is_seekable.

OK, but, given that we need this interface in order to avoid seeking on 
the DTS encoder (and to avoid creating a big buffer on it), I'd rather 
have this sooner than later. As a compromise, let's design the API with 
case 2 in mind, but only return cases 1 and 3 until we have enough 
information from the kernel to detect case 2 reliably. And, unless 
someone sends out a constructive proposal, let's defer the discussion of 
case 2 detection to the miniconference.

(And users do complain about rewinding on dcaenc, because this rewind 
creates one or two invalid DTS frames in the middle of every volume 
change, and some receivers are slow to resynchronize).

>> This, if enabled unconditionally, indeed would lead to
>> unnecessary power consumption increase for those applications that don't
>> use rewinds. But for applications that want low latency or dynamic
>> latency, there is no other way to get it, so it is wrong to talk about
>> power consumption increase for such applications.
>
> Uhm, is the set of applications that want "low or dynamic latency"
> necessarily the same as the set that want rewinds?

It is a superset. Applications that want low latency don't necessarily 
want rewinds, but they want high interrupt rate => high power 
consumption anyway. Applications that want dynamic latency will do 
rewinds, because this is the only way to get it, except always 
defaulting to sometimes-unnecessary low latency.

>
> But that might be more of an academic question, I guess PA is the only
> one that does rewinds currently. Or are there more apps out there that
> do rewinds?

Right now it is indeed an academic question. However, earlier in this 
year I was contacted by Andrew Eikum who was trying to use rewinds in 
Wine and insisted that it is an ALSA bug when I told him that they 
cannot work on the default device. I am not sure whether I convinced 
him, because I did not use the "unsend bluetooth packets" wording back 
then. I cannot quote him now, because this was via IM, so quoting would 
be impolite. And, the log is on the other PC anyway.

> I'm not sure I buy this point completely, but I can't come up with a
> good counterexample either, so maybe you're right.
>
>> My argument is that, in the case of
>> PulseAudio, these emulations would just create an unnecessary layer of
>> complexity.  PulseAudio actively wants to know the device type (via the
>> is_seekable() call), so it is reasonable for it to also deal with
>> consequences, without the need for additional processing in the driver
>> or for an extra thread.
>
> Agreed.
>
>>> I understand that you have a mathematically perfect approach to this, as
>>> well as other algorithms. This would indeed be the best goal, but given
>>> an imperfect world, where we're forced to choose between
>>>   1) no rewinding at all
>>>   2) imperfect rewinding in the sense that it sometimes can produce
>>> hearable artifacts
>>>
>>> ...I'm not sure 1) is always the right choice...
>>
>> Should we have a snd_pcm_open (or whatever else) flag for accepting
>> imperfect rewind results? [anyway, I would say "no" to using it in
>> PulseAudio]
>
> Well, if we had one, and it defaulted to the old behaviour, I suppose
> that would solve the new alsa-lib on old PA problem? But I'm not sure
> it's worth the added complexity.

Understood. Yes, it would solve the problem, and I have no opinion so 
far whether it is worth the cost of complexity and of the bad default.

This phrase from the documentation of snd_pcm_rewindable is also 
something to think about:

"""
Note: The snd_pcm_rewind() can accept bigger value than returned by this 
function. But it is not guaranteed that output stream will be consistent 
with bigger value.
"""

-- 
Alexander E. Patrakov
