From: Joel Fernandes <joelf@ti.com>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Tue, 13 Aug 2013 23:30:54 -0500
Message-ID: <520B07FE.6060006@ti.com>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A8B41265383
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 06:47:39 +0200 (CEST)
In-Reply-To: <51D26A18.8040903@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

Hi Mike,

On 07/02/2013 12:50 AM, Mike Looijmans wrote:
[..]
> 
>> Either way I'm sure your multi-slot approach is superior, but I don't
>> see how
>> you can get away with not updating the DMA addresses on every IRQ with
>> the
>> current davinci-pcm or EDMA controller (Unless you use a complicated
>> mechanism
>> like ping-pong where the address updates take care of itself). If you
>> are using
>> a set of chained slots, you only have so many slots so you have to
>> continuously
>> change addresses of the slots at some point or the other for a large
>> transfer.
> 
> I use a chain like this:
> 
> DMA1 -> DMA2 -> DMA... -> DMA1
> 
> This meant I had to use a DMA PARAM slot for every "period". The OMAP
> L138 has 128 of those slots, so it's no problem to use a bunch of them.
> Because the chain is cyclic, there is no need to update any DMA
> parameter while running. All that ALSA needs to do is empty the buffer
> before the cycle completes and the current position gets overwritten.

Replying to this thread after a long time but just wondering, how do you
guarantee in your implementation that DMA will not empty the buffer
faster than it is filled?

Thanks,

-Joel
