From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 3 Feb 2010 22:52:16 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1002032005330.3125@ecabase.localdomain>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
	<6160a5131002011440p52fb1b2dv9d077681544adb8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 6332D10383A
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 21:55:50 +0100 (CET)
In-Reply-To: <6160a5131002011440p52fb1b2dv9d077681544adb8c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

me again..

On Mon, 1 Feb 2010, pl bossart wrote:

>> In other words - for hardware with large FIFOs, the runtime->delay should be
>> used for queued samples and the hw_ptr in the ring buffer should be
>> increased as soon as the FIFO is filled with samples from the ring buffer.
[...]
> - the 'only' change is to make sure the hw_ptr reported in .pointer is
> NOT the number of samples pushed out to the interface. hw_ptr should

although, I'm not entirely sure this still makes rewinds fully safe. After 
driver has called period elapsed and hw_ptr jumps ahead one period worth 
of samples, the DMA for the next burst/batch is already programmed and 
possibly ongoing. And with some drivers the burst size (of a single DMA 
transaction) may be fairly large, while some transfer sample at a time, at 
codec rate.

This might lead to undefined behaviour when application rewinds upto 
hw_ptr and starts to refill the segment of the ringbuffer just after 
hw_ptr, while at the same time DMA engine is already transferring data out 
of that same ringbuffer segment.

So a safer bet would be to limit rewinds to hw_ptr+X, where X is highly 
driver/hw specific. At the minimum, 'X >= dma_get_cache_alignment()' (see 
linux/Documentation/DMA-API.txt) to get deterministic results on different 
platforms. A sane convervative assumption is 'X >= period-size'.
