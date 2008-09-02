From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASOC: WM8731 codec: add SPI support	as
	well as I2C
Date: Tue, 2 Sep 2008 13:27:01 +0100
Message-ID: <20080902122700.GA32100@rakim.wolfsonmicro.main>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<200809011452.08070.gineera@aspect135.co.uk>
	<20080901140227.GA17103@rakim.wolfsonmicro.main>
	<200809021122.23012.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D07C246A6
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 14:27:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809021122.23012.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Liam Girdwood <lg@opensource.wolfsonmicro.com>, Bryan Wu <cooloney@kernel.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 02, 2008 at 11:22:23AM +0100, Alan Horstmann wrote:
> On Monday 01 September 2008 15:02, you wrote:

> > I've reworked the patch to allow a single kernel image to support both
> > I2C and SPI which sidesteps this problem.  I'll post this later today.

> I am aware am new to the asoc stuff, and hesitate to comment, but it would 
> seem to me that Liams suggestion:

> > It may be simpler to only have CONFIG_SND_SOC_WM8731_SPI and
> > CONFIG_SND_SOC_WM8731_I2C definitions for all the codec drivers. These
> > would be set by machine Kconfig.

> is better, since it means one or the other, or both sets of code can be built.  
> Since in most applications the hardware is always wired up on a known bus, it 
> avoids unused code built in.  Otherwise we would have to hand edit out 
> sections of code.  (CONFIG_I2C) may be set because of other devices on that 

Given the very small amount of code involved in attaching the codec to
SPI or I2C I wasn't too worried about the additional cost in the driver
itself if the kernel already contains all the bus code.  That said, I do
agree that it could be useful to have ths level of control and I'd
certainly ack a patch which added it.

Note that the drivers will still need to support both simultaneously in
order to allow support for multiple boards in a single kernel image
(which was the main problem with the original patch).  There's quite a
push to reduce the number of builds required to get coverage on ARM at
the minute partly since it is useful for distributions and partly
because it facilitates architecture wide development.

> bus.  Does the codec ONLY work in spi master?

The SPI_MASTER config option refers to the controller rather than the
target - if there is nothing able to act as a SPI master then nothing
will be able to control the codec.

> Then (CONFIG_SND_SOC_WM8731) is not really needed since it is

> CONFIG_SND_SOC_WM8731_I2C || CONFIG_SND_SOC_WM8731_SPI

> Essentially, where a hardware device can be connected in different ways 
> needing different code, a config option for each way is needed, rather than 
> being guessed from bus config options.

I'm not sure I'd go so far as *needed* - it's useful for modular kernels
where both I2C and SPI are availaible but one or the other is not loaded
in some configurations so you end up pulling the bus core in.
