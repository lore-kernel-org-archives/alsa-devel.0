From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: Control the exact moment of output
Date: Wed, 30 Apr 2014 16:43:26 +1000 (EST)
Message-ID: <51940.86.107.254.57.1398840206.squirrel@boosthardware.com>
References: <5352BEA0.3050807@amsat.org> <535F59DD.2080207@ladisch.de>
 <535F61EC.9070003@amsat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E69C2651BC
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 08:42:21 +0200 (CEST)
In-Reply-To: <535F61EC.9070003@amsat.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Tue, April 29, 2014 6:25 pm, Rob Janssen wrote:
> Clemens Ladisch wrote:
>> Rob Janssen wrote:
>>> For a distributed system that requires synchronized output I would like
>>> to determine
>>> the exact moment when output samples are sent, preferably within +/- 1
>>> sample time.
>>>
>>> Is this possible within the ALSA API?
>> In theory, yes; snd_pcm_delay() should take these latencies into
>> account.
>>
>> In practice, there is no hardware where this value is accurate.  Drivers
>> with
>> large latencies (e.g., USB) report their internal queues, but nobody
>> bothers
>> for the small delays (about 10 samples) in the DMA controllers and DACs.
> Ok, thanks for the reply!
> We will use PCI soundcards, not USB dongles, and it is not a problem when
> there is a fixed extra delay
> that is the same for all the systems.  What we need to control is the
> synchronization between
> the physically separated systems, and my approach up to now is to do this
> by synchronizing
> to the very precise system time derived from GPS.
>
> I was thinking along the line of an API feature where one can send frames
> with a related moment
> of playback, but now I realize that what I should do is calculate how far
> off the desired playback
> moment we are (using the current system time, the desired playback time,
> and the snd_pcm_delay)
> for each block, and then pad or trim some frames as required before
> sending the block.
> Is that correct?
>
>>
>>> And are there soundcards available where the sample clock can somehow
>>> be
>>> locked to system time or an external 10MHz/1PPS reference?
>> Some cards can be locked to an S/PDIF input or to a word clock from
>> another
>> sound card.  This does not work for physically separated outputs; you'd
>> have
>> to measure the clock differences and do dynamic resampling.
>>
> We would have to generate a word clock or S/PDIF signal from the
> 10MHz/1PPS we have available
> from the GPS (which are synchronous on all the sites).   That will be the
> next step when the first
> approximation does not yield us enough perfection.
>

Have you looked into netjack?

Several of the network timing issues have been worked through quite
extensively. We have used it to distribute data across several machines in
a cluster and find it to be very stable and workable with acceptable
latency over gigbit lan.

You might find netjack gives you a good headstart on this project.

Adding support for JACK is a minor task compared to rewriting (and
testing) netjack.  You will also gain access to a host of other
professional functionality and ALSA, OSS, FIrewire support too.

In addition your software will play nice with other professional software
and have direct access to data on the JACK graph as a bonus.




--
Patrick Shirkey
Boost Hardware Ltd
