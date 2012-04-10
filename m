From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm9712: Fix build due to missing
 definition of "runtime"
Date: Tue, 10 Apr 2012 22:34:49 +0100
Message-ID: <20120410213448.GU7499@opensource.wolfsonmicro.com>
References: <1334093587-18184-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3959366088450803714=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78C17104208
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 23:34:51 +0200 (CEST)
In-Reply-To: <1334093587-18184-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3959366088450803714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aQ0PHH3iiKbaMI5N"
Content-Disposition: inline


--aQ0PHH3iiKbaMI5N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 06:33:07PM -0300, Fabio Estevam wrote:
> Fix the following build error:
>=20
> sound/soc/codecs/wm9712.c:482:32: error: 'runtime' undeclared (first use =
in this function)
> sound/soc/codecs/wm9712.c:499:33: error: 'runtime' undeclared (first use =
in this function)

This appears to be identical to your previous patch?

--aQ0PHH3iiKbaMI5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPhKdiAAoJEBus8iNuMP3d4hEP/15iaVSmn2r/HG4ykxU0jjNC
yMl+SZPg7/b4zFXGHpKzWZXBzFwrVKiQQ/ozwVk9ZaD1MK5p8MmQXaHJAPpE703Z
tJg9ftKe0IUbB2A6i5GWkC6xmW3cQQ+OKbBCWlA+XcyC2GKZn4+Pe6vvopgbeG/v
O2gMasF+nqBV1VadZMGT9HrLKIEs6qpiZ1tJHajNdh7JCU3fdgBpefCW5qXwA7RC
LSft3swuS3kWXJGbLK39CgGJk30HSHRTTjekUZOQ0vdcy7bNyGZgW2GGe72fj8JL
8CHHV/jxO2O/tylHeTim9p4XbXrkzeWhT8UwdRvMtRHrEHb9Ey7IeDj8+9jH0ows
XmAip93v1Z5vaH/Jr9qSZu2UMvtj43isUgcSXN0JgJd/Nk2GrikpGdUWnssFDHoi
RdRJ6CAFnvBGeUEhOvpnQeKjz9iL028pcmUfysdllaJ+BySRi/jXlRyT35T3j7bG
hjfOe3vXHQGHjvArNELaA/ofo1qTEjNQRUdNq8ZCqaV8lUCnq42bQdZPNl1dUgo1
ehvGbLJlmNDWxz01cf205CdtkpzfvFZl3wcSi5YYzsSl9FnvJAWVL+cdck96IboG
zilgGAzErSyI/yMbxoNWczpIXAgJGY3kcMUs9N8IBO4MFOYttetGKMpAqtU8Ojo9
ftb4kM8BFHhQQ5CVcL0l
=xnEc
-----END PGP SIGNATURE-----

--aQ0PHH3iiKbaMI5N--

--===============3959366088450803714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3959366088450803714==--
