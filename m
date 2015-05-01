From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Add gtm601 codec driver
Date: Fri, 1 May 2015 12:03:11 +0100
Message-ID: <20150501110311.GV22845@sirena.org.uk>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
 <1430429283-27907-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+PWOPzi3n7ESJ/v3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430429283-27907-2-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: perex@perex.cz, tiwai@suse.de, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--+PWOPzi3n7ESJ/v3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 11:28:01PM +0200, Marek Belisko wrote:

>  	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
>  	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
>  	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
> +	select SND_SOC_GTM601
>          help
> +config SND_SOC_GTM601
> +	tristate 'GTM601 UMTS modem audio codec'
> +

Keep Makefile and Kconfig sorted.

> +/*
> + * Note this is a simple chip with no configuration interface, sample rate is
> + * determined automatically by examining the Master clock and Bit clock ratios
> + */

> +#define GTM601_RATES  (SNDRV_PCM_RATE_8000)

Does it or doesn't it support multiple sample rates?

--+PWOPzi3n7ESJ/v3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ11vAAoJECTWi3JdVIfQ+sYH/RdRy7+4vsz53B98a13LGNkP
+fTSQFVzDzK9VCmQ4bsOkUTrXLYXXlyUEb55tk4qfNnL9KufSudM/CFZnZae8AcU
rt09sJzu8Kx87sxZWPu8nNukIJIB0h7e+P3VYibjgW7aS4LjEj+8qkaNLNlZqZO2
dSs1QMiBQhwViBRCwhoXTtGqBFaUPkZxYeE4LwGCasHik11AvPpVKBXRYxzZhnJP
e4SH9r9YMfwrb1lPMALQE0IYR7ZRsUcck69XRoSzLzD9zzyz5zpnyAsd9cUgYDU0
JUMCiZvmu7BbO/cbdVu1mQ7aoNeUtHkvfSSqkZ6biYRISl8dnu4yCFAbWBGDo6s=
=rgxU
-----END PGP SIGNATURE-----

--+PWOPzi3n7ESJ/v3--
