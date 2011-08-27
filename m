From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC DSP and related status
Date: Sat, 27 Aug 2011 10:36:57 +0100
Message-ID: <20110827093656.GA2984@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A41A8@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 261082472C
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Aug 2011 11:37:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A41A8@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 26, 2011 at 12:44:26PM -0700, Stephen Warren wrote:

> * Back in March in another DSP-related thread, Mark mentioned that the
> DSP rework was mainly about configuring stuff within a device, but that
> Mark was working on some code to support autonomous inter-device links.
> I assume that Tegra's DAS/AHUB would rely on the DSP work, not the stuff
> Mark mentioned?

This depends on how your DSP and associated blobs appear in the system.
If the hardware system integration is done such that the DSP looks like
a separate chip between the CPU and the rest of the world which happens
to be part of the same package then it looks like my stuff - my stuff is
mostly there for things like CODEC<->Baseband links where the CPU isn't
involved.  You'd wind up with CPU<->DSP links either just using vanillia
PCMs or using the DSP stuff Liam has been working on and then have some
links at the other side of the DSP which look like baseband or whatever
style links.

> Related, Mark also mentioned something about representing the DAS/AHUB
> as codecs. I'm not sure if that was meant as a stop-gap solution before
> the DSP work was in place, or if that's part of supporting DAAS/AHUB
> within the DSP infra-structure.

I think that's somethinng which we should do if there's interesting
stuff going on inside them that it's useful to represent and doing so
doesn't introduce too many contortions due to hardware sharing with the
main CPU - it means that we can reuse all the infrastructure that we've
got for representing routes and so on within CODECs.

> DAS:

> Part of Tegra20. Tegra20 has Digital Audio controllers (DACs) i.e. I2S
> controllers. It also has Digital Audio Ports (DAPs). The Digital Audio
> Switch (DAS ) sits between. Each DAP selects its audio output from a
> particular DAC's or DAP's output. Each DAC selects its audio input from
> a particular DAP. DAP<-> DAP is supported, with one being the master the
> other the slave. Note that I2S configuration (channels, sample size, I2S
> vs. DSP etc) is configured in the DAC not the DAP.

This one should be easier with Liam's soc-dsp stuff as the output ports
are heavily tied to the CPU side.  Might be fun representing DAP<->DAP
links but I'm not sure how widely deployed those are.

> AHUB:

> Part of Tegra30. Tegra30 has an interconnect called the Audio HUB (AHUB).
> Various devices attach to this: FIFOs to send/receive audio to CPU memory
> using DMA, DAMs that receive n(2?) channels from the AHUB and mix/SRC them
> sending the result back to the AHUB, and finally various IO controllers
> such as I2S and SPDIF. The AHUB is I believe a full cross-bar. In this
> case, the I2S formatting is configured solely within the I2S controllers,
> not on the other side of the AHUB as is the case with the Tegra20 DAS.
> FIFOs also independently determine the number of channels/bit they send/
> receive. There is some limited support for channel count and bitsize
> conversion at each attachment point to the AHUB. I2S<->I2S loopback may
> be supported in HW, at least in some cases.

To me this sounds like it could usefully be a CODEC - the CPU is pretty
well isolated from the actual physical ports (and needn't be involved at
all) and functionally it's not much different to the sort of setup we've
got in some of the existing CODEC drivers just without the integration
of the mixed signal bits.  That'd mean that you could reuse all the
infrastructure those devices use which ought to make the T30 specific
bit simpler.
