From: Stephen Warren <swarren@nvidia.com>
Subject: Re: tegra_wm8903 dapm_nc_pins
Date: Wed, 19 Oct 2011 09:12:46 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173D51BE29@HQMAIL01.nvidia.com>
References: <1319038149.1720.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E11B2461F
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 18:12:53 +0200 (CEST)
In-Reply-To: <1319038149.1720.7.camel@localhost.localdomain>
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

Julian Scheel wrote at Wednesday, October 19, 2011 9:29 AM:
> is there any special reason for the dapm_nc_pins being hardcoded into
> tegra_wm8903.c instead of being set through the platform data?
...
> So I would suggest to add an entry to the platform data which contains a
> list of NC-pins which are then set to nc by the tegra_wm8903 driver on
> startup.

I believe the idea was to keep as much as possible of the audio related
information in the audio drivers rather than in board files. The GPIO
IDs are in platform data since the audio driver can't reach into the
mach-tegra gpio_names header since it's not public.

What I'd like to see in the nc_pins case is the DAPM core automatically
perform these calls based on which pins the codec has which aren't
mentioned in card->dapm_routes; I haven't investigated whether that's
actually possible without breaking unrelated boards though.

If you were to move the nc_pins list into platform data, you'd end up
wanting to move the snd_soc_dapm_route tables too, and perhaps even
tegra_wm8903_controls[] and maybe more.

Eventually, I see most of these tables moving into device-tree, with
the only thing hard-coded into tegra_wm8903.c being all the clock and
format setup code.

-- 
nvpublic
