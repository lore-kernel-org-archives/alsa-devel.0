From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Improving status timestamp accuracy
Date: Tue, 19 Jul 2016 10:58:40 -0500
Message-ID: <805c3724-f027-a405-5704-3b343aa5404b@linux.intel.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
 <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
 <57566D64.1050400@gmail.com> <577FC0C4.1060508@IEE.org>
 <93b0b35f-5b8d-6ba3-c7db-fb534e66d31c@linux.intel.com>
 <578E4862.4050603@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA74267F93
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 17:58:43 +0200 (CEST)
In-Reply-To: <578E4862.4050603@IEE.org>
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

On 7/19/16 10:33 AM, Alan Young wrote:
> On 15/07/16 21:13, Pierre-Louis Bossart wrote:
>> in update_delay() you apply a delta between the last timestamp and the
>> current one and modify the runtime->delay.
>>
>> Immediately after, in update_audio_tstamp() runtime->delay is used as
>> well to compute audio_frames which in turn is used to find the
>> audio_tstamp, on which another delta between current tstamp and last
>> timestamp is applied.
>>
>> Overall it looks like you are correcting twice for the same delay?
>>
> In update_audio_tstamp() it either usedruntime->delay, if
> runtime->audio_tstamp_config.report_delay is true, or applies a delta -
> not both.

ah yes, I did miss it in the code. maybe a comment would be nice to 
avoid being thrown.

I still have mixed feelings about the code, it seems to make sense for 
the case where the .pointer is updated at every period, but it's not 
using the regular BATCH definition. With the tests such as
runtime->status->hw_ptr == runtime->hw_ptr_interrupt you could end-up 
modifying the results by a small amount for other hardware platforms 
depending on when the timestamp is taken (in other words scheduling 
latency would affect audio timestamps).

>
>> Even if this was correct, you would want to make sure the delta is
>> positive to keep audio timestamps monotonous.
>
> Hmm, maybe. In what circumstances could the delay ever be negative?

if your timestamps are REALTIME since they can jump backwards. The 
expectation is to use MONOTONOUS (or better MONOTONOUS_RAW to avoid  NTP 
corrections), but with the ALSA API the application can choose REALTIME.
