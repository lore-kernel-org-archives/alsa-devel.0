From: Alan Young <Alan.Young@IEE.org>
Subject: Re: Improving status timestamp accuracy
Date: Tue, 2 Aug 2016 08:30:06 +0100
Message-ID: <57A04BFE.9030704@IEE.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id C9D74265AA7
 for <alsa-devel@alsa-project.org>; Tue,  2 Aug 2016 09:30:09 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id i5so29286388wmg.2
 for <alsa-devel@alsa-project.org>; Tue, 02 Aug 2016 00:30:09 -0700 (PDT)
In-Reply-To: <97295c12-7abb-54a2-f51f-7610c0e5447c@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre,

Thanks for your continued engagement on this thread.

On 01/08/16 22:56, Pierre-Louis Bossart wrote:
> On 7/20/16 1:59 AM, Alan Young wrote:
>>
>> Yes, that could be true - there could be some jitter -  but I think it
>> will still result in more accurate results. Note that the adjustment to
>> the reported audio_tstamp will only occur for the
>> AUDIO_TSTAMP_TYPE_DEFAULT case and when the platform has not updated the
>> (hw_ptr) position outside of the interrupt callback independent of
>> whether the BATCH flag is used.
>>
>> There is actually an argument for being less restrictive. Hardware
>> platform updates to position, where they happen outside of an interrupt,
>> may (generally will) be less accurate than the update mechanism that I
>> propose because such position updates are mostly restricted to the level
>> of DMA residue granularity, which is relatively coarse (usually).
>
> I am not hot on changing a default behavior and end-up with platforms 
> getting worse results and some getting better. 

I am not sure that any platforms would get worse results 
(notwithstanding the jitter point above). Some would get better results.
>
> It'd really be better if you used a new timestamp (I added the 
> LINK_ESTIMATED_ATIME that isn't used by anyone and could be reclaimed) 
> and modified the delay estimation in your own driver rather than in 
> the core.
>

Well, I'm not looking at a single driver here. I am looking at several 
that use large parts of the common soc framework in various ways.

I'll look at LINK_ESTIMATED_ATIME and see if I could adopt that. I'm not 
sure how much it will help with the delay calculation but I suspect that 
the right answer could be deduced.

>> Note: For my application, I only actually care about the changes
>> implemented using update_delay(). The refinement to
>> update_audio_tstamp() just seemed to me to be part of the same issue. If
>> the update_audio_tstamp() change is considered too controversial then
>> I'd be happy to drop it.
>
> if you change the delay by default then it changes the audio timestamp 
> as well, not sure how you can isolate the two parts.
>

It only changes the audio timestamp if the user requests that the delay 
be included in it.


Stepping back for a moment, the delay calculation essentially consists 
of two parts:

 1. How much data is still in the ring buffer.
 2. How much data has been removed from the ring buffer but not yet
    played out.

In many respects it is artificial to separate these but that is what the 
API does.

In some cases the first factor is dominant, because DMA is consuming the 
buffer and one has - at the very best - only coarse-grained data about 
the position at any moment. It is unlikely ever to be sample-position 
accurate and, for most platforms, is much poorer.

In some cases the second factor is dominant because some data has been 
taken from the ring buffer and is then in some other significant size 
buffer. USB is a good example and, in that case, one can see that the 
generic driver does indeed used an elapsed-time calculation to generate 
(estimate) the delay report.

The more that I think about it the more it seems to me that using a 
time-based estimate for position (hw_ptr), outside of an interrupt 
callback, will always be more accurate than that returned by 
substream->ops->pointer(). Perhaps the results of that call should 
simply be ignored outside an interrupt callback - the call not even 
made, so as not to pollute the estimate with changed delay data.

Alan.
