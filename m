From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Add gtm601 codec driver
Date: Fri, 1 May 2015 15:02:25 +0100
Message-ID: <20150501140225.GY22845@sirena.org.uk>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
 <1430429283-27907-2-git-send-email-marek@goldelico.com>
 <20150501110311.GV22845@sirena.org.uk>
 <CAAfyv36Bi_Em=PUUf1n0nk6AAR65QLzr_R2SenHs_C5Q3Ggjmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l9OvbEp/JYZ/p+uv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv36Bi_Em=PUUf1n0nk6AAR65QLzr_R2SenHs_C5Q3Ggjmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: perex@perex.cz, tiwai@suse.de, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--l9OvbEp/JYZ/p+uv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 01:36:48PM +0200, Belisko Marek wrote:
> On Fri, May 1, 2015 at 1:03 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Apr 30, 2015 at 11:28:01PM +0200, Marek Belisko wrote:

> >> +/*
> >> + * Note this is a simple chip with no configuration interface, sample rate is
> >> + * determined automatically by examining the Master clock and Bit clock ratios
> >> + */
> >
> >> +#define GTM601_RATES  (SNDRV_PCM_RATE_8000)

> > Does it or doesn't it support multiple sample rates?

> It support only 8kHz rate. I'll remove define and use SNDRV_PCM_RATE_8000
> only in gtm601_dai struct.

I was more commenting on the fact that the comment immediately above
says that the sample rate is determined automatically which suggests
that multiple sample rates are supported.

--l9OvbEp/JYZ/p+uv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ4dwAAoJECTWi3JdVIfQ0noH/0aGUH8Q/GvQmW9609Zzeqhz
LQovDqAiFPx8VQRAeB96LVYUdiTC6BBnKFy+b434VQ41NScxS07sPo7ypDVNWDBd
pwBoLCbJC/xeUVw1tZO4rvIuWJApzD7XukhqgDUK3JZcX7qqaZ61QdteeXr7Nrhn
4RUiamPqmfS0HCViugGUmMp+P22Y4W48LmqJmIjKm+J54nZOZ5LQaNp731sIc2SK
i4U9eQI9cjqFnOGgRJ+2o2xj69hxVTSW3Z3LyySSB9FbXbq8xVeX+FRjOM7IuEji
c64laBuQXPSSTbmOF/wqspv6tHPH3M6M+ql6Ihpfkd8fMQoCN6gFMWhvC6FfICQ=
=WdGS
-----END PGP SIGNATURE-----

--l9OvbEp/JYZ/p+uv--
