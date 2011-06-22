From: Philip Chu <Philip.Chu@logicpd.com>
Subject: Re: PCM DMA only can fire ISR when it receives 4
 samples more than the period, from McBSP port?
Date: Wed, 22 Jun 2011 10:26:28 -0500
Message-ID: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D93C@EDPREX01.logicpd.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D531@EDPREX01.logicpd.com>
	<20110622100516.92cc3e95.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.logicpd.com (smtp.logicpd.com [174.46.170.145])
	by alsa0.perex.cz (Postfix) with ESMTP id A9C1C103804
	for <Alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 17:26:32 +0200 (CEST)
In-Reply-To: <20110622100516.92cc3e95.jhnikula@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks for your help.

How big is the chance that McBSP will have samples remaining in its shift registers, not to its FIFO until next time it receives new data samples?
My PCM DMA is running in element mode so it sets up FIFO threshold as 1 (0 in the register). That means FIFO should pass the data as long as it sees them coming.

Before the very first DMA ISR (completed a period of data transfer by DMA), the DMA pointer is a void number, I think it means DMA has not ever completed one entire period transfer yet. My suspection is, does DMA need some time to be ready for receiving data from McBSP's DMA event? If it does need some time, then the very first a couple of sample(s) from McBSP could be missed.

And I think Frame Sync has to be a little later compared to the bit clock, but it should be only responsible for missing 1 samples in my case, because all my clock signals look to kick in at the same moment.


Thanks,
Philip


-----Original Message-----
From: Jarkko Nikula [mailto:jhnikula@gmail.com] 
Sent: Wednesday, June 22, 2011 3:05 AM
To: Philip Chu
Cc: Alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] PCM DMA only can fire ISR when it receives 4 samples more than the period, from McBSP port?

On Wed, 22 Jun 2011 00:04:43 -0500
Philip Chu <Philip.Chu@logicpd.com> wrote:

> HI,
> 
> I got a problem with my audio capture using McBSP 3 port on OMAP 3530. Linux kernel 2.6.32.
> For the very first audio data capture, when I expect to receive only one exact period of data through McBSP, PCM DMA ISR never comes. When I check the DMA pointer by using snd_pcm_update_hw_ptr_pos(), I found it was just trash value. If I ask the data sender to send 4 samples more than the period defined, DMA ISR gets fired, the it points to the exact period position, and I assume the extra 4 bytes just get lost?
> 
> My McBSP is configured as a slave which needs the sender to provide Frame Sync, clocks etc, and those signals are designed to just kick in at the same time. Do the clock signal need to be present earlier than the Frame Sync?
> 
> Anybody knows what the issue could be?
> 
Sounds like the last sample(s) may stay in McBSP receive shift register
and they get copied to receive buffer and forward only until the
receiver is running again.

I'm thinking is this missing interrupt due missing first sample. Do you
receive it and does the received data look correct?

It could be that the McBSP expects a stable bit-clock before frame-sync
until it starts to receive data into shift register. I'm not sure about
this.

Another reason could be that the DAI format is not correct. I.e. if
the transmitter has 0-bit data delay after frame-sync but McBSP is
configured for 1-bit so 1 bit is missing from shift register when the
transmission ends. But then just a single bit-clock cycle, not the full
word should kick the data forward and DMA ISR should occur.

-- 
Jarkko
