From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 10:28:18 -0500
Message-ID: <4BD70292.20001@freescale.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>	
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>	
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 189BB243AF
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 17:28:20 +0200 (CEST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RFSJLr025734
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 08:28:19 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o3RFSN0n014924
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 10:28:23 -0500 (CDT)
In-Reply-To: <1272381611.11000.39.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> Iirc, the SSI and DMA controllers on your SoC mean that each DMA device
> can only do one direction (either Playback or Capture). So I'm thinking
> we create two DAI link entries for your sound card (one for playback and
> the other for capture) and they both use the same SSI device but each
> would have it's own DMA device.

Do you mean here:

	machine_data->card.probe = mpc8610_hpcd_machine_probe;
	machine_data->card.remove = mpc8610_hpcd_machine_remove;
	machine_data->card.name = "MPC8610 HPCD";
	machine_data->card.num_links = 1;
	machine_data->card.dai_link = &machine_data->dai;

So that num_links would be 2 instead of 1?

I would need some way for fsl_dma_open() to get a pointer to private, DMA-specific data.  I'm not sure how I can do that.

> This would result in two separate pcm devices being exported to
> userspace i.e one for playback only and the other for capture only. I
> think this is also a more accurate representation of your hardware too
> (since we have different DMA devices for each pcm stream direction).

I can say for certain whether that will actually work.  My gut tells me that I might run into problems trying to implement that.  The only way to know for sure is to start hacking.  Unfortunately, my window of opportunity to work on this just closed, and it may not open for a while.  I know my current patch is less-than-ideal, but it does restore functionality to the 8610, and without needing any U-Boot or device-tree changes.  So unless there are any real objections, I'd like it to be merged.  Otherwise, 8610 audio will be broken in the next release.

-- 
Timur Tabi
Linux kernel developer at Freescale
