From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 5/6] ASoC: ep93xx: Add .owner to struct
	snd_soc_card
Date: Fri, 23 Dec 2011 10:19:40 +0200
Message-ID: <20111223081940.GA2401@mwesterb-mobl.ger.corp.intel.com>
References: <1324559698.10821.2.camel@phoenix>
	<1324560097.10821.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F9C4103F73
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 09:20:03 +0100 (CET)
Received: by lago2 with SMTP id o2so3531688lag.38
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 00:20:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1324560097.10821.8.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lrg@ti.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2011 at 09:21:37PM +0800, Axel Lin wrote:
> Missed .owner of struct snd_soc_card will prevent the module from being
> removed from underneath its users.
> =

> Reported-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Thanks!

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

> ---
>  sound/soc/ep93xx/edb93xx.c     |    1 +
>  sound/soc/ep93xx/simone.c      |    1 +
>  sound/soc/ep93xx/snappercl15.c |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)
> =

> diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
> index 9f6fecd..bae5cbb 100644
> --- a/sound/soc/ep93xx/edb93xx.c
> +++ b/sound/soc/ep93xx/edb93xx.c
> @@ -75,6 +75,7 @@ static struct snd_soc_dai_link edb93xx_dai =3D {
>  =

>  static struct snd_soc_card snd_soc_edb93xx =3D {
>  	.name		=3D "EDB93XX",
> +	.owner		=3D THIS_MODULE,
>  	.dai_link	=3D &edb93xx_dai,
>  	.num_links	=3D 1,
>  };
> diff --git a/sound/soc/ep93xx/simone.c b/sound/soc/ep93xx/simone.c
> index 1e00b33..dd99709 100644
> --- a/sound/soc/ep93xx/simone.c
> +++ b/sound/soc/ep93xx/simone.c
> @@ -34,6 +34,7 @@ static struct snd_soc_dai_link simone_dai =3D {
>  =

>  static struct snd_soc_card snd_soc_simone =3D {
>  	.name		=3D "Sim.One",
> +	.owner		=3D THIS_MODULE,
>  	.dai_link	=3D &simone_dai,
>  	.num_links	=3D 1,
>  };
> diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl1=
5.c
> index e97cd57..ccae34a 100644
> --- a/sound/soc/ep93xx/snappercl15.c
> +++ b/sound/soc/ep93xx/snappercl15.c
> @@ -93,6 +93,7 @@ static struct snd_soc_dai_link snappercl15_dai =3D {
>  =

>  static struct snd_soc_card snd_soc_snappercl15 =3D {
>  	.name		=3D "Snapper CL15",
> +	.owner		=3D THIS_MODULE,
>  	.dai_link	=3D &snappercl15_dai,
>  	.num_links	=3D 1,
>  };
> -- =

> 1.7.5.4
> =

> =
