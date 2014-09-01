From: Mark Brown <broonie@kernel.org>
Subject: Re: simle-card DT style for DPCM
Date: Mon, 1 Sep 2014 15:30:47 +0100
Message-ID: <20140901143047.GX29327@sirena.org.uk>
References: <877g1o18ka.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1052125796498110209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B4D6326663A
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 16:30:56 +0200 (CEST)
In-Reply-To: <877g1o18ka.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1052125796498110209==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1hAU+gb7eAuiw2fm"
Content-Disposition: inline


--1hAU+gb7eAuiw2fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2014 at 05:35:51PM -0700, Kuninori Morimoto wrote:

> -- use DPCM for sampling-rate-convert --
> sound {
> 	compatible =3D "simple-audio-card";
> 	...
>=20
> 	simple-audio-card,dai-link {
> 		...
> 		cpu {
> 			...
> 		};
> 		codec {
> 			...
> 			fixed-sampling-rate =3D <xxx>;
> 		};
> 	}
> }

This looks good to me though I think specifying the rate at the link
level might make more sense.

> -- use DPCM for multi DAI --
> sound {
> 	compatible =3D "simple-audio-card";
> 	...
>=20
> 	simple-audio-card,dai-link {
> 		...
> 		cpu@0 {
> 			...
> 		};
> 		cpu@1 {
> 			...
> 		};
> 		codec@1 {
> 			...
> 		};
> 	}
> }

I think here what I'd expect to see is only one CPU DAI specified for
the back end link in the CPU that is actually linked to the CODEC and
the front ends being worked out by the drivers, unless there are systems
where the set of front ends can be configured at system build time (as
opposed to from software at runtime) somehow.

--1hAU+gb7eAuiw2fm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBIMUAAoJELSic+t+oim931IP/2A8UG+oZMb4ULQTtaLh/AeL
hg1ELOxb0nSAZ8fMjpsd5O+pI2EVLmti2CAqeSuOghJd0z7p2ODXXl6WXjH0pNT6
8C5B/cqQQYFQ4TGul8Ukn2VJC8MGMpHTp5OXK/Nm4O99S15IJjke8OZD7+pNhAKx
0Ywarip9rxQqtXN887nNgqbL6SFqObS2UKmiQBwYFkOqIUAIRtpURRiduRbzMq9X
KttyvUTsnBjjna8Hr7TkZT1J67QDF7vj1AMXUboAWJ9oLnVETWQ2RVBy9GunqinA
/diUG2JZ6cPJMjos77N4wIop/Z1Gbr49UsM1XUxvdT148odgl8apIs8mmXY7PmBM
Z+p1xqBKXmY5ebTUu1fM+85DhDdkxnhITrUe4C4X13Bpwpc2skIYNRIBg6RCxdwF
GWSJzanRY03SrH47UyQdOh2z+BOhe9HoAn8A1MQTcFjCTHje2k0iTnWqWQB945rU
q5r2PWCKz7Jsuqu+pfOP3qZG71dVPs49O6T4eBo+gbEunJhQIFccKr5hKNv+JdUO
uUlIzm8I5897XAYf1UXIVgkV7xkKd4lF6ZBVDibeYcIkezTapmYjSUkWWZ0rrjfv
evsvjR+bXv9WcD6Pwg5kCcSYz4T7ugO7OxGHmk4lLvF3taF8QfqCcY/sLLpoHOmT
0Z8CmSgiIapO3UjdwWE+
=uNkf
-----END PGP SIGNATURE-----

--1hAU+gb7eAuiw2fm--

--===============1052125796498110209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1052125796498110209==--
