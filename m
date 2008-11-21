From: "John Kacur" <jkacur@gmail.com>
Subject: Re: Where are dma interrupts handled in ASoC code?
Date: Fri, 21 Nov 2008 12:24:34 +0100
Message-ID: <520f0cf10811210324m5a409053g41478b0db221afb9@mail.gmail.com>
References: <520f0cf10811210145i20dec91ax9508b9268136bd5c@mail.gmail.com>
	<20081121110106.GB31866@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id BBB3124416
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 12:24:35 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so871526rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 03:24:34 -0800 (PST)
In-Reply-To: <20081121110106.GB31866@sirena.org.uk>
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
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 21, 2008 at 12:01 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Fri, Nov 21, 2008 at 10:45:46AM +0100, John Kacur wrote:
>
>> Where are dma overflow interrupts handled? For example I don't see
>> this in sound/soc/s3c24xx-i2s.c
>
> The s3c24xx ASoC code doesn't interact with the DMA controller directly,
> it uses the DMA API exported by the arch/arm code to do that.
>

Ok, thanks, I found that s3c2410_dma_request registers 3c2410_dma_irq.
(in arch/arm/plat-s3c24xx/dma.c) I see other platforms like omap
register an interrupt handler in the pcm code when they do a dma
request.

My scenario is this, the dma controller will be writing to the i2s
transmission fifo register (called I2SxTXFDAT on my platform - Jade).
If an overflow occurs an interrupt is generated. Among other tasks my
interrupt handler will have to clear a status bit in an i2s register.
I was thinking I need to somehow have my interrupt handler in my pcm
code, although conceptually it seems like an i2s thing.

If you have any hints for how I should design / implement this it
would be appreciated. I read the documentation on-line
http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/writing-an-alsa-driver/x779.htm
but it doesn't quite seem to match my scenario.

Thanks
