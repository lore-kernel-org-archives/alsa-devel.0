From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Where are dma interrupts handled in ASoC code?
Date: Fri, 21 Nov 2008 15:55:43 +0000
Message-ID: <20081121155542.GH31866@sirena.org.uk>
References: <520f0cf10811210145i20dec91ax9508b9268136bd5c@mail.gmail.com>
	<20081121110106.GB31866@sirena.org.uk>
	<520f0cf10811210324m5a409053g41478b0db221afb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 74EE62456F
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 16:55:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <520f0cf10811210324m5a409053g41478b0db221afb9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 21, 2008 at 12:24:34PM +0100, John Kacur wrote:

> My scenario is this, the dma controller will be writing to the i2s
> transmission fifo register (called I2SxTXFDAT on my platform - Jade).
> If an overflow occurs an interrupt is generated. Among other tasks my
> interrupt handler will have to clear a status bit in an i2s register.
> I was thinking I need to somehow have my interrupt handler in my pcm
> code, although conceptually it seems like an i2s thing.

> If you have any hints for how I should design / implement this it
> would be appreciated. I read the documentation on-line
> http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/writing-an-alsa-driver/x779.htm
> but it doesn't quite seem to match my scenario.

It's really up to you - if it's I2S-specific I'd put it in the I2S
driver but it's better to do something that makes sense for the
hardware.  The DMA/I2S split in the driver is there since most platforms
share the DMA controller between multiple front ends so it's helpful for
them to be able to share the code to drive the DMA controller.  If
that's not something that happens on your platform it may be sensible to
just use a dummy platform driver and have all the actual code in the I2S
driver, at least for the time being.
