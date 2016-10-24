From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: constify snd_soc_ops structures
Date: Mon, 24 Oct 2016 18:34:23 +0100
Message-ID: <20161024173423.GL17252@sirena.org.uk>
References: <1476543351-17858-1-git-send-email-Julia.Lawall@lip6.fr>
 <1476543351-17858-6-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdEQJo40s7ofW8iR"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476543351-17858-6-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--sdEQJo40s7ofW8iR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 15, 2016 at 04:55:49PM +0200, Julia Lawall wrote:

> ---
>  sound/soc/generic/simple-card.c                 |    2 +-
>  sound/soc/generic/simple-scu-card.c             |    2 +-
>  sound/soc/intel/boards/bdw-rt5677.c             |    2 +-
>  sound/soc/intel/boards/bxt_da7219_max98357a.c   |    4 ++--
>  sound/soc/intel/boards/bxt_rt298.c              |    4 ++--
>  sound/soc/intel/boards/bytcr_rt5640.c           |    4 ++--
>  sound/soc/intel/boards/bytcr_rt5651.c           |    4 ++--
>  sound/soc/intel/boards/cht_bsw_max98090_ti.c    |    4 ++--
>  sound/soc/intel/boards/cht_bsw_rt5645.c         |    4 ++--
>  sound/soc/intel/boards/cht_bsw_rt5672.c         |    4 ++--
>  sound/soc/intel/boards/haswell.c                |    2 +-
>  sound/soc/intel/boards/skl_nau88l25_max98357a.c |    6 +++---
>  sound/soc/intel/boards/skl_nau88l25_ssm4567.c   |    6 +++---
>  sound/soc/intel/boards/skl_rt286.c              |    4 ++--
>  sound/soc/kirkwood/armada-370-db.c              |    2 +-
>  sound/soc/mxs/mxs-sgtl5000.c                    |    2 +-
>  16 files changed, 28 insertions(+), 28 deletions(-)

You split out a few drivers as separate patches but not these ones -
what's special about these ones?

--sdEQJo40s7ofW8iR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDkYdAAoJECTWi3JdVIfQ3WwH/1ggOjwECxJfjaf8P0e4eSVk
pJkaxP/SvSxy9Fpckht0VlU3y45EfGSkRJDSu2SLw+FmkONLy2wDk7qVr5pQ2FB9
/RKawocNL7l484qkvAGB0obuAc3yiM3cxDQlTYiKYzFraTzRmjs2ayPHQSfTKixo
5ZR7Uqh1plZwXYe4laz2poJ9GSgwK/1MsGDhmeUGSuaTqd3X/P1K8sfkQxCjt8AT
5GFxZEWYtXbFwDqo9fiBJF5+WQGl5SSgbcITC8OYkH1eJ6TPfDq9RY7wdHPtl9qO
v+Ms9aHWPS+7roiUV7yi/c5i4eNH0fy1fP8833/14AjBJa5pwY7rr1zxvnkTEb8=
=4tvI
-----END PGP SIGNATURE-----

--sdEQJo40s7ofW8iR--
