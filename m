From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
 for ML7213
Date: Fri, 25 May 2012 15:50:31 +0530
Message-ID: <1337941231.1580.19.camel@vkoul-udesk3>
References: <1331275160-31757-1-git-send-email-tomoya.rohm@gmail.com>
	<1332158459-14880-1-git-send-email-tomoya.rohm@gmail.com>
	<20120321160913.GF3226@opensource.wolfsonmicro.com>
	<CANKRQnjoGN=uvej8B1BxPHAx7NQtOORD9yJRPUc134DrVmPzNg@mail.gmail.com>
	<20120326154009.GA17506@sirena.org.uk>
	<CANKRQnhn=ALR0ucv5gnvwnxwxBQX4ajm9Jo5qC0fL-EFjDdoZg@mail.gmail.com>
	<20120523093857.GC4085@opensource.wolfsonmicro.com>
	<CANKRQnhNWC2F6zKgBMJY7HnipJbA5p-=6Lz4uGZqBKNQ688Z3w@mail.gmail.com>
	<20120524100742.GH5361@opensource.wolfsonmicro.com>
	<CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DFC910450A
	for <alsa-devel@alsa-project.org>;
	Fri, 25 May 2012 12:26:29 +0200 (CEST)
In-Reply-To: <CANKRQnj_LdGQPYPV7d5NNZBx8oM5aAGHu4qZidiiS6C4eNtNJQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-05-25 at 18:30 +0900, Tomoya MORINAGA wrote:
> On Thu, May 24, 2012 at 7:07 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> >> > Nobody seems to be working on it as far as I can tell, I've certainly
> >> > not seen any patches.
> >
> >> If so, could you accept current platform/machine driver ?
> >
> > Ideally what would be happening here is that you or other people who
> > have such systems would be working to add the required support to the
> > core code, there's clearly a need for common code here as there are a
> > number of different systems that don't have cyclic DMA and it wouldn't
> > be great to end up with duplicated code.
> >
> > Is there some great difficulty in factoring out the support for
> > non-cyclic audio DMA on dmaengine - it seems like if there is we must
> > have a serious problem in dmaengine which we should fix?  If there is a
> > substantial difficulty then that's different but it doesn't feel like
> > we've tried doing common code yet, if there's problems doing that I'd
> > like to understand what they are before we jump ahead of ourselves.
> 
> I'm not so familiar with Linux's DMA idea.
> So we don't know whether non-cyclic dmaengine has problem or not.
First you should not be writing your own dma driver, it *needs* to use
dmaenegine. We already have bunch of driver supported, so there may be a
case that existing driver works straight or with little modifications.
Using your own dma driver is a dead road, so sooner you move over better
it is.

One you move then it would be easy for you to use soc-dmaengine. If your
driver doesn't support cyclic; nothing stops from you emulating that in
S/W. And given that you have already contributed to dmaengine subsystem,
it should be easy for you :)
> 
> Until now, we've developed device drivers use DMA driver like UART, SPI.
> These drivers are  implemented using the same way, you called
> "non-cyclic", and already applied.
> 
> As you said, common code for DMA code can be best solution.
> However, currently, the code is nothing.
> So, I want you to accept our driver as first step.
> Because I think supporting new device is more important for linux than
> dmaengine common.
> 
> thanks


-- 
~Vinod
