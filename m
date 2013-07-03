From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Wed, 03 Jul 2013 15:17:19 +0200
Message-ID: <51D4245F.8070307@topic.nl>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <20130702121345.GL27646@sirena.org.uk> <51D3EA42.3040205@metafoo.de>
 <20130703094307.GE27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob08.myregisteredsite.com
 (atl4mhob08.myregisteredsite.com [209.17.115.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E28EF2655A6
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 15:17:22 +0200 (CEST)
Received: from mailpod.hostingplatform.com ([10.30.71.210])
 by atl4mhob08.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r63DHLVb028374
 for <alsa-devel@alsa-project.org>; Wed, 3 Jul 2013 09:17:21 -0400
In-Reply-To: <20130703094307.GE27646@sirena.org.uk>
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
Cc: Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On 07/03/2013 11:43 AM, Mark Brown wrote:
> On Wed, Jul 03, 2013 at 11:09:22AM +0200, Lars-Peter Clausen wrote:
>> On 07/02/2013 02:13 PM, Mark Brown wrote:
>
>>> This sort of cyclic thing tends to be best, ideally you don't need
>>> interrupts at all (other than a timer).
>
>> Yes, this is usually how it is done. But I'm wondering maybe the EDMA
>> controller only has a small total amount of slots available.
>
> Well, you don't need particularly many slots so long as you can cope
> with a large period size.

On the OMAP L138, there are 128 PARAM slots. 32 of those are tied to 
hardware events (though you can use them if you aren't using the related 
hardware, for example the UART drivers don't use DMA so you can freely 
use those slots if you want), leaving (at least) 96 PARAM slots free. 
Both audio events are on the same controller, so you can't use the 128 
of the other one (the OMAP has 2 EDMA controllers). Only a few dozen of 
those are being used by various drivers, the SD card driver being the 
most hungry.
For the system to work, you can even get away with only using one slot, 
and hence one period, but then you'll have to use a mmap and a timer to 
fill it.

I experimented with various memory layouts. For large transfers, using 2 
big periods was quite enough. I also tested with very small period 
sizes. Using the original code, I was unable to reliably capture (to 
/dev/null) at period sizes below 80 samples. With the cyclic DMA, I 
could set a period size of only 40 samples and still be able to record 
audio reliably, when using only 8 periods. The same for playback, 
basically. So that's how I arrived at the MAX_PERIODS define of "8". It 
will only claim channels when you use them, so setting it to say "100" 
will not crash the system.

The period size is limited by the EDMA parameter set. It can only 
transfer 64k-1 "words" per slot. You can (and should!) use the McASP 
FIFO buffer to increase the word size, thus allowing for period sizes in 
the megabyte range.

M.
