From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Tue, 13 Jun 2017 09:13:35 -0400
Message-ID: <20493c38-f716-1d8c-e876-301c78819006@linux.intel.com>
References: <1497245230-18436-1-git-send-email-subhransu.s.prusty@intel.com>
 <f0167d08-b11d-b687-3016-2128c82748ad@sakamocchi.jp>
 <e3bab853-1d14-32f1-5dae-a9a54b6014af@linux.intel.com>
 <cb000041-b474-2c00-a3dd-33cf86d7b80d@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F68E266C25
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 15:13:36 +0200 (CEST)
In-Reply-To: <cb000041-b474-2c00-a3dd-33cf86d7b80d@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On 6/13/17 7:09 AM, Takashi Sakamoto wrote:
> Pierre-Louis,
>
> On Jun 12 2017 21:09, Pierre-Louis Bossart wrote:
>>> If describing the detail design of your hardware, you might get more
>>> helps.
>>>
>>>  * I intentionally ignore discussion about burstness of data
>>>    transmission and accuracy of hwptr.
>>
>> You are probably reading too much into this.
>> The intent is to optimize DMA operations where the hardware now knows
>> both hw_ptr and appl_ptr. there is no use of the .ack() for copies into
>> intermediate buffers
>
> If this patch included enough explanation about the disadvantage of
> rewind operation on your driver and hardware in a point of optimization
> for DMA data transmission and power consumption, I would not have driven
> my imagination so hard for the reviewing.

Maybe you missed what we wrote in the commit message:
"this can be used by low-level driver to optimize DMA operations
and reduce power consumption."
There will be follow-up patches that make use of this capability on 
Intel platforms but for now this is hardware-agnostic.

>
>> and the code for rewind on capture is largely for
>> consistency - we've never seen anyone using rewind on capture on
>> DSP-based platforms.
>
> I'm not a prophet, and you too. It's not better to change interfaces
> with any forecast. Furthermore, once changing interfaces, it affects to
> all of applications. Please have enough care of it.

I don't get what you are saying. There is no interface or behavior 
change, disabling rewinds is strictly opt-in and controlled from the 
application. I was just stating that we have not seen anyone use rewinds 
on capture and at this point we have no need to disable non-existent 
usages...

>
> # I can imagine a disadvantage of rewind operation for PCM capture
> # substream. When rewinding, available space on PCM buffer for data
> # transmission from hardware is reduced. Then, even if hardware already
> # done sampling, it can't transfer the PCM frames. There's a delay and
> # hardware needs extra buffering.
>
>
> Regards
>
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
