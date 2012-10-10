From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] ALSA: hda - Implement a poll loop for
 jacks as a module parameter
Date: Wed, 10 Oct 2012 17:36:58 +0200
Message-ID: <5075961A.7010909@canonical.com>
References: <1349788784-11700-1-git-send-email-david.henningsson@canonical.com>
 <s5hbogbg497.wl%tiwai@suse.de> <50743477.9050401@canonical.com>
 <s5h1uh7g0b8.wl%tiwai@suse.de> <50757C73.3050602@canonical.com>
 <s5hvceicte2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A5B212625F2
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 17:36:57 +0200 (CEST)
In-Reply-To: <s5hvceicte2.wl%tiwai@suse.de>
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

On 10/10/2012 04:07 PM, Takashi Iwai wrote:
> At Wed, 10 Oct 2012 15:47:31 +0200,
> David Henningsson wrote:
>>
>> On 10/09/2012 04:57 PM, Takashi Iwai wrote:
>>> At Tue, 09 Oct 2012 16:28:07 +0200,
>>> David Henningsson wrote:
>>>> Or, to make it a bit more pragmatic, what other things are broken with
>>>> single_cmd? Could you give an example where this change would be harmful?
>>>
>>> The single cmd mode itself was introduced as a sort of rescue command
>>> without CORB/RIRB.  We shouldn't use it in normal situations.  It's
>>> simply no considered use case.
>>>
>>> With a lack of unsol event, you can't handle the volume knob, or any
>>> GPIO events, too.
>>
>> Those two are quite uncommon, and can be polled too if necessary.
>
> I wonder from where your love to polling comes...

It's not a love for polling. It's a pragmatic view of having people's 
machines working at best effort. If we, due to lack of time, hardware, 
specifications, whatever, can't have the best option available to our 
users, I prefer to have it working but "secretly performing worse", to 
not having it working at all.

I'm genuinely trying to understand what's so wrong with single cmd mode 
*in practice*, but when what I get in return from you is stuff about 
saving the world and peaceful living, I don't know how to interpret that 
"information".

>>> Well, do you want to allow 1ms polling?
>>
>> I can't see why not, if people want to burn CPU cycles, why not let
>> them.
>
> You seem to trust users too much :)

Well, there's already a single_cmd module parameter, which if enabled 
causes "no peaceful living at all", can't be worse than that, can it? ;-)

>> However, the real limit should probably be one jiffy, so attaching
>> modified patch.
>> If you think there should be another lower limit, feel free to adjust
>> the patch before applying. It's no big deal.
>
> Well, do you really think 1 jiffies is the _sane_ lower limit for this
> polling behavior?  (And did you imagine what would happen if doing it
> on a non-preemptive kernel?)
>
> Hypothetically we may set any value.  But whether it really helps in
> practice, one needs to think twice.

My imagination would be that it wouldn't be terribly slow, as there's 
always at least a jiffy between poll runs, that could be used for other 
tasks. But I haven't tried it.

I doubt we'll get a lot of bug reports from people who have set the poll 
interval to 1 ms and then complaining about bad performance. If we do, 
we could set a limit.

That's my suggestion, but as I said, it's not a big deal.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
