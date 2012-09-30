From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: core: add hooks for audio
	timestamps
Date: Sun, 30 Sep 2012 12:11:55 +0200
Message-ID: <50681AEB.1060104@ladisch.de>
References: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <50656EFE.40407@ladisch.de> <5067575B.8070500@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 23EFB26159C
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2012 12:13:08 +0200 (CEST)
In-Reply-To: <5067575B.8070500@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
>>> +                audio_frames = runtime->status->hw_ptr
>>> +                    + runtime->delay;
>>> +            audio_nsecs = audio_frames * 1000000000LL /
>>> +                runtime->rate;
>>
>> This looks like a 64-bit division.

... which needs to be handled with a function from <linux/math64.h>.

>> And what happens if audio_frames becomes negative?
>
> It's my understanding that hw_ptr represents the cumulative frames
> played since the beginning, not sure why it'd become negative, ever.

2^32 / 192 kHz = 6.2 h

> I don't understand the notion of 'boundary'

This is where hw_ptr wraps around.  It's a multiple of the buffer size
to make some calculations easier.

> and the use of the hw_ptr_base

It's the hw_ptr corresponding to the start of the buffer.

I guess audio_tstamp isn't supposed to wrap around?


Regards,
Clemens
