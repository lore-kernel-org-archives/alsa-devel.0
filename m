From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 17:41:10 +0100
Message-ID: <1272386470.11000.84.camel@odin>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
	<4BD70292.20001@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 59D732432C
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 18:41:16 +0200 (CEST)
Received: by bwz20 with SMTP id 20so7797103bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 09:41:15 -0700 (PDT)
In-Reply-To: <4BD70292.20001@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-04-27 at 10:28 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> > Iirc, the SSI and DMA controllers on your SoC mean that each DMA device
> > can only do one direction (either Playback or Capture). So I'm thinking
> > we create two DAI link entries for your sound card (one for playback and
> > the other for capture) and they both use the same SSI device but each
> > would have it's own DMA device.
> 
> Do you mean here:
> 
> 	machine_data->card.probe = mpc8610_hpcd_machine_probe;
> 	machine_data->card.remove = mpc8610_hpcd_machine_remove;
> 	machine_data->card.name = "MPC8610 HPCD";
> 	machine_data->card.num_links = 1;
> 	machine_data->card.dai_link = &machine_data->dai;
> 
> So that num_links would be 2 instead of 1?
> 

Yes.

> I would need some way for fsl_dma_open() to get a pointer to private,
> DMA-specific data.  I'm not sure how I can do that.
> 

In multi-component we now have platform_data and device private data
(from the regular driver model).

We also have stream snd_soc_dai_set_dma_data() for runtime DMA config.

So it depends on who is setting your DMA data. If it's DTS then it would
be the of_ platform equivalent, if it's your DMA probe() then dev data
otherwise you can use the snd_soc_dai_set_dma_data().

> > This would result in two separate pcm devices being exported to
> > userspace i.e one for playback only and the other for capture only. I
> > think this is also a more accurate representation of your hardware too
> > (since we have different DMA devices for each pcm stream direction).
> 
> I can say for certain whether that will actually work.  My gut tells
> me that I might run into problems trying to implement that.  The only
> way to know for sure is to start hacking.  Unfortunately, my window of
> opportunity to work on this just closed, and it may not open for a
> while.  I know my current patch is less-than-ideal, but it does
> restore functionality to the 8610, and without needing any U-Boot or
> device-tree changes.  So unless there are any real objections, I'd
> like it to be merged.  Otherwise, 8610 audio will be broken in the
> next release.

Ok, I can live with this providing we can mark it as a TODO: and have a
PPC Ack. It may be easier to fix in the future too as the ASoC card
registration clean-up should be complete/in-progress (i.e. card
platform_data and private_data will be available for passing in anything
you like).

Thanks

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
