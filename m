From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add missing compile rule for max98371
Date: Fri, 1 Sep 2017 11:21:00 +0100
Message-ID: <20170901102100.vh7v2zu53m7z7z7x@sirena.org.uk>
References: <87a82fniy2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6097586673236156466=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7716A266DBC
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 12:21:04 +0200 (CEST)
In-Reply-To: <87a82fniy2.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============6097586673236156466==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gewkqcyqgxgiet2d"
Content-Disposition: inline


--gewkqcyqgxgiet2d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2017 at 04:33:01AM +0000, Kuninori Morimoto wrote:

> It is still using old driver style, this patch also
> fixup it.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/codecs/Makefile   |  1 +
>  sound/soc/codecs/max98371.c | 14 ++++++++------

The changes in the body of the driver should really be split out and
explained separately.

--gewkqcyqgxgiet2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmpNIwACgkQJNaLcl1U
h9D12wf/Tdo8ugpsIqtHtjfkax2cZRvB1exWCyq2ojqsLkR4ALmMsr5KvGS8zWce
zU3fK4+PofFTHIJj7LOp/3T4zMAfRZTzsZBI6GEW1NXdIy6xA55Usq5INhrfBYyL
AQ4oXjY1jSbEUyIvWNY7BxQK2CqiuXNWOW9BrJUSc9PX+mOhTGLExNlNMH0uqSW7
vfrdlajtottb0olg7qR5reGpE30vgwgFPUo08nb/3bIfUbu8t3UqpO0hGgCpMQta
G+JLz/+Q2eaQfzYnMkve5sqD87s5ffz0G1mbKMNik4OsHbK1YM5wT6N1r69wMtR0
9L1D0uv7nieuL8ITK9Nveirqq8plog==
=0eID
-----END PGP SIGNATURE-----

--gewkqcyqgxgiet2d--

--===============6097586673236156466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6097586673236156466==--
