From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Improving status timestamp accuracy
Date: Fri, 15 Jul 2016 15:13:48 -0500
Message-ID: <93b0b35f-5b8d-6ba3-c7db-fb534e66d31c@linux.intel.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
 <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
 <57566D64.1050400@gmail.com> <577FC0C4.1060508@IEE.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E14E267E1D
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 22:13:51 +0200 (CEST)
In-Reply-To: <577FC0C4.1060508@IEE.org>
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

On 7/8/16 10:03 AM, Alan Young wrote:
> On 07/06/16 07:44, Alan Young wrote:
>> I'll work on developing and testing a patch for consideration before
>> coming back to the last. It will be easier to discuss the merits or
>> otherwise of my proposal with a concrete, working patch to consider.
>
>
> Well, it has been a few weeks but this is what I have come up with.
>
> It is not perfect because of the issue noted in the comments but so far
> I have not been able to discover any downside. It many (most) cases, the
> reported delay (and audio_tstamp) is more accurate than it was before.
> In other cases there is no change.

I just looked at the code and I am probably missing something.

in update_delay() you apply a delta between the last timestamp and the 
current one and modify the runtime->delay.

Immediately after, in update_audio_tstamp() runtime->delay is used as 
well to compute audio_frames which in turn is used to find the 
audio_tstamp, on which another delta between current tstamp and last 
timestamp is applied.

Overall it looks like you are correcting twice for the same delay?

Even if this was correct, you would want to make sure the delta is 
positive to keep audio timestamps monotonous.
