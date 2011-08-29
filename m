From: Liam Girdwood <lrg@ti.com>
Subject: Re: ASoC DSP and related status
Date: Mon, 29 Aug 2011 19:09:27 +0100
Message-ID: <4E5BD5D7.2020909@ti.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A41A8@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 511FD244DD
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 20:09:33 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Stephen,

On 26/08/11 20:44, Stephen Warren wrote:
> Liam, Mark,
> 
> I was recently talking to our internal audio team, extolling the virtues
> of writing upstreamable drivers for Tegra's audio HW.
> 
> One of the big unknowns here is how to represent the Tegra DAS and AHUB
> modules[1] in a standard fashion, and allowing configuration via kcontrols
> that influence DAPM routing, rather than open-coding and/or hard-coding
> such policy in the ASoC machine driver.
> 
> So, my questions are:
> 
> * What's the status of the ASoC DSP work. I see that some of the base
> infra-structure has been merged into ASoC's for-next branch, but I think
> that's just a small portion of the work. Do you have any kind of estimate
> for when the whole thing will be merged? I don't see recent updates to
> e.g. Liams' topic/dsp or topic/dsp-upstream branches.
> 

I have about 10 Dynamic PCM (AKA ASoC DSP) core patches still to make it upstream atm.

It in progress atm, but will probably slow down for the next 2 weeks since I'll be in California.

I am aiming to upstream asap, but other things usually take higher priority than upstream at times.

> * Back in March in another DSP-related thread, Mark mentioned that the
> DSP rework was mainly about configuring stuff within a device, but that
> Mark was working on some code to support autonomous inter-device links.
> I assume that Tegra's DAS/AHUB would rely on the DSP work, not the stuff
> Mark mentioned?
> 

If the Tegra hardware is on CPU and looks anything like the OMAP4 ABE then you will probably need the Dynamic PCM code.

http://www.omappedia.org/wiki/Audio_Drive_Arch

The ABE is basically a PCM DSP with SRC, ASRC, Mixers, Muxes, Volumes, Mutes and DAIs implemented in FW.

Liam

> See the last few paragraphs of:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-March/037776.html
> 
> Related, Mark also mentioned something about representing the DAS/AHUB
> as codecs. I'm not sure if that was meant as a stop-gap solution before
> the DSP work was in place, or if that's part of supporting DAAS/AHUB
> within the DSP infra-structure.
> 
> Thanks for any kind of information! Any information here will simply help
> us plan for when we might be able to switch from open-coding some of the
> more advanced Tegra audio support to more standardized solutions.
> 
> 
> [1] Here's a very quick overview of the relevant Tegra audio HW:
> 
> DAS:
> 
> Part of Tegra20. Tegra20 has Digital Audio controllers (DACs) i.e. I2S
> controllers. It also has Digital Audio Ports (DAPs). The Digital Audio
> Switch (DAS ) sits between. Each DAP selects its audio output from a
> particular DAC's or DAP's output. Each DAC selects its audio input from
> a particular DAP. DAP<-> DAP is supported, with one being the master the
> other the slave. Note that I2S configuration (channels, sample size, I2S
> vs. DSP etc) is configured in the DAC not the DAP.
> 
> AHUB:
> 
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
> 
