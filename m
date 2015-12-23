From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] ASoC: da7219: Update REFERENCES reg default, in-line
 with HW
Date: Wed, 23 Dec 2015 11:38:55 +0000
Message-ID: <20151223113855.GQ16023@sirena.org.uk>
References: <cover.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
 <5233faeef4073f33e2826866eae35e8c9502c35f.1450807642.git.Adam.Thomson.Opensource@diasemi.com>
 <20151223001019.GG16023@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D4611EEA@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDto3OTLsk6uOlQH"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D4611EEA-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--oDto3OTLsk6uOlQH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 23, 2015 at 09:47:23AM +0000, Opensource [Adam Thomson] wrote:
> On December 23, 2015 00:10, Mark Brown wrote:

> > This is the sort of thing where a register patch would normally be used
> > - if you put in a register patch for the older silicon then the driver
> > can correct for the register default automatically.

> Thanks. Yes, am aware of that. Were the older silicon still in use then I'd have
> taken that route, but didn't seem necessary in this instance.

It costs you nothing to do it properly and you might be surprised how
often older silicon turns up somewhere.

--oDto3OTLsk6uOlQH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeofOAAoJECTWi3JdVIfQpxwH+wRsFox3bUYWp/2jo3RfLIaR
XJr8mQkxCKoDTRV8IHR6/UorFr8BjXjaoZnf7LywJXwMOjlH6X/aPLC9VdAO/Ri/
/cd5Yz8+28wDixHce6/vA7exIOn/DLaklFViDYcCwTtI1OVoJkgTEimxmYj7x/Dc
PCtHQWQjDnqBxD/21oQMPUm8ONaIKvmedZ5bjt/7x3sYoaIqkLPK+BoKFoDYCfqI
TLjwLszrcw5I1oi9QYUeSJSceJ36H5kR2l2gLxA1FYV6EtWRKdJ9HuzTotDa/TWh
w+G5ZfrhVpwiU4ghezNiMj1mGZIf9U5CcrODq6S71RGUfsyRmBtcyebPL8JCi6Y=
=H4Ms
-----END PGP SIGNATURE-----

--oDto3OTLsk6uOlQH--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
