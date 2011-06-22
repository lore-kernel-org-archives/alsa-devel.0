From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: PCM DMA only can fire ISR when it receives 4
 samples more than the period, from McBSP port?
Date: Wed, 22 Jun 2011 10:05:16 +0300
Message-ID: <20110622100516.92cc3e95.jhnikula@gmail.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D531@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 535F724521
	for <Alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 09:05:19 +0200 (CEST)
Received: by bwz10 with SMTP id 10so561530bwz.38
	for <Alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 00:05:18 -0700 (PDT)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D531@EDPREX01.logicpd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philip Chu <Philip.Chu@logicpd.com>
Cc: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

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
