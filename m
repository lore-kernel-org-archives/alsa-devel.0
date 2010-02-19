From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Latency of mixer reconfiguration
Date: Fri, 19 Feb 2010 10:01:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002190952310.28127@eeebox2.perex-int.cz>
References: <20100217181530.GA23152@tango.0pointer.de>
	<20100218100127.GJ2032@sirena.org.uk>
	<20100218180422.GA5606@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6842F1037EA
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 10:01:27 +0100 (CET)
In-Reply-To: <20100218180422.GA5606@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Feb 2010, Lennart Poettering wrote:

> On Thu, 18.02.10 10:01, Mark Brown (broonie@opensource.wolfsonmicro.com) wrote:
>
>>> Now the question I have is, how should I best deal with this? I
>>> currently assume that mixer volume changes are basically instantaneous
>>> when I call the respective function of ALSA. But are they really? How
>>> big is the latency at max? Do we need an API to query it?
>>
>> For the embedded case the hardware update should happen synchronously
>> with the ALSA API call to adjust the setting and begin affecting the
>> played audio instantaneously.  The time taken to do the hardware update
>> will be dominated by I/O costs, which will in turn depend on the bus
>> used to access the codec - it'd be good if the buses could provide some
>> information to ASoC to allow it to do an estimate, but at the minute
>> we've got nothing really to go on.
>
> But what would you guess? In which range will this most likely be? < 1ms?
> 1ms? 10ms? 100ms? 1s? 1h? 10h? 10d? 10y?

Some drivers uses a queue (like HDA) for serial bus to update the audio 
mixer registers. But anyway, the real write should take several ms for 
maximum (maybe more on USB bus).

> tbh I feared less the actually IO latency but more that some PCM data
> fifos might need flushing before the volume is actually updated. And
> the latency of those fifos I feared might be more than a handful of
> samples?

It's quite complex question and probably only hardware vendors knows 
these internals for all devices. I guess also, that some devices also uses 
volume ramping to avoid clicks.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
