From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: need help with io plugin programming: how to add
 delay ?
Date: Wed, 23 Dec 2009 12:17:59 +0100
Message-ID: <4B31FC67.2090201@gmail.com>
References: <4B312435.800@gmail.com> <4B315163.5090404@gmail.com>	
	<53baa24a0912221814t3e8628c4odc908c0813c0a56b@mail.gmail.com>	
	<4B31D184.3020300@gmail.com>
	<53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id CA3081037FE
	for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2009 12:18:07 +0100 (CET)
In-Reply-To: <53baa24a0912230128p5fee628en39b7b81f45e9fb9c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Austin <circuitsoft.alex@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Alex Austin wrote:
> The simplest solution would probably be completely userspace. Write a
> jackd client which connects to the UART, gives itself RT priority using
> capabilities, and exposes however many input/output ports as you have.
> Google FFADO for an example of the programming model used.

Just before starting to write yet another implementation
(the fourth one, this time with jack) I was wondering if the
following criteria are met:

* does this work on embedded arm on an arm9 AT91 cpu running at 180MHz ?
* Has jack been ported to arm EABI ?
* Can I add a serial protocol if I decide to to use jack ?

* Can I use serial port hardware flow control with it ?
  The Jack application would need to be aware of the UART
   and the pipeline fill state of the DSP.
  (The DSP wants to have 160 audio samples exactly each 20ms)

* Is there a bluetooth jack client (as is does a similar job compared to my application) ?


> If you need normal apps to drive into it, set up an .asoundrc with a
> device using the jack plugin. I still don't see why you need a kernel
> driver at all.

The previous three solutions I implemented were all in userspace as they consisted
of an (userspace) alsa ioplugin and some deamon that processes
the data coming from/going to alsa.
I never wrote kernel code to solve this.

If I chose to use jack now it means a complete rewrite of all my previous solutions.
I will have to start from scratch (again) and all the work I have done in the last month
would we useless :(


Just to make sure that jack is the right choice for this I thought I
give you some more insight of my design.

Basically it should be possible to use any source and sink with my application.
For example this could be a microphone and a headphone,
but it could also be some prerecorded wav file.
The audio format should be 8kHz 16bit and the
whole thing is running on an arm9 AT91 board.

Then there is this DSP board that does does speech compression.
It is connected over UART at 460800 baud and requires exactly 160 16bit PCM samples
with 8kHz sampling rate each 20ms for speech compression.
At the same time it also sends 160 PCM samples each 20ms (speech decompression).
It uses a simple protocol for this and all data is exchanged in
a protocol consisting of packets including a header.
Besides with the same protocol (also each 20ms) the compressed speech packets
go in and out.
For this reason not only the uncompressed PCM samples need to be exchanged
on time but also the compressed packets need to be handled timely.


Thus in the end one could for example talk in the microphone and
real-time speech compression would be performed so that the compressed speech comes
out of my application.
At the same time on should hear the decompressed speech coming from the DSP in the headphones.

Now that you know the gory details, do you think that jack is the
best and simplest solution for this problem ?

I really hope that this is the last solution I'm going to implement as I
already implemented three previous solutions that took a lot of time but
do not work satisfactory.

thanks for helping,
cheers,
stefan
