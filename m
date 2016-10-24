From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 5/7] ASoC: constify snd_soc_ops structures
Date: Mon, 24 Oct 2016 21:48:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610242147570.2115@hadrien>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr> <1476543351-17858-6-git-send-email-Julia.Lawall@lip6.fr> <20161024173423.GL17252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161024173423.GL17252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On Mon, 24 Oct 2016, Mark Brown wrote:

> On Sat, Oct 15, 2016 at 04:55:49PM +0200, Julia Lawall wrote:
>
> > ---
> >  sound/soc/generic/simple-card.c                 |    2 +-
> >  sound/soc/generic/simple-scu-card.c             |    2 +-
> >  sound/soc/intel/boards/bdw-rt5677.c             |    2 +-
> >  sound/soc/intel/boards/bxt_da7219_max98357a.c   |    4 ++--
> >  sound/soc/intel/boards/bxt_rt298.c              |    4 ++--
> >  sound/soc/intel/boards/bytcr_rt5640.c           |    4 ++--
> >  sound/soc/intel/boards/bytcr_rt5651.c           |    4 ++--
> >  sound/soc/intel/boards/cht_bsw_max98090_ti.c    |    4 ++--
> >  sound/soc/intel/boards/cht_bsw_rt5645.c         |    4 ++--
> >  sound/soc/intel/boards/cht_bsw_rt5672.c         |    4 ++--
> >  sound/soc/intel/boards/haswell.c                |    2 +-
> >  sound/soc/intel/boards/skl_nau88l25_max98357a.c |    6 +++---
> >  sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |    6 +++---
> >  sound/soc/intel/boards/skl_rt286.c              |    4 ++--
> >  sound/soc/kirkwood/armada-370-db.c              |    2 +-
> >  sound/soc/mxs/mxs-sgtl5000.c                    |    2 +-
> >  16 files changed, 28 insertions(+), 28 deletions(-)
>
> You split out a few drivers as separate patches but not these ones -
> what's special about these ones?

They all have the same set of maintainers.  The split out drivers have
some other set of maintainers.

julia
