From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Question on HW Pointer
Date: Wed, 06 Oct 2010 20:15:46 +1300
Message-ID: <4CAC2222.6090903@audioscience.com>
References: <001201cb64ee$5beec5c0$13cc5140$@fl-eng.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 2876310395C
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Oct 2010 09:15:51 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0L9U00B9BXIARA10@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 06 Oct 2010 20:15:47 +1300 (NZDT)
In-reply-to: <001201cb64ee$5beec5c0$13cc5140$@fl-eng.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Spano <steve@fl-eng.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Steve,

the usual refrain is "show us the code" - please do so, as it is much
easier to see the details of where you may be going wrong.

Also can you describe in a bit more detail how your DMA engine behaves.


On 06/10/10 13:35, Steve Spano wrote:
> Step #1 ) interrupt occurs
> 
> Step #2) dma/transfer begins as kicked off in interrupt routine
> 
> Step #3) we advance the buffer pointer for the alsa buffer
> 
> Step #4) we exit the interrupt
> 
> . then the hardware should start advancing its pointer as it is reading the
> new samples
> 
> .. then sometime later, the alsa layer calls the "hw_pointer" function

0) ALSA puts some data in the dma buffer, probably at least 2 periods.

1) In trigger callback,case SNDRV_PCM_TRIGGER_START kick off dma,
assuming for now that the DMA free-runs around the buffer forever,
the buffer size is >= 2 periods,
and your hardware can interrupt every time the DMA has transferred one
period.

2) later, in interrupt, call period_elapsed (assuming it has!)
this lets ALSA midlevel know that one period worth of the buffered data
has been consumed, and free to be written with new data.

> And then we return the current value of the hardware pointer from the board?
> So alsa knows how many samples the board has processed from the interrupt?

If you can read the exact read pointer position from your DMA engine,
then use that in the pointer callback.
(Be sure to convert to frames first),
otherwise, in your interrupt routine keep track of where the DMA has
read and use that.

> We should be pretty close, because it is working for the most part..but I
> think this pointer is not right. 
> 
> Can someone explain how this pointer/etc is supposed to flow and what alsa
> may be using it for? Maybe some latency calculation in a an upper layer?


-- 
Eliot Blennerhassett
AudioScience Inc.
