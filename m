From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 08/11] ASoC: tegra: Add tegra-pcm driver
Date: Wed, 22 Dec 2010 11:03:29 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030FD78DB5@HQMAIL01.nvidia.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-9-git-send-email-swarren@nvidia.com>
	<20101217220658.GG25609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 36B0624544
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 20:03:40 +0100 (CET)
In-Reply-To: <20101217220658.GG25609@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Colin Cross
	(ccross@google.com)" <ccross@google.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote on Friday, December 17, 2010 3:07 PM:
> On Fri, Dec 17, 2010 at 02:41:27PM -0700, Stephen Warren wrote:
> > This provides an ASoC platform driver that manages Tegra's APB DMA
> > controller.
> 
> Oh, and one other thing: if your DMA controller has a free running mode
> it'd be much nicer to use that than to have to continually keep feeding
> it buffers.

As far as I can tell, Tegra's DMA controller doesn't provide a continuous
mode that's useful for audio.

The DMA controller does have a continuous mode, which can either
continually push the exact same buffer into the I2S FIFO, or can
continually push two contiguous same-sized buffers into the I2s FIFO. In
either case, I think we get an interrupt half-way through.

However, I don't see a way to handle a buffer with <n> chunks, and get an
interrupt for each chunk (unless n==2 of course).

I suppose we could use continuous mode if we set both periods_min/max==2,
but that seems a little inflexible.

Finally, for reasons I don't fully understand, even when the HW is in
continuous mode, the driver seems to require you to continually queue more
DMA requests into the driver's request list anyway, so tegra_pcm.c would be
doing just as much work, and hence is presumably no better for CPU usage
and power.

Perhaps this mechanism allows changing the buffer that continuous mode
operates on without shutting down the DMA engine, and hence allows emulation
of a larger buffer with interrupts on every chunk with more than two chunks.
Or, perhaps this is intended to allow SW to update the HW registers for the
next DMA half way through the current DMA, to avoid making the DMA engine
wait for the ISR to program the next operation during the ISR. Perhaps Colin
can comment more on this?

Given all that, I'm tempted to simply stick with single-shot mode for now.

-- 
nvpublic
