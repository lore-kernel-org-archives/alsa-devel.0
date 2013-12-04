From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix missing ELD info when
 using jackpoll_ms parameter
Date: Wed, 04 Dec 2013 15:56:05 +0800
Message-ID: <529EE015.4080406@canonical.com>
References: <1386123581-2698-1-git-send-email-david.henningsson@canonical.com>	<s5hr49t3x0n.wl%tiwai@suse.de>	<529ED8AC.9000804@canonical.com>
 <s5hiov53vvb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E2C92616F6
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 08:56:10 +0100 (CET)
In-Reply-To: <s5hiov53vvb.wl%tiwai@suse.de>
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

2013-12-04 15:42, Takashi Iwai skrev:
> At Wed, 04 Dec 2013 15:24:28 +0800,
> David Henningsson wrote:
>> 2013-12-04 15:17, Takashi Iwai skrev:
>>> At Wed,  4 Dec 2013 10:19:41 +0800,
>>> David Henningsson wrote:
>>>> In the case of using jackpoll_ms instead of unsol events, the jack
>>>> was correctly detected, but ELD info was not refreshed on plug-in.
>>>>
>>>> And without ELD info, no proper restriction of pcm, which can in turn
>>>> break sound output on some devices.
>>>>
>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>> ---
>>>>    sound/pci/hda/patch_hdmi.c |   27 +++++++++++++++------------
>>>>    1 file changed, 15 insertions(+), 12 deletions(-)
>>>>
>>>> @Takashi; feel free to add stable if you think it's worth it. (After all using
>>>> the jackpoll_ms parameter is not something we usually do.) It's still a bug fix
>>>> so sending to Linus tree should be okay, I believe.
>>> Hrm, I vaguely remember that I gave a very similar patch for testing,
>>> but it failed by some reason...
>>>
>>>
>> That indeed sounds vague. :-) At this point, is there anything required
>> on my part to help getting this bug fixed? We run into it when we're
>> backporting kernel features, i e, using graphics driver from one kernel
>> version and hda driver from another kernel version... (and in this weird
>> kernel mixup we haven't figured out why we don't get an interrupt, so as
>> a workaround I'm using jackpoll_ms until we've figured that out.)
> It's in a thread in June, about
>    [PATCH 1/2] ALSA: hdmi - poll eld at resume time
>
>
> Takashi
>

If you mean this patch:

http://mailman.alsa-project.org/pipermail/alsa-devel/2013-June/063336.html

...it would probably resolve this issue, but instead cause problems when 
jackpoll is not used, because snd_hda_jack_report_sync does not call the 
jack callback. Essentially, you need to call hdmi_jack_detect_cb from 
hdmi_intrinsic_event and your patch should work too.

I think - this analysis is all done by quickly looking at your patch, 
not by actual testing.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
