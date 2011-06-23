From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: PCM DMA only can fire ISR when it receives 4
 samples more than the period, from McBSP port?
Date: Thu, 23 Jun 2011 09:50:13 +0300
Message-ID: <20110623095013.6210474d.jhnikula@gmail.com>
References: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D531@EDPREX01.logicpd.com>
	<20110622100516.92cc3e95.jhnikula@gmail.com>
	<0520A3FE5EDCF24F88B3F1451CFC64AE042818D93C@EDPREX01.logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 924DB103AB0
	for <Alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 08:50:11 +0200 (CEST)
Received: by bwz10 with SMTP id 10so1443612bwz.38
	for <Alsa-devel@alsa-project.org>; Wed, 22 Jun 2011 23:50:11 -0700 (PDT)
In-Reply-To: <0520A3FE5EDCF24F88B3F1451CFC64AE042818D93C@EDPREX01.logicpd.com>
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

On Wed, 22 Jun 2011 10:26:28 -0500
Philip Chu <Philip.Chu@logicpd.com> wrote:

> Thanks for your help.
> 
> How big is the chance that McBSP will have samples remaining in its shift registers, not to its FIFO until next time it receives new data samples?

I suppose none if McBSP framesize (wlen * channels) number of bitclock 
cycles (+ possible 1-bit data delay) are received after framesync.

> My PCM DMA is running in element mode so it sets up FIFO threshold as 1 (0 in the register). That means FIFO should pass the data as long as it sees them coming.
> 
> Before the very first DMA ISR (completed a period of data transfer by DMA), the DMA pointer is a void number, I think it means DMA has not ever completed one entire period transfer yet. My suspection is, does DMA need some time to be ready for receiving data from McBSP's DMA event? If it does need some time, then the very first a couple of sample(s) from McBSP could be missed.
> 
Indeed, this is actually strange that DMA pointer is not updated. How
big is your period size? Is it smaller than DMA burst size which is set
to 64 bytes in sound/soc/omap/omap-pcm.c? I'm not sure does the DMA use
burst transfer in element mode but non-updating pointer is kind of
indicating that there is neither DMA transfer going on until enough
data is received.


-- 
Jarkko
