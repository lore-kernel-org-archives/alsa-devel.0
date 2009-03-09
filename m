From: Liam Girdwood <lrg@kernel.org>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Mon, 09 Mar 2009 15:03:06 +0000
Message-ID: <1236610986.6781.93.camel@vega.slimlogic.co.uk>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 87788103860
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 16:03:17 +0100 (CET)
In-Reply-To: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-03-09 at 15:47 +0100, pHilipp Zabel wrote:
> Ok,
> 
> I'm not sure how to handle this correctly.
> 
> Magician needs stereo S16_LE input data from alsa, DAIFMT_DSP_A on the
> wire with a frame size of 16 bit (one frame for each channel) and thus
> 2-byte DMA transfers to the FIFO (currently called 'mono' DMA params).
> Zylonite's current code uses 32 bit frame size and 4-byte DMA
> transfers to emulate I2S (S16_LE,stereo). Network mode seems to work,
> so it could be changed to use two 16 bit slots instead with 2-byte DMA
> transfers (which would make Magician happy). But...
> Daniel's board needs very strange settings because network mode
> doesn't work, so I guess he can't use 2-byte DMA transfers. Is that
> correct?
> 
> If we can't find a way to have all machines use the mono DMA params,
> there has to be some kind of interface to set the width of the data in
> the FIFO independently from the Alsa format. How should that interface
> look like?

Btw, what pxa processor variants are you and Daniel using ?

Iirc, PXA3x SSP is quite different in terms of "usability" compared to
to PXA2x SSP. It might be worth diverging the SSP code a little here if
your CPUs are different.

Liam
