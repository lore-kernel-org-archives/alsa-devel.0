From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 4/7] ice1724 - adding GPIO routines
 for	mask and direction
Date: Wed, 16 Sep 2009 22:15:38 +0200
Message-ID: <4AB1476A.7060403@ivitera.com>
References: <1253054396-7978-1-git-send-email-pavel.hofman@ivitera.com>	<1253054396-7978-2-git-send-email-pavel.hofman@ivitera.com>	<1253054396-7978-3-git-send-email-pavel.hofman@ivitera.com>	<1253054396-7978-4-git-send-email-pavel.hofman@ivitera.com>	<s5hab0vzalr.wl%tiwai@suse.de>	<4AB090AC.3080503@ivitera.com>	<s5h4or3z5x5.wl%tiwai@suse.de>	<4AB09D72.4070200@ivitera.com>
	<s5hk4zz70ru.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.pilsfree.net (mail.pilsfree.net [81.201.60.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 5827A10388E
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 22:15:47 +0200 (CEST)
In-Reply-To: <s5hk4zz70ru.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 16 Sep 2009 10:10:26 +0200,
> Pavel Hofman wrote:
>> Takashi Iwai wrote:
>>> At Wed, 16 Sep 2009 09:15:56 +0200,
>>> Pavel Hofman wrote:
>>>> Takashi Iwai wrote:
>>>>> At Wed, 16 Sep 2009 00:39:53 +0200,
>>>>> pavel.hofman@ivitera.com wrote:
>>>>>> From: pavel <pavel@nahore.(none)>
>>>>>>
>>>>>> * get/set routines for GPIO mask and direction
>>>>>>
>>>>>> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
>>>>> The get_mask callback is still undefined for ice1724...
>>>> That is weird. I split the original commit using interactive git rebase
>>>> + edit + add interactive into three new commits - get-mask,
>>>> pro-rate-locked and all the external-clock. I commited all of them,
>>>> rechecked git status before continuing with rebase - nothing uncommitted
>>>> was left, no outstanding changes. But the get_mask commit did not show
>>>> up in the subsequent interactive rebase list of commits. I was looking
>>>> for it, I thought I found it in the main gpio-methods commit but
>>>> overlooked that it is for ice1712.c only.
>>>>
>>>> The method and its callback has disappeared from my master after the
>>>> rebase. Do you have any idea what could have gone wrong?
>>> No idea...
>>> But rebasing is a bit dangerous operation, and I often forget to finish 
>>> the rebase until the last commit, getting incomplete rebase in the
>>> end.  So, I usually copy the original branch first before rebase
>>> explicitly, and check the difference from the original branch after
>>> rebasing.
>> Thanks for the info, I will do that next time.
>>
>>>> Yesterday I moved it from ice1712.h to quartet.h. The build succeeded
>>>> but when loading the new snd-ice1724 module I got dmesg messages about
>>>> unknown references to ak4113 methods used in the quartet code. That is
>>>> why I left the include in ice1712.h which works fine.
>>>>
>>>> Unfortunately my knowledge of the build/load infrastructure is very
>>>> limited, I can do just copy/paste in this area :)
>> Please, how should I change the include to fix the module load?
> 
> The inclusion of ak4113.h should be irrelevant with the build process
> and the module dependency.
> Is snd-ak4114.ko properly built and installed?
> 

Complete gitcompile produced no errors when loading the module where
ak4113.h was included directly in quartet.c.

Thanks,

Pavel.
