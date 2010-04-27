From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Tue, 27 Apr 2010 16:20:11 +0100
Message-ID: <1272381611.11000.39.camel@odin>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E3AE24395
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 17:20:17 +0200 (CEST)
Received: by bwz20 with SMTP id 20so7647469bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 08:20:17 -0700 (PDT)
In-Reply-To: <4BD6FA39.3030400@freescale.com>
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

On Tue, 2010-04-27 at 09:52 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 

> > Now I don't know the mechanics of adding an ASoC sound card to the
> > device tree, but the device tree should be able to define an ASoC sound
> > card and also represent the relationships between the sound card and the
> > SSI/Codec/DMA components. The components should also be represented in
> > the device tree. Parsing the device tree should probe() all the ASoC
> > components and sound card. The ASoC core would then instantiated them as
> > a sound device.  
> 
> Another problem is that ASoC won't let me probe the DMA channels
> independently.  That is, I cannot tell ASoC that I have a playback DMA
> and a capture DMA.  ASoC does not recognize two DMA devices for a
> single SSI.  If you can fix that, then I can turn the DMA driver into
> an OF driver.
> 

Iirc, the SSI and DMA controllers on your SoC mean that each DMA device
can only do one direction (either Playback or Capture). So I'm thinking
we create two DAI link entries for your sound card (one for playback and
the other for capture) and they both use the same SSI device but each
would have it's own DMA device.

This would result in two separate pcm devices being exported to
userspace i.e one for playback only and the other for capture only. I
think this is also a more accurate representation of your hardware too
(since we have different DMA devices for each pcm stream direction).

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
