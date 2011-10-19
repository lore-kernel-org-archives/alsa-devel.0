From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: tegra_wm8903 dapm_nc_pins
Date: Wed, 19 Oct 2011 17:34:43 +0100
Message-ID: <20111019163443.GB4275@opensource.wolfsonmicro.com>
References: <1319038149.1720.7.camel@localhost.localdomain>
	<74CDBE0F657A3D45AFBB94109FB122FF173D51BE29@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 534DA103807
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 18:34:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173D51BE29@HQMAIL01.nvidia.com>
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
Cc: Julian Scheel <julian@jusst.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 19, 2011 at 09:12:46AM -0700, Stephen Warren wrote:

> I believe the idea was to keep as much as possible of the audio related
> information in the audio drivers rather than in board files. The GPIO
> IDs are in platform data since the audio driver can't reach into the
> mach-tegra gpio_names header since it's not public.

Well, it's also that the model the stack has is that all this stuff is
going to be in board files.

> What I'd like to see in the nc_pins case is the DAPM core automatically
> perform these calls based on which pins the codec has which aren't
> mentioned in card->dapm_routes; I haven't investigated whether that's
> actually possible without breaking unrelated boards though.

This wouldn't be too hard to do but needs to be entirely optional,
just wiring the CODEC driver in should be enough.  Keeping things
powered down is an optimisation, getting audio out is critical
functionality.

> If you were to move the nc_pins list into platform data, you'd end up
> wanting to move the snd_soc_dapm_route tables too, and perhaps even
> tegra_wm8903_controls[] and maybe more.

> Eventually, I see most of these tables moving into device-tree, with
> the only thing hard-coded into tegra_wm8903.c being all the clock and
> format setup code.

Until someone decides to connect MCLK somewhere else...
