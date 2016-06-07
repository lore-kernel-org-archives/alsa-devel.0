From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Improving status timestamp accuracy
Date: Tue, 7 Jun 2016 14:01:01 -0400
Message-ID: <d8fe0259-147b-9345-9a46-fef2f0cc61e3@linux.intel.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
 <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
 <57566D64.1050400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E7A3B26047C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 20:01:04 +0200 (CEST)
In-Reply-To: <57566D64.1050400@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Young <consult.awy@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/7/16 2:44 AM, Alan Young wrote:
> On 06/06/16 15:53, Pierre-Louis Bossart wrote:
>> I probably need more coffee but how is this patch helping track audio
>> v. wallclock drift? The additional precision is based on wallclock
>> deltas...
>
>
> Of course, it wouldn't, due to being buggy. I think I needed more coffee
> too.
>
> But the basic point is that if the difference between tstamp and
> (trigger_tstamp + audio_tstamp) varies over time, this will be the drift
> between the audio output and wallclock time.

You want to track (tstamp - trigger_tstamp) v. (audio_tstamp - 
trigger_tstamp)

>
> Depending upon the specific goal, a calculation based on tstamp + delay
> may be appropriate.
>
> This is true today with a granularity of about period time. The idea
> behind my change is to make the granularity much smaller, preferably < ~1ms.
>
> I'll work on developing and testing a patch for consideration before
> coming back to the last. It will be easier to discuss the merits or
> otherwise of my proposal with a concrete, working patch to consider.
>
> Alan.
>
