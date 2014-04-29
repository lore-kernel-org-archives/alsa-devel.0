From: Rob Janssen <pe1chl@amsat.org>
Subject: Re: Control the exact moment of output
Date: Tue, 29 Apr 2014 10:25:16 +0200
Message-ID: <535F61EC.9070003@amsat.org>
References: <5352BEA0.3050807@amsat.org> <535F59DD.2080207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pe1chl.nl.eu.org (pe1chl.nl.eu.org [89.18.172.156])
 by alsa0.perex.cz (Postfix) with ESMTP id 875EB2625FD
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 10:25:19 +0200 (CEST)
Received: from linux.pe1chl.ampr.org (linux.pe1chl.ampr.org [44.137.41.97])
 by sys2.pe1chl.ampr.org (8.14.4/8.14.4/Debian-4) with ESMTP id s3T8PIq8028991
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 10:25:19 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by linux.pe1chl.ampr.org (8.14.7/8.14.7) with ESMTP id s3T8PG7M012203
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 10:25:17 +0200
In-Reply-To: <535F59DD.2080207@ladisch.de>
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

Clemens Ladisch wrote:
> Rob Janssen wrote:
>> For a distributed system that requires synchronized output I would like to determine
>> the exact moment when output samples are sent, preferably within +/- 1 sample time.
>>
>> Is this possible within the ALSA API?
> In theory, yes; snd_pcm_delay() should take these latencies into account.
>
> In practice, there is no hardware where this value is accurate.  Drivers with
> large latencies (e.g., USB) report their internal queues, but nobody bothers
> for the small delays (about 10 samples) in the DMA controllers and DACs.
Ok, thanks for the reply!
We will use PCI soundcards, not USB dongles, and it is not a problem when there is a fixed extra delay
that is the same for all the systems.  What we need to control is the synchronization between
the physically separated systems, and my approach up to now is to do this by synchronizing
to the very precise system time derived from GPS.

I was thinking along the line of an API feature where one can send frames with a related moment
of playback, but now I realize that what I should do is calculate how far off the desired playback
moment we are (using the current system time, the desired playback time, and the snd_pcm_delay)
for each block, and then pad or trim some frames as required before sending the block.
Is that correct?

>
>> And are there soundcards available where the sample clock can somehow be
>> locked to system time or an external 10MHz/1PPS reference?
> Some cards can be locked to an S/PDIF input or to a word clock from another
> sound card.  This does not work for physically separated outputs; you'd have
> to measure the clock differences and do dynamic resampling.
>
We would have to generate a word clock or S/PDIF signal from the 10MHz/1PPS we have available
from the GPS (which are synchronous on all the sites).   That will be the next step when the first
approximation does not yield us enough perfection.

Rob
