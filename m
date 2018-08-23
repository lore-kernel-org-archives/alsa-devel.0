From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC - AAF PCM plugin 3/5] aaf: Implement Playback
 mode support
Date: Thu, 23 Aug 2018 13:51:02 -0500
Message-ID: <2845fba5-1b5a-d783-dcc5-c4e4b94d47b8@linux.intel.com>
References: <20180821010653.15838-1-andre.guedes@intel.com>
 <20180821010653.15838-4-andre.guedes@intel.com>
 <294236b7-ace1-af42-508a-635fe9709f0e@linux.intel.com>
 <1534888610.4547.104.camel@intel.com>
 <8211a507-da5e-8504-a048-2ec86dbfbf4b@linux.intel.com>
 <1534985162.3235.50.camel@intel.com>
 <73a0095c-b58c-366b-424b-c2c518fd6f70@linux.intel.com>
 <1535049162.3323.5.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C94DD26773B
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2018 20:51:06 +0200 (CEST)
In-Reply-To: <1535049162.3323.5.camel@intel.com>
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
To: "Guedes, Andre" <andre.guedes@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Girdwood, Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>>> Every time aaf->timer_fd expires, the audio buffer is consumed
>>>>> by
>>>>> the
>>>>> plugin, making some room available on the buffer. So here a
>>>>> POLLIN
>>>>> event is returned so alsa-lib layer can copy more data into the
>>>>> audio
>>>>> buffer.
>>>>>
>>>>>> When there are two audio clock sources or timers that's
>>>>>> usually
>>>>>> where
>>>>>> the fun begins.
>>>>> Regarding scenarios with two audio clock sources or timers, the
>>>>> plugin
>>>>> doesn't support them at the moment. This is something we should
>>>>> work on
>>>>> once the basic functionality is pushed upstream.
>>>> I was talking about adjusting the relationship between your
>>>> CLOCK_REALTIME timer and the media/network clock. I don't quite
>>>> get
>>>> how
>>>> this happens, I vaguely recall there should be a daemon which
>>>> tracks
>>>> the
>>>> difference between local and media/network clock, and I don't see
>>>> it
>>>> here.
>>> Oh okay, I thought you were talking about something else :)
>>>
>>> I believe you are referring to the gptp daemon from Openavnu [1].
>>> The
>>> AAF plugin doesn't use it. Instead, it uses linuxptp [2] which is
>>> distributed by several Linux distros.
>>>
>>> Linuxptp provides the phc2sys daemon that synchronizes both system
>>> clock (i.e. CLOCK_REALTIME) and network clock (i.e. PTP clock). The
>>> daemon disciplines the clocks instead of providing the time
>>> difference
>>> to applications. So we don't need to do any cross-timestamping at
>>> the
>>> plugin.
>> Humm, I don't get this. The CLOCK_REALTIME is based on the local
>> oscillator + NTP updates. And the network clock isn't necessarily
>> owned
>> by the transmitter, so how do you adjust?
> When phc2sys is running, CLOCK_REALTIME is based on local oscillator +
> phc2sys updates. The daemon keeps adjusting CLOCK_REALTIME based on PTP
> clock via clock_adjtime syscall.
Is this a desirable "feature"? You may want to run other non-audio 
applications where the NTP clock makes sense, e.g. to know when your 
next call is, while playing audio on an external amp. Looks to me that 
you've simplified the problem too much, or this is for custom audio-only 
solutions. What am I missing?
