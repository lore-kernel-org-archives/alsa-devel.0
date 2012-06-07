From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC:isabelle:Fix warning message
Date: Fri, 8 Jun 2012 07:47:08 +0800
Message-ID: <20120607234707.GV14525@opensource.wolfsonmicro.com>
References: <1338907281-22442-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6954900391650394478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3336B1045EE
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 02:56:53 +0200 (CEST)
Received: from [116.228.53.169] (helo=finisterre.wolfsonmicro.main)
	by cassiel.sirena.org.uk with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <broonie@opensource.wolfsonmicro.com>)
	id 1ScnVS-0006eh-Uo
	for alsa-devel@alsa-project.org; Fri, 08 Jun 2012 01:56:52 +0100
In-Reply-To: <1338907281-22442-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: alsa-devel@alsa-project.org, vishwas.a.deshpande@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6954900391650394478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e+JRL32uBeeWnrD4"
Content-Disposition: inline


--e+JRL32uBeeWnrD4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2012 at 08:11:21PM +0530, MR.Swami.Reddy@ti.com wrote:
> From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
>=20
> Patch to fix the below warning message:
> sound/soc/codecs/isabelle.c:1126: warning: 'isabelle_regmap' is used unin=
itialized in this function

I've applied Dan's version of this.  As I've said before you should use
subject lines appropraite to the subsystem...

--e+JRL32uBeeWnrD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP0T1cAAoJEBus8iNuMP3dknYP/0dn9z9IxQd9gPfaxCeUmJ3P
/w1SohbHL51b6iSbTRh+/rclD7ZdlP/JvePncVZk/7SVu+RMLqrSzZEZxtJCqHVJ
aTmKJ3nnVWdXw/ovf2UxDm9125R4LnfyfylQctKRVzf0TVg+aOqGRUxyNAU6c9+Z
NTjQRGIuVeMwUk6WpWBaf0Li4pMELW/2jeyDMWU3oQIm0AcolQhrT510WRRIrN0g
fuRRSIkgJdtQ3N06+jQVzwfdljWQ+iXLbBywvNQUheR4ji/MRIQVmGWbfvBpYzN2
9IJIKYN8SsNxb3m1YzDWyqnFJqrQHjjhj2LBp5lKKKrVzqSQfMzAU40FVNWeffJf
EaYgQiUNYX7zduam3DI2dqKOCKgPXmJjbRJw1KheOoQXesxMXJscucNLafJ8JgNx
2ahsoT5KRMTk6gm3nZc9QaLsaDNDb6QE0DgsQBkRH9MfZn+fy5+D3K1Pf27mEnRT
zPOLy0+XdEeTU7l5u5ZkzIvgxKJ4UbLfZBz4jdg0NNPxAO3dVj66SFUI/65YCG2H
KZ5I52+Svlj5QtydKZO6SUWjTQjoAe+ZGjUdg3nldm3ZydECCCHtg5XojriFPO8A
ec3jbPfVOY/zhIOaZYQeyydb0DM89t2a+/nh3ujy9R3sAu+GlPEjk9VDdjNWtE0L
/nSf9/RN+2LyuYuQIcgD
=ZWGu
-----END PGP SIGNATURE-----

--e+JRL32uBeeWnrD4--

--===============6954900391650394478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6954900391650394478==--
