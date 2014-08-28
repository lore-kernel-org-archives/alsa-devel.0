From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Thu, 28 Aug 2014 09:02:51 +0100
Message-ID: <20140828080251.GG17528@sirena.org.uk>
References: <87wq9vmyyc.wl%kuninori.morimoto.gx@gmail.com>
 <20140826091120.GC17528@sirena.org.uk>
 <53FC5105.6070901@metafoo.de>
 <20140826094211.GF17528@sirena.org.uk>
 <87r403mtip.wl%kuninori.morimoto.gx@gmail.com>
 <20140826105028.GK17528@sirena.org.uk>
 <87d2bmpwi2.wl%kuninori.morimoto.gx@gmail.com>
 <87a96qpqsy.wl%kuninori.morimoto.gx@gmail.com>
 <53FD95AB.6080903@metafoo.de>
 <87fvghihaq.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GzfDEbkz4QNhsw37"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87fvghihaq.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--GzfDEbkz4QNhsw37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2014 at 05:33:55PM -0700, Kuninori Morimoto wrote:

> Now, my system is working well with simple-card by this

> 	sound {
> 		compatible =3D "simple-audio-card";
> 		...
>=20
> 		cpu {
> 			sound-dai =3D <&rcar_sound 0>;
> 		};
> 		codec {
> 			sound-dai =3D <&ak4643>;
> 		};
> 	};

> The reason why I'm tring to support DPCM on simple-card is "sampling rate=
 convert".
> My rcar_sound can convert sampling rate, and I tried to add this feature =
as
> rcar_sound property.
> But, Mark rejected and requests me to use DPCM for it,
> since it can be common featrue.
> Current existing simple-card can't use it, and I'm tring.
> But, am I misunderstanding ?

There's two separate things here.  One is how the code is implemented
(which does look very much like it should be doing DPCM) and the other
is how the DT binding looks - the DT binding is supposed to be a
hardware neutral thing and not depend on Linux implementation details.
If you've already got the hardware described well enough to discover
everything then that generally indicates that the DT binding should not
need to change.

--GzfDEbkz4QNhsw37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/uIoAAoJELSic+t+oim967oP/A3r0e8aU5SqoDnB4y3YuN8z
p6Wepl/8ENcokMMF5JJ43VE5WPXjiKjPogmU3XUgUw358Brmc70+twNNNS58u006
ApUhnOg0yzU0rCiY04+yu8xkkxg4SO4qZWUt775ug2rU2xlA0aHfv9zrhimu9U9u
MT6gMGvmRAbPa5AqPVGufYFWjUGWi3f3LJFBQIabCBJKmoTNahPaawkN/Ry0DUyn
QRAZomlgq8z+qNJj65K6nHSwFmx7SHeSLODpOyzlc3Ym/DbcgX0YXypf9AeKYD9t
a68vj2/qo6I1ftRrrmrhi2dYH3GowiVYZhVwhEeFMOjerRjmaBhV2OjA/ZHbONk9
GBz3oqLI/eUs5w7/q0o96ig5bCMvaOlUsA1qXki7kg8aahSn7ERHw/s9br9UOYn1
o04CwruIB0ali/TymwTVGQzXgqtyMRBXqkAKYJfSj7qa8bpCcP0hoSs1FdY8NOER
oVXr9v+hN/W9icFFxgCXz8jNIVJT7m+LESwegJGbGCUFbXnlp4LnEctGDsHL4bXC
2NMEuLjaUj5gQg56Pe9d62xotHAeeoqnsv01hdUVNd4ihPmLL/20H9EH5lFKL5uc
BT6yx9X6EfqFeLj5GxEZXpc0t+BwMMoz0kL8TS5nYayjt+ZTVMF76UryDbPQNDsd
9qxc98WXuJxxH6iK86nu
=OEM+
-----END PGP SIGNATURE-----

--GzfDEbkz4QNhsw37--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
