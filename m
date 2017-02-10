From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH 0/6] Yet another experiments with LPE audio
Date: Fri, 10 Feb 2017 08:06:14 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60552CD7498@BGSMSX104.gar.corp.intel.com>
References: <20170207131122.6345-1-tiwai@suse.de>
 <s5hlgtiatv7.wl-tiwai@suse.de>	<s5hzihvb1t9.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60552CD6FAC@BGSMSX104.gar.corp.intel.com>
 <s5hr336bji8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id F06C226683E
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 09:06:21 +0100 (CET)
In-Reply-To: <s5hr336bji8.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Anand,
 Jerome" <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

>> >By using a generic dmix code with semaphore, this performance problem
>> >is resolved.  So, S16/S32 supports are OK in the end.
>> >
>> >But this leads to another question wrt the kernel driver code:
>> >why the driver allocates / maps with uncached page, not with write-
>> >combined?  Pierre, Jerome, any clue?
>> >
>>
>> In CHT and BYT the organization of the hardware fabric is such that
>> the HDMI DMA transactions are not snooped and so it will fetch
>> data only from DDR. In most non-atom platforms it is snooped, and so
>> fabric will return data from cache if it is updated.
>>
>> In the past we faced problem where the DMA was fetching some
>> old data because cache was not flushed into DDR. That's where
>> we marked the pages as uncached.
>
>Thanks, that's my expectation.  The similar hacks are applied to some
>audio platforms like AMD HDMI HD-audio.  But my question is about the
>write-combined (WC) pages.  There are four modes about page caching:
>write-back (WB), writhe-through (WT), write-combined (WC) and uncached
>(UC).
>
>Usually WC is enough to work as uncached like the use case above, not
>necessary to disable the whole cache via UC.  WC worked fine for
>HD-audio, at least.  For LPE audio, is UC really stated as mandatory
>requirement?
>

No, as such there is no guidelines from HW guys.
Technically WC would work as well. 

Question I have is, when we use the smaller period size with say 2 periods
with WC, how do we ensure that the last write has been propagated to the
main memory. Last write size may be smaller than the WC cache size.

>
>thanks,
>
>Takashi
