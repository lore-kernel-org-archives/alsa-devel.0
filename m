From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb: "delay: estimated 0, actual 352"
Date: Thu, 06 Sep 2012 09:08:27 +0200
Message-ID: <50484BEB.4020103@gmail.com>
References: <s5hmx1526mg.wl%tiwai@suse.de> <20120906060220.GA252@x4>
 <504843BA.2040808@gmail.com> <s5hehmfir46.wl%tiwai@suse.de>
 <20120906065340.GA257@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 07690265CA7
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 09:08:31 +0200 (CEST)
Received: by bkuw5 with SMTP id w5so505260bku.38
 for <alsa-devel@alsa-project.org>; Thu, 06 Sep 2012 00:08:31 -0700 (PDT)
In-Reply-To: <20120906065340.GA257@x4>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 06.09.2012 08:53, Markus Trippelsdorf wrote:
> On 2012.09.06 at 08:48 +0200, Takashi Iwai wrote:
>> At Thu, 06 Sep 2012 08:33:30 +0200,
>> Daniel Mack wrote:
>>>
>>> On 06.09.2012 08:02, Markus Trippelsdorf wrote:
>>>> On 2012.09.04 at 16:40 +0200, Takashi Iwai wrote:
>>>>> ----------------------------------------------------------------
>>>>> Sound fixes for 3.6-rc5
>>>>>
>>>>> There are nothing scaring, contains only small fixes for HD-audio and
>>>>> USB-audio:
>>>>> - EPSS regression fix and GPIO fix for HD-audio IDT codecs
>>>>> - A series of USB-audio regression fixes that are found since 3.5 kernel
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Daniel Mack (4):
>>>>>       ALSA: snd-usb: Fix URB cancellation at stream start
>>>>>       ALSA: snd-usb: restore delay information
>>>>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
>>>> The commit fbcfbf5f above causes the following lines to be printed
>>>> whenever I start a new song:
>>>
>>> Copied Pierre-Louis Bossart - he wrote the code in 294c4fb8 which this
>>> patch (fbcfbf5f) brings back now.
>>>
>>>> delay: estimated 0, actual 352
>>>> delay: estimated 353, actual 705
>>>>
>>>> (44.1 * 8 = 352.8)
>>>>
>>>> This happens with an USB-DAC that identifies itself as "C-Media USB
>>>> Headphone Set".
>>>
>>> And you didn't you see these lines with 3.4?
>>
>> Maybe the difference of start condition?
>>
>> Markus, does the patch below fix anything?
> 
> Unfortunately no.
> However reverting the following fixes the problem:
> 
> commit 245baf983cc39524cce39c24d01b276e6e653c9e
> Author: Daniel Mack <zonque@gmail.com>
> Date:   Thu Aug 30 18:52:30 2012 +0200
> 
>     ALSA: snd-usb: fix calls to next_packet_size
> 

No, this one certainly fixes a problem and does the right thing by
restoring the original code.

If you wouldn't state that you didn't see the same effect with 3.4(!),
before the refactoring done in 3.5, I would believe the device is simply
slightly off in its feedback rate and the tighter delay code complains
about it while compensating, just as it did before.

Are there any more than these two lines? And is audio working at all? Is
it distorted in any way?

Pierre-Louis, could you check whether I did the right thing when I
ported over your delay bits to the new endpoint logic? Maybe I'm missing
something here, but I currently don't see it.


Thanks,
Daniel
