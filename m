From: Stephen Warren <swarren@nvidia.com>
Subject: Re: ASoC DSP and related status
Date: Wed, 31 Aug 2011 16:14:43 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A191@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A41A8@HQMAIL01.nvidia.com>
	<20110827093656.GA2984@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 30CBE24597
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Sep 2011 01:14:52 +0200 (CEST)
In-Reply-To: <20110827093656.GA2984@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Saturday, August 27, 2011 3:37 AM:
> On Fri, Aug 26, 2011 at 12:44:26PM -0700, Stephen Warren wrote:
> ... (questions about soc-dsp and representing Tegra HW to ASoC)

Thanks Mark and Liam for your answers.

> > (T30) AHUB:
> 
> > Part of Tegra30. Tegra30 has an interconnect called the Audio HUB (AHUB).
> > Various devices attach to this: FIFOs to send/receive audio to CPU memory
> > using DMA, DAMs that receive n(2?) channels from the AHUB and mix/SRC them
> > sending the result back to the AHUB, and finally various IO controllers
> > such as I2S and SPDIF. The AHUB is I believe a full cross-bar. In this
> > case, the I2S formatting is configured solely within the I2S controllers,
> > not on the other side of the AHUB as is the case with the Tegra20 DAS.
> > FIFOs also independently determine the number of channels/bit they send/
> > receive. There is some limited support for channel count and bitsize
> > conversion at each attachment point to the AHUB. I2S<->I2S loopback may
> > be supported in HW, at least in some cases.
> 
> To me this sounds like it could usefully be a CODEC - the CPU is pretty
> well isolated from the actual physical ports (and needn't be involved at
> all) and functionally it's not much different to the sort of setup we've
> got in some of the existing CODEC drivers just without the integration
> of the mixed signal bits.  That'd mean that you could reuse all the
> infrastructure those devices use which ought to make the T30 specific
> bit simpler.

That makes sense.

One question: This would end up with something like:

+------------+  (dai 1)  +--------------+  (dai 2)  +----------------+
| Tegra I2S  |<--------->| AHUB (codec) |<--------->| WM8903 (codec) |
+------------+           +--------------+           +----------------+

I think I may have asked this before, but how would we represent that to
ASoC; I don't think there's any way to squash both those two DAIs into a
single snd_soc_dai_link structure, whereas I think I recall you saying
that using two separate snd_soc_dai_links wouldn't really work; I'm not
sure what we'd put in dai2's "platform" field, and IIRC the second DAI
would end up instantiating extra PCM devices to user-space. Am I way off
base here, or would be need to do some extra infra-structure work to get
this all working?

Thanks again.

-- 
nvpublic
