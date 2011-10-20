From: Julian Scheel <julian@jusst.de>
Subject: Re: tegra_wm8903 dapm_nc_pins
Date: Thu, 20 Oct 2011 07:27:26 +0200
Message-ID: <A85EB6B3-06FB-4B03-AA90-79C6F7305A3A@jusst.de>
References: <1319038149.1720.7.camel@localhost.localdomain>
	<74CDBE0F657A3D45AFBB94109FB122FF173D51BE29@HQMAIL01.nvidia.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.work.de (smtp1.work.de [212.12.40.178])
	by alsa0.perex.cz (Postfix) with ESMTP id DA2B8103869
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 07:27:29 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Am 19.10.2011 um 18:12 schrieb Stephen Warren:
> I believe the idea was to keep as much as possible of the audio related
> information in the audio drivers rather than in board files. The GPIO
> IDs are in platform data since the audio driver can't reach into the
> mach-tegra gpio_names header since it's not public.

Ok.

> What I'd like to see in the nc_pins case is the DAPM core automatically
> perform these calls based on which pins the codec has which aren't
> mentioned in card->dapm_routes; I haven't investigated whether that's
> actually possible without breaking unrelated boards though.

Well actually the current state can break unrelated boards as well.
For example the lineout lines are set to NC for any boards besides aebl.
This is the actual reason why I started to look at this.

> If you were to move the nc_pins list into platform data, you'd end up
> wanting to move the snd_soc_dapm_route tables too, and perhaps even
> tegra_wm8903_controls[] and maybe more.

Ok, agreed.

> Eventually, I see most of these tables moving into device-tree, with
> the only thing hard-coded into tegra_wm8903.c being all the clock and
> format setup code.

I am not aware how much work this would be, as I have not yet worked with
device tree at all. I would propose to change the init code to auto detection
based on the dapm routes for now. I should find the time to make up a patch,
if you agree.

Julian
