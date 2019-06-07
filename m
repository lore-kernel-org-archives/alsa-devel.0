From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] next/master boot bisection: next-20190528 on
 sun8i-h3-libretech-all-h3-cc
Date: Fri, 7 Jun 2019 20:00:21 +0100
Message-ID: <20190607190021.GK2456@sirena.org.uk>
References: <5cef9f66.1c69fb81.39f30.21e8@mx.google.com>
 <s5hr28gszvj.wl-tiwai@suse.de>
 <8ca25787-fc03-7942-0705-3ec7d88862a6@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y+dl6OcicAkN96vR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ca25787-fc03-7942-0705-3ec7d88862a6@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guillaume Tucker <guillaume.tucker@collabora.com>
Cc: Takashi Iwai <tiwai@suse.de>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, tomeu.vizoso@collabora.com, mgalka@collabora.com, matthew.hart@linaro.org, khilman@baylibre.com, enric.balletbo@collabora.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, "kernelci.org bot" <bot@kernelci.org>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--y+dl6OcicAkN96vR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 05:31:12PM +0100, Guillaume Tucker wrote:
> On 30/05/2019 16:53, Takashi Iwai wrote:

> >> +	mutex_lock(&client_mutex);
> >>  	for_each_rtdcom(rtd, rtdcom) {
> >>  		component =3D rtdcom->component;
> >> =20
> >>  		if (component->driver->remove_order =3D=3D order)
> >>  			soc_remove_component(component);
> >>  	}
> >> +	mutex_unlock(&client_mutex);

> > Ranjani, which code path your patch tries to address?  Maybe better to
> > wrap client_mutex() in the caller side like snd_soc_unbind_card()?

> Is anyone looking into this issue?

> It is still occurring in next-20190606, there was a bisection
> today which landed on the same commit.  There just hasn't been
> any new bisection reports because they have been temporarily
> disabled while we fix some issues on kernelci.org.

I was expecting that Ranjani or one of the other Intel people was
looking into it...

--y+dl6OcicAkN96vR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6tEQACgkQJNaLcl1U
h9Dh3wf/TNLGXITYp6q9mQ9egkequDBS+4Phd+1FUwWoAvAmPXJ1f5U3mBFy/7mT
5ZiqLcBmGCrEJWoeohd9oqBw6vCq9g+qGUKxcv/1qG0eI4kTvLi5Vrq8VvJpzYop
wRcBL30vIj27Z6AlWCEHqzQkFdKo06UiWtvb1GbDgIfpII1pr/m8hfenlcmR5b8j
JvGLkVxJ248cTy73FsK4/RiS+Cb45Dgbrj90jTKP5FT7SHE67KnDCV54K7HRK3qA
5SxBggCaEgEk93RcuwbhhbPIXv8qsNhsrtC6sJpFQ7WM68oeJ0zIkofpnfv85g27
DzUdFQChfcThUIgj21AdnLC/rXxgrA==
=9vhX
-----END PGP SIGNATURE-----

--y+dl6OcicAkN96vR--
