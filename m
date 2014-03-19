From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] pcm: route: Don't handle no matching chmap
 as a serious error
Date: Wed, 19 Mar 2014 13:10:55 +0100
Message-ID: <5329894F.6040303@canonical.com>
References: <1395152876-28480-1-git-send-email-tiwai@suse.de>	<53287211.1040803@canonical.com>	<s5h1txzpisl.wl%tiwai@suse.de>	<5328C4EE.4010807@canonical.com>
 <s5hk3bqo6ht.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CCDCC265095
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 13:10:56 +0100 (CET)
In-Reply-To: <s5hk3bqo6ht.wl%tiwai@suse.de>
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

On 03/19/2014 10:57 AM, Takashi Iwai wrote:
> At Tue, 18 Mar 2014 23:13:02 +0100,
> David Henningsson wrote:
>>
>> On 03/18/2014 05:34 PM, Takashi Iwai wrote:
>>> At Tue, 18 Mar 2014 17:19:29 +0100,
>>> David Henningsson wrote:
>>>>
>>>> On 03/18/2014 03:27 PM, Takashi Iwai wrote:
>>>>> When find_matching_chmap() returns an error for the non-matching
>>>>> chmap, the caller, snd_pcm_route_open(), also returns an error
>>>>> although it shouldn't be handled as the fatal error.  This results in
>>>>> the probe error with PulseAudio and it gives no real output in the
>>>>> end.
>>>>
>>>> Hmm, could you give a more specific example? In case the driver does not
>>>> support channel maps at all, that case is handled in the beginning of
>>>> the function.
>>>
>>> Well, the problem is that PulseAudio doesn't work at all with the
>>> current alsa-lib git prior to the commit in some cases.  That is, the
>>> commit brought some incompatibility.
>>
>> Hmm, then the error should be somewhere in determine_chmap instead.
>> tt_chmap should be NULL (i e, find_matching_chmap is never called) for
>> using the standard number syntax instead of the new chmap syntax.
>>
>> What about the patch attached instead (untested) ?
>>
>>>> So this only happens if the driver supports channel maps, but only
>>>> non-compatible with the requested map. In which case I believe it's
>>>> correct that the probing should fail...?
>>>
>>> Could you check whether PA 5.0 works as is with alsa-lib git (before
>>> the last fix)?  It could be seen on some desktop machines.
>>
>> Let me know if the attached patch works for you. In case it does not I
>> will do this testing later.
> 
> It seems working, but it revealed another bug, too.  I fixed it in git
> tree, and reverted my last patch along with it.

I don't think the patch "route: Fix invalid pointer access" is necessary
because determine_chmap is always called before any usage of tt_chmap,
and the function always assigns a value to tt_chmap. But it does not
hurt either, of course.

Thanks for the testing!

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
