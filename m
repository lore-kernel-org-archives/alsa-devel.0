From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: [PATCH 4/7] ice1724 - adding GPIO routines for
	mask and direction
Date: Wed, 16 Sep 2009 09:15:56 +0200
Message-ID: <4AB090AC.3080503@ivitera.com>
References: <1253054396-7978-1-git-send-email-pavel.hofman@ivitera.com>	<1253054396-7978-2-git-send-email-pavel.hofman@ivitera.com>	<1253054396-7978-3-git-send-email-pavel.hofman@ivitera.com>	<1253054396-7978-4-git-send-email-pavel.hofman@ivitera.com>
	<s5hab0vzalr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 0278324344
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 09:15:36 +0200 (CEST)
In-Reply-To: <s5hab0vzalr.wl%tiwai@suse.de>
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
> At Wed, 16 Sep 2009 00:39:53 +0200,
> pavel.hofman@ivitera.com wrote:
>> From: pavel <pavel@nahore.(none)>
>>
>> * get/set routines for GPIO mask and direction
>>
>> Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>
> 
> The get_mask callback is still undefined for ice1724...

That is weird. I split the original commit using interactive git rebase
+ edit + add interactive into three new commits - get-mask,
pro-rate-locked and all the external-clock. I commited all of them,
rechecked git status before continuing with rebase - nothing uncommitted
was left, no outstanding changes. But the get_mask commit did not show
up in the subsequent interactive rebase list of commits. I was looking
for it, I thought I found it in the main gpio-methods commit but
overlooked that it is for ice1712.c only.

The method and its callback has disappeared from my master after the
rebase. Do you have any idea what could have gone wrong?

I will fix and repost in the evening.


> 
> 
>> --- a/pci/ice1712/ice1712.h
>> +++ b/pci/ice1712/ice1712.h
>> @@ -28,6 +28,7 @@
>>  #include <sound/i2c.h>
>>  #include <sound/ak4xxx-adda.h>
>>  #include <sound/ak4114.h>
>> +#include <sound/ak4113.h>
> 
> We don't need this header here.
> (Ditto for ak4114.h and pt2258.h.  They were needed because the
>  structure were referred in ice1712.h.  But they are now gone to the
>  local structure, so no need in the common header.)


Yesterday I moved it from ice1712.h to quartet.h. The build succeeded
but when loading the new snd-ice1724 module I got dmesg messages about
unknown references to ak4113 methods used in the quartet code. That is
why I left the include in ice1712.h which works fine.

Unfortunately my knowledge of the build/load infrastructure is very
limited, I can do just copy/paste in this area :)

Thanks,

Pavel.
