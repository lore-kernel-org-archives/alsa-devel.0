From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Disable runtime PM
 on	LynxPoint(-LP) controllers
Date: Wed, 20 Nov 2013 14:35:09 +0100
Message-ID: <528CBA8D.8020907@canonical.com>
References: <s5h38msqqqg.wl%tiwai@suse.de>	<528C78D2.6020207@canonical.com>	<s5hli0jp9bw.wl%tiwai@suse.de>
 <s5hiovnp5b7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id F11FE2616E1
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 14:35:10 +0100 (CET)
In-Reply-To: <s5hiovnp5b7.wl%tiwai@suse.de>
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
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/20/2013 02:32 PM, Takashi Iwai wrote:
> At Wed, 20 Nov 2013 13:05:23 +0100,
> Takashi Iwai wrote:
>>
>> At Wed, 20 Nov 2013 09:54:42 +0100,
>> David Henningsson wrote:
>>>
>>> (Adding Mengdong to cc)
>>>
>>> On 11/19/2013 05:51 PM, Takashi Iwai wrote:
>>>> We got bug reports of the stalled HD-audio, typically after S3 or S4,
>>>> and it turned out that they seemed triggered by runtime PM on Lynx
>>>> Point and Lynx Point-LP controllers.  As there is no way to recover
>>>> properly from the stalled controller, it's safer to disable the
>>>> runtime PM support on these chips for now.
>>>
>>> Oh, this is a bit sad news. Have you talked to Intel about it?
>>>
>>> Anyway, I saw something similar a while ago, but never with access to
>>> the hardware, and then it was difficult to reproduce for the person on
>>> the other side. Nevertheless, when I read through the PM code I found
>>> that the GCTL register was sometimes accessed with readb (although it is
>>> a 32 bit register), so I wrote a patch for that, but the testing results
>>> of this patch were a bit inconclusive, so I never upstreamed it.
>>>
>>> Anyway, I'm attaching the draft patch. Do you think it could be related?
>>
>> It didn't change the behavior although the change looks good.

It looks good indeed, but it's always scary to do subtle changes without
testing on all the 50+ controllers we support...do you think I should
submit a proper patch for it?

>>
>> After a long debugging session in this morning, I finally nailed
>> down.  This was the fault in the sound driver after all, shamefully :)
>>
>> The fix patch is below.
>>
>> The code needs a bit clean up, and I have it, but will apply this for
>> 3.14.
>>
>>
>> Takashi
>>
>> ===
>>
>> From: Takashi Iwai <tiwai@suse.de>
>> Subject: [PATCH 1/2] ALSA: hda - Fix unbalanced runtime PM notification at
>>  resume
> 
> BTW, it's marked as 1/2 just because of the clean up patch I mentioned
> above.  Only this one is needed for now.

Ok, thanks for the clarification, and glad you finally found it! And so
are you I guess :-)


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
