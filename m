From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Improving status timestamp accuracy
Date: Mon, 1 Aug 2016 16:56:22 -0500
Message-ID: <97295c12-7abb-54a2-f51f-7610c0e5447c@linux.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D00E26568F
 for <alsa-devel@alsa-project.org>; Mon,  1 Aug 2016 23:56:26 +0200 (CEST)
In-Reply-To: <578F2139.9060001@IEE.org>
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

On 7/20/16 1:59 AM, Alan Young wrote:
> On 19/07/16 16:58, Pierre-Louis Bossart wrote:
>>> In update_audio_tstamp() it either usedruntime->delay, if
>>> runtime->audio_tstamp_config.report_delay is true, or applies a delta -
>>> not both.
>>
>> ah yes, I did miss it in the code. maybe a comment would be nice to
>> avoid being thrown.
> ok
>
>> I still have mixed feelings about the code, it seems to make sense for
>> the case where the .pointer is updated at every period, but it's not
>> using the regular BATCH definition. With the tests such as
>> runtime->status->hw_ptr == runtime->hw_ptr_interrupt you could end-up
>> modifying the results by a small amount for other hardware platforms
>> depending on when the timestamp is taken (in other words scheduling
>> latency would affect audio timestamps).
>>
>
> Yes, that could be true - there could be some jitter -  but I think it
> will still result in more accurate results. Note that the adjustment to
> the reported audio_tstamp will only occur for the
> AUDIO_TSTAMP_TYPE_DEFAULT case and when the platform has not updated the
> (hw_ptr) position outside of the interrupt callback independent of
> whether the BATCH flag is used.
>
> There is actually an argument for being less restrictive. Hardware
> platform updates to position, where they happen outside of an interrupt,
> may (generally will) be less accurate than the update mechanism that I
> propose because such position updates are mostly restricted to the level
> of DMA residue granularity, which is relatively coarse (usually).

I am not hot on changing a default behavior and end-up with platforms 
getting worse results and some getting better.
It'd really be better if you used a new timestamp (I added the 
LINK_ESTIMATED_ATIME that isn't used by anyone and could be reclaimed) 
and modified the delay estimation in your own driver rather than in the 
core.

>
>>
>> if your timestamps are REALTIME since they can jump backwards. The
>> expectation is to use MONOTONOUS (or better MONOTONOUS_RAW to avoid
>> NTP corrections), but with the ALSA API the application can choose
>> REALTIME.
>
> Ok, I'll put in  a check. Of course there are cases where one might
> actually want REALTIME.
>
> Note: For my application, I only actually care about the changes
> implemented using update_delay(). The refinement to
> update_audio_tstamp() just seemed to me to be part of the same issue. If
> the update_audio_tstamp() change is considered too controversial then
> I'd be happy to drop it.

if you change the delay by default then it changes the audio timestamp 
as well, not sure how you can isolate the two parts.
