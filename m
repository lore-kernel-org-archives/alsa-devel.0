From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Asynchronous audio USB chips: choppy playback
 since 3.8-rc7
Date: Wed, 24 Apr 2013 20:30:35 +0200
Message-ID: <517824CB.8050309@canonical.com>
References: <Pine.LNX.4.44L0.1304191638020.29846-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BCB062615E6
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 20:30:37 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1304191638020.29846-100000@netrider.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 1136110@bugs.launchpad.net, Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Tyson Tan <tysontan@mail.com>, Joseph Salisbury <joseph.salisbury@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 04/19/2013 10:48 PM, Alan Stern wrote:
> On Fri, 19 Apr 2013, Daniel Mack wrote:
>
>> On 03.04.2013 12:25, Takashi Iwai wrote:
>>> At Wed, 03 Apr 2013 12:15:25 +0200,
>>> David Henningsson wrote:
>>>>
>>>> Hi ALSA developers,
>>>>
>>>> Just to get your attention here on what seems to be an USB audio
>>>> regression.
>>>>
>>>> The bug is described in detail here:
>>>>
>>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136110?comments=all
>>>>
>>>> Quoting the bug:
>>>>
>>>> "
>>>> This bug seems to affect only a certain kind of hardware, which is
>>>> called "Asynchronous USB Digital Audio Codec (DAC)". It's said that such
>>>> a DAC hosts the clock itself (USB Device Host). An ordinary DAC, so
>>>> called "Synchronous USB DAC", uses the clock hosted by the mother board,
>>>> which is not affected by this bug.
>>>>
>>>> When this bug affects an asynchronous USB DAC, the audio played by the
>>>> DAC is constantly interrupted. The playback itself does not stop, but
>>>> the output becomes discontinous, filling with constant crackling noises,
>>>> destroying everything the DAC plays.
>>>> "
>>>>
>>>> According to the bug reporter, which seems to have done quite a bit of
>>>> research, this started between 3.8-rc6 and 3.8-rc7 as well as stable
>>>> kernels and the bug also lists a few commits which could be the cause,
>>>> none under sound/usb though.
>>>
>>> Yes, there is no commits regarding usb-audio itself between 3.8-rc6
>>> and rc7, so the likely culprit is in drivers/usb (usually either
>>> drivers/usb/host or drivers/usb/core).  There are a bunch of changes
>>> there, so further bisection would be appreciated.
>>
>> Ok, Joseph Salisbury has build some bisection kernels, and Tyson Tan
>> relentlessly tested all of them, and it turns out that
>>
>> 3e619d0415 ("USB: EHCI: fix bug in scheduling periodic split transfers")
>>
>> Is the first bad commit. Also, reverting this commit from the current
>> mainline head makes the problem disappear.
>>
>> Alan, any idea?
>>
>>    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136110
>
> No ideas as to the cause.
>
> For debugging, it would help to see a usbmon trace from a kernel where
> the problem occurs, together with a trace from another kernel where the
> problem does not occur.
>
> Alan Stern

First, thanks for looking at this bug.

While a long-term solution is being discussed, this patch went to stable 
too, where it is causing regressions. Would it be okay just to revert 
this patch in the next stable series? (Even if this was a bug fix, few 
people seem to have noticed?) Or do you envision something else 
happening but the original -ENOSPC error showing up, due to other stuff 
that went to stable at the same time?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
