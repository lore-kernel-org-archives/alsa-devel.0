From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: enable SRC setting via DT
Date: Fri, 11 Jul 2014 13:30:26 +0100
Message-ID: <20140711123026.GK30458@sirena.org.uk>
References: <87oawzum8z.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9200696261999528692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2253261A73
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 14:31:24 +0200 (CEST)
In-Reply-To: <87oawzum8z.wl%kuninori.morimoto.gx@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============9200696261999528692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRF4e1IEQp0HoEFj"
Content-Disposition: inline


--BRF4e1IEQp0HoEFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2014 at 10:36:30PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Some special board wants to exchange sampling rate
> for special codec (or for very simple DA/AD converter)
> which can accept only 1 sampling rate.
> This patch enables its settings.
>=20
>   48kHz   --->      48kHz
>   44.1kHz ---> [SRC] ---> [codec]
>   96kHz   --->

This is something which really should be implemented using the
frameworks (DPCM mainly in this case as previously discussed for this
and other bits of the hardware) rather than with something custom to the
driver - we already have a way of forcing a DAI link into a single
configuration, we should be using it.

--BRF4e1IEQp0HoEFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTv9jTAAoJELSic+t+oim9CLUP/3qcxCFhomeN5tlSWhJB4G8W
vcQut64D8vW2OF0mEAQOB6X+9WG4PUUsccZfbVzTPGc3BMt1k95QhnxmDJecCdap
sLQVYHYcadf+7MaXX6wJEgYvnBHWo/AdFx/T5hUy4pGUTL/pliLFrcnxKWYxORDQ
1rQi2in371EtXN/dbk7VxphxCUFdb8ajKjVGDjEtGKJmWsu/6Mq5qoG2rbXaflOV
lrecjNw9LHx9a6mL7UGANwcW4mor8hx1lRgBtqvVWqkrcUXKDGvbiy3gsO6ojXf4
nP1BiyL+DSlyM4s/5hEvApjMwPQ631KQzBPcDxv21547oapd+WQlG0noThZ5iBU+
x8eTR9mE6xY6vDTRJJM2vFAk3F0XKrVztEmFSF4NH8K0KpweLbVe/PvNnKFauZjd
GLn3tTue5Abmetli2AqMEh9IdcftLut1J4KMYsz45zV2qo4gdkUtONMlaG8UxPZy
C93nbx1lvmFPOtNDIDPjfBeDPHNTHr5kXoLgl6LM9k7tT+Jsqna30Zs6FyP/sucU
SWn/x1VZB3u++72+5kjHZ3giO4Texdg14AhIyM7xGG9t70VUnZ8rHmUoXxQ7w8Wg
2iGASGvdmFHbtrd1lqWaQvPaZkjA4QMzSFLn2NABiX2lBczwpIrHcRJvcvZhJBIQ
e0zR0M+CJBz+9vGA0umK
=t7rW
-----END PGP SIGNATURE-----

--BRF4e1IEQp0HoEFj--

--===============9200696261999528692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9200696261999528692==--
