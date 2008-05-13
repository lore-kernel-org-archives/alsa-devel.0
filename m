From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ARM S3C2410: Trigger start problems
Date: Tue, 13 May 2008 13:37:30 +0100
Message-ID: <20080513123719.GB21292@sirena.org.uk>
References: <482696BE.7080406@elpa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EA9F24AF6
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:12:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <482696BE.7080406@elpa.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ing. Davide Rizzo" <davide@elpa.it>
Cc: alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 11, 2008 at 08:48:30AM +0200, ing. Davide Rizzo wrote:

CCing in Ben, the S3C2410 maintainer (and not snipping any context as a
result).

> I experienced a curious problem.
> My platform is a S3C2410 with a PCM3006 codec connected through I2S.
> The soc trigger function calls 3 other triggers functions:
> - first the codec function
> - then the platform function (that starts dma)
> - last the the i2s trigger function (that starts i2s peripheral).

> The dma start function programs and starts the dma peripheral, but the 
> transfer doesn't start because the i2s peripheral isn't started yet.
> The s3c2410 specific dma start programs the 1st transfer, but before 
> programming the 2nd start it waits about 30ms (2^18 count) in a closed 
> loop for 1st transfer to start. After that delay anyway it fails to 
> program the 2nd transfer.

Are you talking about s3c2410_dma_waitforload() here?

> After that, when the i2s trigger function is called the 1st samples' 
> group starts, but nobody preprograms the 2nd sample group in the dma 
> peripheral. When the 1st group ends the dma interrupt service routine is 
> called , but it's too late and the 1st samples' group is repeated twice.

Right, and the previous attempt to do so in dma_waitforload() failed.
My immediate thought here is that at least for I2S it would probably be
very much simpler if the I2S driver were responsible for kicking off the 
DMA.  That seems to be more what the hardware is looking for here.

> I tested 2 solutions:
> - In the soc trigger function, call the i2s trigger function BEFORE the 
> platform trigger function. I don't know if this solution could broke 
> other platforms, but it's the more correct way to solve the problem.

Hrm.  Even for s3c24xx I can't immediately convince myself that this is
entirely safe: when I2S is started it does timing sensitive things like
synchronise with LRCLK from the codec in slave mode.  In general, what's
going on here is that devices need to have DMA ready to go before they
can start to work on their external bus - without data they may stop
entirely or underrun.

Note that platforms are free to ignore any or all of the trigger
functions and to have the DAI and DMA drivers cooperate with each other
if they need to.

> -  (platform specific): In arch/arm/plat-s3c24xx-dma.c, at the end of 
> s3c2410_dma_getposition() function, insert a call to 
> s3c2410_dma_started(). That function is periodically called by alsa-lib 
> when playing, and permits dma to program the 2nd buffer before (but it's 
> not guaranteed) the 1st group is completed. With this solution, the 
> programming of DMA till waits for the closed loop. I think this is a 
> patch, but not the correct solution.

Looking at the code it does appear to already be making an effort to
ensure that there are multiple buffers queued up with the DMA code in
order to avoid underruns: s3c24xx_pcm_enqueue() in s3c24xx-pcm.c will
give the DMA code up to the number of buffers in periods_min, which
appears to default to 2.  I suspect that if the problem with the busy
wait is fixed then this will also be fixed.

> I wonder if other architectures that use DMA suffer the same problem, so 
> that the 1st proposed solution could help them, too.
