From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
Date: Wed, 3 Dec 2014 17:25:26 +0000
Message-ID: <20141203172526.GC7712@sirena.org.uk>
References: <547F3C9F.8080102@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T/HD1sYOa1EuYEPI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <547F3C9F.8080102@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <Andrew.Jackson@arm.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Liviu Dudau <Liviu.Dudau@arm.com>
List-Id: alsa-devel@alsa-project.org


--T/HD1sYOa1EuYEPI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:

>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		dev->active--;
> +		if (dev->active > 0)
> +			dev->active--;

How is this triggering - this sounds like you're papering over some
other bug somewhere?

--T/HD1sYOa1EuYEPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf0eFAAoJECTWi3JdVIfQWS4H/jb+jM3Hu9onxAQmpFs87z1p
6dwQRlpzAQjqlJyt6mlCdhv5lEJ7SmMcCxCq9LweHcTscBC/NDsWfMUxqNtF2BHj
R8dnnh8xDVOPgEnxfKkE4zPzptJ+UPPYUt8dAv7AVr9YbZHeKG95VeN5rs5aLuv5
W7pF5RNaUbEXjOAp/QB3QE1PudIXIfEdFtNq9K3cXIAvfjtA05WhcEjYSGyCaTZt
uVc22QjwKDBDfb0paEql+hpdz4XJPKyazcIvPZbxVu/MYlHDAgSnwixeMSgw9nFI
gdW/Htot23p9X+QZs2uIgvia/+Vucbt+ViBwMS554vpglkXIT91XGuCZ/LNpHoE=
=hnIm
-----END PGP SIGNATURE-----

--T/HD1sYOa1EuYEPI--
