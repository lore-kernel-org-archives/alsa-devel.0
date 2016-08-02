From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Improving status timestamp accuracy
Date: Tue, 2 Aug 2016 11:25:36 -0500
Message-ID: <354e2501-90cf-44eb-f222-5efbca6d93cc@linux.intel.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
 <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
 <57566D64.1050400@gmail.com> <577FC0C4.1060508@IEE.org>
 <93b0b35f-5b8d-6ba3-c7db-fb534e66d31c@linux.intel.com>
 <578E4862.4050603@IEE.org>
 <805c3724-f027-a405-5704-3b343aa5404b@linux.intel.com>
 <578F2139.9060001@IEE.org>
 <97295c12-7abb-54a2-f51f-7610c0e5447c@linux.intel.com>
 <57A04BFE.9030704@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DEB31266858
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 18:25:39 +0200 (CEST)
In-Reply-To: <57A04BFE.9030704@IEE.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <Alan.Young@IEE.org>, Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> It'd really be better if you used a new timestamp (I added the
>> LINK_ESTIMATED_ATIME that isn't used by anyone and could be reclaimed)
>> and modified the delay estimation in your own driver rather than in
>> the core.
>>
>
> Well, I'm not looking at a single driver here. I am looking at several
> that use large parts of the common soc framework in various ways.
>
> I'll look at LINK_ESTIMATED_ATIME and see if I could adopt that. I'm not
> sure how much it will help with the delay calculation but I suspect that
> the right answer could be deduced.

The LINK timestamps are supposed to be read from hardware counters close 
to the interface for better accuracy. When I added the LINK_ESTIMATED 
part, I thought this could be useful when those counters are not 
supported, but realized that if the delay is accurate you can just as 
well use the default method of adding the delay information to the DMA 
position to get the timestamps - there is really no benefit in defining 
a new timestamp type.
In the case where the delay is not accurate (on the platforms you are 
experimenting with) then this might be the right solution. And we could 
add this timestamp in the core rather than in each driver for simplicity.
It would be interesting if you share results with different timestamps 
to see if there is any benefit (with e.g. alsa-lib/test/audio_time.c)

> The more that I think about it the more it seems to me that using a
> time-based estimate for position (hw_ptr), outside of an interrupt
> callback, will always be more accurate than that returned by
> substream->ops->pointer(). Perhaps the results of that call should
> simply be ignored outside an interrupt callback - the call not even
> made, so as not to pollute the estimate with changed delay data.

then you'd have to account for drift between audio and timer source, 
it's not simpler at all and as Clemens wrote can lead to corrupted 
pointers if you screw up.
