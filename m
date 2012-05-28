From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: use PIO handler if DMA handler
	was invalid
Date: Mon, 28 May 2012 16:13:57 +0100
Message-ID: <20120528151357.GM4032@opensource.wolfsonmicro.com>
References: <87pq9skaun.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6205282790574556847=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A9B43243D8
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2012 17:13:58 +0200 (CEST)
In-Reply-To: <87pq9skaun.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6205282790574556847==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Content-Disposition: inline


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 24, 2012 at 11:56:19PM -0700, Kuninori Morimoto wrote:
> PIO handler is not good performance, but works on all platform.
> So, switch to PIO handler if DMA handler was invalid case.

Is this needed in 3.5 as a bug fix or is it a change for 3.6?  I'd guess
3.5 but I'm not sure.

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPw5YuAAoJEBus8iNuMP3d6k8P/2EB33Ln640k44/LWbeThc2h
lkKRx5C496uAFybXrmjsuuQPOKU4TMslp9jqGHf/UOXj3VdbdM69ANpbaTFuELf0
vXZ8SfznC54lulOrLkOYpuCZCH7Eb+t3JFpcN35Ken4lUwwECvM3riYHbpF8VXa3
JA+QYm5BjDhjuAj0jgJWEij4227K2W+J0Ue0O0evI0sL/eAjsWE97NDUfliIAR3m
onfyDPNsvpql9Tb5VmLXs5gwMiNRRQ7uKhU9kX5aYBc8ig+6y88MNkhx4d8Iq5do
mweUuFNxQSqDQVpAcSNxRlJm8hM4ssWJUOEYB3yqiAd/2AFcK9TD04swboZ291gs
aVKb0Dtiz0cnbtpTZE10ITdW8gWtUbgxem832apYIuAsB03Lr3RQPn23kQKKUCwU
xhb29cDpfOmwrKbnEK0fbg5MdL2HCRbZUNNFuEx8vbvZlz/GldtTUjOaKUuonCq9
PeUZP9pgMAOLmoj68me3V6t7zJWlqXshqqaBK85hdoebl9myFL59v11G6EvOhev1
Y/I8jkDyQ7zNnTHdC/tmS3KAXX5N3JOwaPMDn8pqbJLZQe2TXKK9TTWwNpj/PvbP
hd6K2WJoBH0nHeNA2PO8XT7GnIHRArbMpnZU3UB73TJqE/U9iHr3XTuSHq4DcFlX
1MlxP+VL3EQb+anhIi2m
=nXSA
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--

--===============6205282790574556847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6205282790574556847==--
