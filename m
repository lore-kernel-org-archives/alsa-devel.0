From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH 0/7] ASoC: ep93xx: convert to use
	snd_soc_register_card()
Date: Mon, 12 Sep 2011 05:55:49 +0100
Message-ID: <CABS+qY15T_fR4o4kxBYguXH64wzaCrypJZdaduDDht_9Vqokfg@mail.gmail.com>
References: <cover.1315732452.git.mika.westerberg@iki.fi>
	<4E6D4100.7060007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 878322413B
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 06:55:51 +0200 (CEST)
Received: by mail-qw0-f43.google.com with SMTP id 42so3082847qwm.2
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 21:55:49 -0700 (PDT)
In-Reply-To: <4E6D4100.7060007@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: hsweeten@visionengravers.com, Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 12 September 2011 00:15, Ryan Mallon <rmallon@gmail.com> wrote:

> On 11/09/11 19:28, Mika Westerberg wrote:
>
> > Here is a series of patches which convert ep93xx ASoC drivers to use
> > snd_soc_register_card(). This has the advantage that the machine drivers
> get
> > loaded automatically by udev. Also this gets rid of machine_is_xxx() from
> the
> > machine drivers.
> >
> > Tested on Sim.One. The edb93xx and snappercl15 changes are compile tested
> > only.
>
>
> Thanks for doing this. Unfortunately I don't have any hardware to test
> any more, but the code looks correct to me.
>
> Whole series:
> Reviewed-by: Ryan Mallon <rmallon@gmail.com>
>
> >
> > Mika Westerberg (7):
> >   ASoC: ep93xx-pcm: add MODULE_ALIAS
> >   ASoC: simone: convert to use snd_soc_register_card()
> >   ASoC: edb93xx: convert to use snd_soc_register_card()
> >   ASoC: snappercl15: convert to use snd_soc_register_card()
> >   ARM: ep93xx: simone: register audio platform device
> >   ARM: ep93xx: edb93xx: register audio platform device
> >   ARM: ep93xx: snappercl15: register audio platform device
> >
> >  arch/arm/mach-ep93xx/edb93xx.c     |    6 +++
> >  arch/arm/mach-ep93xx/simone.c      |   13 +++++++-
> >  arch/arm/mach-ep93xx/snappercl15.c |   13 +++++++-
> >  sound/soc/ep93xx/edb93xx.c         |   60
> ++++++++++++++++++---------------
> >  sound/soc/ep93xx/ep93xx-pcm.c      |    1 +
> >  sound/soc/ep93xx/simone.c          |   64
> ++++++++++++++++++++----------------
> >  sound/soc/ep93xx/snappercl15.c     |   53 ++++++++++++++++++++---------
> >  7 files changed, 136 insertions(+), 74 deletions(-)
> >
>
>
>
ASoC parts

Acked-by: Liam Girdwood <lrg@ti.com>
