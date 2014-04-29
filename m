From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Control the exact moment of output
Date: Tue, 29 Apr 2014 09:50:53 +0200
Message-ID: <535F59DD.2080207@ladisch.de>
References: <5352BEA0.3050807@amsat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 44DCD2625FD
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 09:50:54 +0200 (CEST)
In-Reply-To: <5352BEA0.3050807@amsat.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Janssen <pe1chl@amsat.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Janssen wrote:
> For a distributed system that requires synchronized output I would like to determine
> the exact moment when output samples are sent, preferably within +/- 1 sample time.
>
> Is this possible within the ALSA API?

In theory, yes; snd_pcm_delay() should take these latencies into account.

In practice, there is no hardware where this value is accurate.  Drivers with
large latencies (e.g., USB) report their internal queues, but nobody bothers
for the small delays (about 10 samples) in the DMA controllers and DACs.

> Are some types of soundcard more suitable than others for this purpose?

PCI(e) cards have lower latencies, but if you configure two USB devices
with the same parameters, the driver's queues will have the same length.

> And are there soundcards available where the sample clock can somehow be
> locked to system time or an external 10MHz/1PPS reference?

Some cards can be locked to an S/PDIF input or to a word clock from another
sound card.  This does not work for physically separated outputs; you'd have
to measure the clock differences and do dynamic resampling.


Regards,
Clemens
