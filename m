From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/11] ASoC: tegra: Add tegra-das driver
Date: Wed, 22 Dec 2010 20:11:18 +0000
Message-ID: <20101222201118.GA8167@opensource.wolfsonmicro.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-8-git-send-email-swarren@nvidia.com>
	<20101217220029.GD25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F7E52457C
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 21:11:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF030FD78D90@HQMAIL01.nvidia.com>
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 10:30:15AM -0800, Stephen Warren wrote:
> Mark Brown wrote:

> > Reading this it's essentially just exporting point to point switches
> > within the DAS block.  This really feels like it ought to be represented
> > as a CODEC driver to give runtime flexibility to userspace to control
> > the mux - it looks like the AP part of the system streams data into this
> > block which then has very flexible switching on to the externally
> > connected audio devices.

> Hmm. I don't see any examples of anything like Tegra's DAS in the existing
> ASoC code-base. So, I'm slightly unsure how to recast the DAS driver as
> a codec. In particular, in the machine driver, would I do something like:

The closest thing in the tree at the minute is WM8994 and WM8995 - both
of these have multiple audio interfaces plus a DAC/ADC/DMIC block
connected together via a digital mixing block.

> static struct snd_soc_dai_link *harmony_links[] = {
> 	& harmony_i2s_das_link,
> 	& harmony_das_wm8903_link,
> };

Essentially, yes.

> Wouldn't that end up exposing two streams to user-space, one for each entry
> in harmony_links[]?

Yeah, that's the unfortunate bit - it doesn't work ideally well right
now.  We actually need to take care of this anyway (it's also an issue
for things like phones as you get the same structure for the link
between a digital baseband and the CODEC it's connected to) and
something like this that really strongly benefits from the feature would
be a good thing to use to get that working.

I guess for now setting up a 1:1 mapping between the CPU DAIs and the
physical ports would get the CPU driver going, then I can do the
framework work required to make sure DAPM propagates nicely over the
mux.  Does that sound reasonable?
