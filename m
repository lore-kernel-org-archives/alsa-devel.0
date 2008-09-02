From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 3/4] ASOC: WM8731 codec: add SPI support as
	well as I2C
Date: Tue, 2 Sep 2008 11:22:23 +0100
Message-ID: <200809021122.23012.gineera@aspect135.co.uk>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<200809011452.08070.gineera@aspect135.co.uk>
	<20080901140227.GA17103@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-1.talktalk.net [62.24.128.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 958F4103813
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 12:16:55 +0200 (CEST)
In-Reply-To: <20080901140227.GA17103@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Bryan Wu <cooloney@kernel.org>, Liam Girdwood <lg@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Monday 01 September 2008 15:02, you wrote:
> On Mon, Sep 01, 2008 at 02:52:08PM +0100, Alan Horstmann wrote:
> > in order to force use of SPI when (CONFIG_SND_SOC_WM8731_SPI) and
> > (CONFIG_I2C) are both defined.  Or have we misunderstood the intention? 
> > This is in 2 other places also in the patch.
>
> I've reworked the patch to allow a single kernel image to support both
> I2C and SPI which sidesteps this problem.  I'll post this later today.

I am aware am new to the asoc stuff, and hesitate to comment, but it would 
seem to me that Liams suggestion:

> It may be simpler to only have CONFIG_SND_SOC_WM8731_SPI and
> CONFIG_SND_SOC_WM8731_I2C definitions for all the codec drivers. These
> would be set by machine Kconfig.
>
> Liam

is better, since it means one or the other, or both sets of code can be built.  
Since in most applications the hardware is always wired up on a known bus, it 
avoids unused code built in.  Otherwise we would have to hand edit out 
sections of code.  (CONFIG_I2C) may be set because of other devices on that 
bus.  Does the codec ONLY work in spi master?

Then (CONFIG_SND_SOC_WM8731) is not really needed since it is

CONFIG_SND_SOC_WM8731_I2C || CONFIG_SND_SOC_WM8731_SPI

Essentially, where a hardware device can be connected in different ways 
needing different code, a config option for each way is needed, rather than 
being guessed from bus config options.

Alan
