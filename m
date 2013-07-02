From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Tue, 02 Jul 2013 07:50:16 +0200
Message-ID: <51D26A18.8040903@topic.nl>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob04.myregisteredsite.com
 (atl4mhob04.myregisteredsite.com [209.17.115.42])
 by alsa0.perex.cz (Postfix) with ESMTP id E01AA2652CF
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 07:50:18 +0200 (CEST)
Received: from mailpod.hostingplatform.com ([10.30.71.204])
 by atl4mhob04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r625oH3q004268
 for <alsa-devel@alsa-project.org>; Tue, 2 Jul 2013 01:50:17 -0400
In-Reply-To: <51D24A01.2050709@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joel Fernandes <joelf@ti.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 07/02/2013 05:33 AM, Joel Fernandes wrote:
> Hi Mike,
>
> On 07/01/2013 01:10 AM, Mike Looijmans wrote:
> [..]
>> The trouble with the current davinci driver is that the IRQ handler has a
>> real-time requirement, it must finish before the next DMA block completes. This
>
> I looked into this a little more.
>
> I think you are picturing the following:
>
> DMA transfer -> IRQ has to complete -> DMA transfer -> IRQ has to complete.. etc.
>
> This is not really true in the davinci-pcm driver, the normal case without IRAM
> works more like..
>
> DMA ----> DMA ---> DMA
>   \        \        \
>    \__ IRQ  \__ IRQ  \__ IRQ
>
> The only hard requirement is the IRQ handler much finish updating before the
> next DMA transfer, or we're in trouble. Is this what you mean by real-time
> requirement, or did you mean something else?


Yep, that's what I meant. Because I was capturing 16 channels of 32-bit 
data, the DMA buffer would drain in mere milliseconds. Interrupt latency 
on the L138 is pretty bad, I've seen it take over 10ms to handle an IRQ 
on occasion.

But even with much lower loads, I got underruns when recording to SD 
card that I couldn't really explain. I noticed that the SD transfers 
took up a lot of DMA params (about 40), so maybe that was just causing 
too much work for the IRQ or DMA handler routines.

> Either way I'm sure your multi-slot approach is superior, but I don't see how
> you can get away with not updating the DMA addresses on every IRQ with the
> current davinci-pcm or EDMA controller (Unless you use a complicated mechanism
> like ping-pong where the address updates take care of itself). If you are using
> a set of chained slots, you only have so many slots so you have to continuously
> change addresses of the slots at some point or the other for a large transfer.

I use a chain like this:

DMA1 -> DMA2 -> DMA... -> DMA1

This meant I had to use a DMA PARAM slot for every "period". The OMAP 
L138 has 128 of those slots, so it's no problem to use a bunch of them. 
Because the chain is cyclic, there is no need to update any DMA 
parameter while running. All that ALSA needs to do is empty the buffer 
before the cycle completes and the current position gets overwritten.

The IRQ handler is called after each DMA completion, but it's no problem 
if it isn't handled in time. It is only used to give the ALSA framework 
a gentle push that a period has been transferred. Completely missing a 
bunch of interrupts has no effect whatsoever.

>
> Thanks,
>

You're welcome.

Mike.
