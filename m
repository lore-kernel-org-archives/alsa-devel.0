From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] Revert "ALSA: hda - Shut up pins at
 power-saving mode with Conexnat codecs"
Date: Thu, 03 Jan 2013 17:04:15 +0100
Message-ID: <50E5ABFF.8040207@canonical.com>
References: <1355906687-2881-1-git-send-email-david.henningsson@canonical.com>
 <s5hobhqtk50.wl%tiwai@suse.de> <50D19846.8060902@canonical.com>
 <s5hhanitjha.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 26B41261639
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2013 17:04:07 +0100 (CET)
In-Reply-To: <s5hhanitjha.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, 886975@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 12/19/2012 11:38 AM, Takashi Iwai wrote:
> At Wed, 19 Dec 2012 11:34:46 +0100,
> David Henningsson wrote:
>>
>> On 12/19/2012 11:24 AM, Takashi Iwai wrote:
>>> At Wed, 19 Dec 2012 09:44:47 +0100,
>>> David Henningsson wrote:
>>>>
>>>> This reverts commit 697c373e34613609cb5450f98b91fefb6e910588.
>>>>
>>>> The original patch was meant to remove clicking, but in fact caused even
>>>> more clicking instead.
>>>>
>>>> Thanks to c4pp4 for doing most of the work with this bug.
>>>>
>>>> BugLink: https://bugs.launchpad.net/bugs/886975
>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>> ---
>>>>
>>>> @c4pp4: Is this consistent with what you have done to reduce the clicking?
>>>> Will you recommend upstream Linux to take the patch below?
>>>
>>> So, it shouldn't be merged yet right now?
>>> Now is the last chance for merging it to 3.8-rc1.
>>
>> If we don't have time waiting for c4pp4's confirmation without missing
>> the entire 3.8 cycle, then I think we should merge it.
>
> It's no new feature, so it's fine to merge it at any time during 3.8
> cycle, even after 3.8-rc1.
>
> But such a fix should be merged with Cc to stable, so a bit more tests
> would be better.

Do you have a suggestion on how that should be tested? I have no 
conexant machines here currently.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
