From: flaxma@nal.gov.au
Subject: Re: laptop multichannel ethernet OR PCMCIA sound cards
Date: Thu, 2 Jul 2009 08:18:16 +1000
Message-ID: <1a1fefe78f92c38beb5a8185afb3bad5.squirrel@sonic.nal.gov.au>
References: <1246420893.7599.7.camel@flatmax>
	<4A4B394E.7090707@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sonic.nal.gov.au (sonic.nal.gov.au [203.6.243.10])
	by alsa0.perex.cz (Postfix) with SMTP id B880124402
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 00:18:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sonic.nal.gov.au (Postfix) with ESMTP id D40072360078
	for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2009 08:18:16 +1000 (EST)
Received: from sonic.nal.gov.au ([127.0.0.1])
	by localhost (sonic.nal.gov.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YodSJFDyGnmz for <alsa-devel@alsa-project.org>;
	Thu,  2 Jul 2009 08:18:16 +1000 (EST)
Received: from sonic.nal.gov.au (localhost [127.0.0.1])
	by sonic.nal.gov.au (Postfix) with ESMTP id 4BBA02360057
	for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2009 08:18:16 +1000 (EST)
In-Reply-To: <4A4B394E.7090707@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI, yes

A little more background ... we are implementing research algorithms for
hearing aids ... so ... we have many mic inputs and stereo output ...

we want a digital interface to the laptop.

Need 6 analog inputs
Need 2 analog outputs

Need minimal latency both in and out as it is a collect/process/output
system.

Sample rates anything between 22050 Hz and 48 kHz is good at this point.

At the moment we can get about 3 ms with an off the shelf firewire/usb card
 @ 48 kHz, however when we load the CPU with DSP algorithms, we sometimes
need to bump up the frame size and thus the latency goes up ...
We are running a realtime patched kernel.

I have found that there is about 2/3 of the latency in hardware buffers.

So we are still open to better USB/Firewire hardware, however would prefer
more bandwidth and hopefully less latency to the device. This is why I
asked about ethernet and possible PCMCIA.

Matt

> Matt Flax wrote:
>> We are after an ultra low latency connection to a multichannel in/out
>> sound card for a laptop. We want a portable system and don't want to
>> network to a different computer to achieve this goal.
>>
>> As we are after ultra low latency, we are interested in both PCMCIA and
>> ethernet (gigabit) solutions.
>>
>> Is anyone aware of any such ultra low latency hardware ?
>
> Can you define what you require.
>
> Do you want analog or digital audio I/O?
>
> Do you need low latency in, out or both?
>
> What samplerates do you need?
>
> What latency would be acceptable (say how many milliseconds or
> microseconds).
>
> regards
>
> Eliot
>
>
>
>
