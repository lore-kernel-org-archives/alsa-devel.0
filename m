From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Tue, 02 Jul 2013 15:40:12 +0200
Message-ID: <51D2D83C.4050507@topic.nl>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <20130702121345.GL27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob06.myregisteredsite.com
 (atl4mhob06.myregisteredsite.com [209.17.115.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 979F826547C
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 15:40:14 +0200 (CEST)
Received: from mailpod.hostingplatform.com ([10.30.71.208])
 by atl4mhob06.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r62DeDtr018955
 for <alsa-devel@alsa-project.org>; Tue, 2 Jul 2013 09:40:13 -0400
In-Reply-To: <20130702121345.GL27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 07/02/2013 02:13 PM, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 07:50:16AM +0200, Mike Looijmans wrote:
>> On 07/02/2013 05:33 AM, Joel Fernandes wrote:
>
>> But even with much lower loads, I got underruns when recording to SD
>> card that I couldn't really explain. I noticed that the SD transfers
>> took up a lot of DMA params (about 40), so maybe that was just
>> causing too much work for the IRQ or DMA handler routines.
>
> SD cards are generally just slow, it's possible it's just not able to
> keep up with the data you're throwing at it.  Things like batching the
> writes up into large chunks can help here but you may just be hitting a
> genuine limit if you need to record for too long and don't have enough
> fast storage (like RAM) to buffer.

What i meant by "couldn't really explain" is that I monitored CPU, 
memory and IO, and could clearly conclude that the card (or network, or 
even /dev/null on occasion) wasn't the bottleneck in itself. It's not so 
much the medium, but more the load it causes on the system that 
triggered the overruns.

>> This meant I had to use a DMA PARAM slot for every "period". The
>> OMAP L138 has 128 of those slots, so it's no problem to use a bunch
>> of them. Because the chain is cyclic, there is no need to update any
>> DMA parameter while running. All that ALSA needs to do is empty the
>> buffer before the cycle completes and the current position gets
>> overwritten.
>
> This sort of cyclic thing tends to be best, ideally you don't need
> interrupts at all (other than a timer).

Indeed. In this case, the DMA completion IRQ is still useful because the 
DMA controller issues it after the "period" data has been transferred 
completely. Just monitoring the DMA registers will tell which data is 
currently being transferred, but you can't be sure that it has actually 
been committed. So if the DMA pointer is now at 0x0100, you cannot be 
sure whether the data at 0x0100 is already valid, or even the data at 
0x0098, because that might still be in the controller's queue. The 
pointer increments when the request is sent to the queue, but there's no 
guarantee as to when the queue will actually be executed, because other 
transactions may have higher priority.

Mike.
