From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Master Plan on rewinding
Date: Mon, 08 Sep 2014 14:46:54 +0600
Message-ID: <540D6CFE.808@gmail.com>
References: <540C76E0.9050808@gmail.com> <540D61C4.90206@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9671626007E
 for <alsa-devel@alsa-project.org>; Mon,  8 Sep 2014 10:45:29 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id q1so8304675lam.40
 for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2014 01:45:29 -0700 (PDT)
In-Reply-To: <540D61C4.90206@canonical.com>
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

08.09.2014 13:59, David Henningsson wrote:

(First of all, a big thanks for being the first to talk constructively 
about the important problem of rewindability classes!)

> On 2014-09-07 17:16, Alexander E. Patrakov wrote:
>> Hello.
>>
>> (TL;DR: nothing really new except the strawman proposal about threads
>> and the note about interaction of variable sample rate with
>> rewindability)
>
> So, having looked this through another time, it looks like we have three
> categories of ALSA devices, from rewindability point of view:
>
>   1) Not rewindable at all.
>
>   2) Rewindable down to the period size.
>
>   3) Rewindable even further than the nearest period, down to DMA
> transfer sizes or something else. This also requires the .pointer to
> have better granularity than the period size.
>
> So I think any is_seekable() call or flag should indicate whether the
> device is case 1), 2) or 3). And for case 3) perhaps also some indicator
> of the actual rewind granularity and/or safeguard. This should be enough
> for PA to be able to pick a suitable default latency.

So far, I agree. The big question now is: do we have enough correct data 
from the kernel to decide between cases 2 and 3? I am definitely not 
qualified enough to answer this or to add such interface, though.

> Case 1) is simple. Just let snd_pcm_rewindable return 0 and
> snd_pcm_rewind fail. If it doesn't, just fix it. (The extplug problem
> could be solved by PA having ifdefs depending on alsa-lib version,
> rather than making snd_pcm_rewind and snd_pcm_rewindable behave
> inconsistent.)

OK. But I don't think that the ifdef proposal is sufficient. If I 
understand correctly, it only covers the "new PA on old alsa-lib" 
problem, because we can't add these ifdefs to old PA. That's still 
progress! But the "keep the old implementation of rewind" was for the 
opposite problem - old PA on new alsa-lib which rightfully refuses to 
rewind.

> For case 2) you seem to suggest to emulate case 3) by using either a
> low-latency thread, or by increasing the number of interrupts from the
> hardware. Either method will inevitably increase power consumption, and
> the former might also increase the risk of glitches. Therefore I think
> this is replacing something bad with something worse, because I would
> value low power consumption higher than better rewinding.

There is a slight misunderstanding above. I indeed proposed (and 
retracted the proposal when I knew that it happens on mobile devices) to 
emulate case 3 in case 2 by increasing the number of interrupts from the 
hardware. The proposal of a low-latency background thread was about 
emulating case 3 on case 1, and, so far, I have not retracted it, but I 
may do so in the future.

As for power consumption increase, the argument is essentially a 
duplicate of the phrase "the downside is that all programs (not only 
those intending to do rewinds) now pay the cost of the background 
low-latency thread" from my original mail. In other words, I partially 
agree. This, if enabled unconditionally, indeed would lead to 
unnecessary power consumption increase for those applications that don't 
use rewinds. But for applications that want low latency or dynamic 
latency, there is no other way to get it, so it is wrong to talk about 
power consumption increase for such applications.

> Could we enable this functionality by explicit request by the
> application? Probably. E g, if the application sets a low period size
> but also sets the "disable period interrupts" flag, that could be an
> indicator that it wants lots of interrupts just to update the pointer,
> but nothing else. Maybe that's even the behaviour today (haven't checked).

A very good idea.

>
> The low-latency thread approach could be implemented by a separate
> ioplug layer, so that people who want it could open
> "flexiblerewind:plug:hw:0" instead of "plug:hw:0".

Also a good idea.

> However, with my PA hat on, I would still say no to having PA use either
> of those by default, for power consumption reasons.

I would also say no, but for a different reason (because, as I wrote 
above, the power-consumption reason is valid only for software that 
never wants to rewind and does not need low/dynamic latency, and PA does 
not fall into this category). My argument is that, in the case of 
PulseAudio, these emulations would just create an unnecessary layer of 
complexity. PulseAudio actively wants to know the device type (via the 
is_seekable() call), so it is reasonable for it to also deal with 
consequences, without the need for additional processing in the driver 
or for an extra thread.

> With that in mind I suggest, just as you, that we add
> .rewind/.rewindable callbacks to the ioplug layer. Any ioplug using
> .transfer needs to implement that if it wants to support rewinding,
> otherwise that ioplug would fall into category 1).
>
> Does that make sense? It was a long email, so I might have missed
> something. :-)

In fact, _I_ missed something when writing the original e-mail. I forgot 
to address your phrase from 
http://permalink.gmane.org/gmane.linux.alsa.devel/122191:

> I understand that you have a mathematically perfect approach to this, as
> well as other algorithms. This would indeed be the best goal, but given
> an imperfect world, where we're forced to choose between
>   1) no rewinding at all
>   2) imperfect rewinding in the sense that it sometimes can produce
> hearable artifacts
>
> ...I'm not sure 1) is always the right choice...

Should we have a snd_pcm_open (or whatever else) flag for accepting 
imperfect rewind results? [anyway, I would say "no" to using it in 
PulseAudio]

-- 
Alexander E. Patrakov
