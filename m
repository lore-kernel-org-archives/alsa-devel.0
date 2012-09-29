From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: core: add hooks for audio
	timestamps
Date: Sat, 29 Sep 2012 15:17:31 -0500
Message-ID: <5067575B.8070500@linux.intel.com>
References: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <50656EFE.40407@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 27403261644
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 22:17:45 +0200 (CEST)
In-Reply-To: <50656EFE.40407@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> +				audio_frames = runtime->status->hw_ptr
>> +					+ runtime->delay;
>> +			audio_nsecs = audio_frames * 1000000000LL /
>> +				runtime->rate;
>
> This looks like a 64-bit division.
>
> And what happens if audio_frames becomes negative?

It's my understanding that hw_ptr represents the cumulative frames 
played since the beginning, not sure why it'd become negative, ever.
I know this deserves more love, I don't understand the notion of 
'boundary' and the use of the hw_ptr_base, I figured smarter people than 
me would help.
Thanks,
-Pierre
