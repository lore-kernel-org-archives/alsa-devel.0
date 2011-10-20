From: Stephen Warren <swarren@nvidia.com>
Subject: Re: tegra_wm8903 dapm_nc_pins
Date: Thu, 20 Oct 2011 08:53:54 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173D51C142@HQMAIL01.nvidia.com>
References: <1319038149.1720.7.camel@localhost.localdomain>
	<74CDBE0F657A3D45AFBB94109FB122FF173D51BE29@HQMAIL01.nvidia.com>
	<A85EB6B3-06FB-4B03-AA90-79C6F7305A3A@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 251E6103A4F
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 17:54:00 +0200 (CEST)
In-Reply-To: <A85EB6B3-06FB-4B03-AA90-79C6F7305A3A@jusst.de>
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
To: Julian Scheel <julian@jusst.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown
	(broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Julian Scheel wrote at Wednesday, October 19, 2011 11:27 PM:
> Am 19.10.2011 um 18:12 schrieb Stephen Warren:
> > I believe the idea was to keep as much as possible of the audio related
> > information in the audio drivers rather than in board files. The GPIO
> > IDs are in platform data since the audio driver can't reach into the
> > mach-tegra gpio_names header since it's not public.
> 
> Ok.
> 
> > What I'd like to see in the nc_pins case is the DAPM core automatically
> > perform these calls based on which pins the codec has which aren't
> > mentioned in card->dapm_routes; I haven't investigated whether that's
> > actually possible without breaking unrelated boards though.
> 
> Well actually the current state can break unrelated boards as well.

By "unrelated", I meant boards other than Tegra boards; AFAIK, the current
Tegra driver isn't broken for any board that the current driver expects to
support.

...
> > Eventually, I see most of these tables moving into device-tree, with
> > the only thing hard-coded into tegra_wm8903.c being all the clock and
> > format setup code.
> 
> I am not aware how much work this would be, as I have not yet worked with
> device tree at all. I would propose to change the init code to auto detection
> based on the dapm routes for now. I should find the time to make up a patch,
> if you agree.

I believe a secretlab employee was working on DT bindings for the Tegra+WM8903
machine driver, although I haven't seen any updates on this front recently.

By all means make the existing driver calculate the nc pins automatically.
I suspect the implementation should probably be in the ASoC core, and Mark
pointed out it should be optional so as not to break any other (non-Tegra
WM8903) boards.

-- 
nvpublic
