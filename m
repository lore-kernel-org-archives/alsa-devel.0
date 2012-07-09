From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: tegra+alc5632: Swap MICBIAS1 and
 MIC1 dapm widgets
Date: Mon, 9 Jul 2012 17:44:41 +0100
Message-ID: <20120709164441.GJ3934@opensource.wolfsonmicro.com>
References: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4250962857024083605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 15EAA246ED
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2012 18:44:44 +0200 (CEST)
In-Reply-To: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org


--===============4250962857024083605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qo8f1a4rgWw9S/zY"
Content-Disposition: inline


--Qo8f1a4rgWw9S/zY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 07, 2012 at 03:36:29PM +0200, Marc Dietrich wrote:
> From: Andrey Danin <danindrey@mail.ru>
>=20
> MICBIAS1 is an internal widget. If MICBIAS1 is connected to the board
> driver instead of the MIC1 ASoC core, it enables widgets even if the
> capture stream isn't active.

What exactly is MICBIAS1 then?  It sounds horribly named...

--Qo8f1a4rgWw9S/zY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP+wpUAAoJEBus8iNuMP3drS4P/0HH/cGzEQ0JxW4qHEoBdFYF
zVavZM+oynZOY8eQgzI3VRC8CvHqQ/mr5uTMVZBPnOAW11CiPoBW8MHese/uHV/V
1Zw4BJYypfdSNwzijIpj20gJlzp7HPrBZm4s/SPw69RPv1H9K5Xih9bF6X9brnfY
tiJbebor61RpKAi8vzeJUwREiP9wy8wt7IVE5kGwpuWh60LADko3b1NavzE1L72s
B1OR0RCsG32ywMQg51YSwdLwcglcjjpcVlbpY14UTH0WaF1bo8geSFB+7F2uWRkj
Z+9WLObxEpc/++DycuVSodul/5J61JSDGe2iED4neyK/M1eaUjAaQIFREn50FJLu
cyMo/tXEye3dw3ENAR3v4tLdxKa9rtasFMMP1WHllC5v6nq5/gjy3Q5wxsI+NPw0
dM5VknCPnz4AZJ0qhiuj42bEkbTXWPGENaT2Hu9U7NafdJEKHIpWfvSysp4a6+Ac
7A23taXhIslH5xEzexXUwMDovEu5DezxUM0hxdqOYwu3soy3u8hv5G9iDHu6w39+
XaWQArtMNVfzaPf3l4uHyZHy2eeaOXbyhuseqXs1iDikC5t6LjfjdTLayCziBK0E
oTgXYfinEDdqAdrRxoIh4YZafIUYEjyDXCgaaARw3WOTwuWU5TbaswoVzIEDFiq9
I60cGHNhrIzl98Qvdsfb
=EMFY
-----END PGP SIGNATURE-----

--Qo8f1a4rgWw9S/zY--

--===============4250962857024083605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4250962857024083605==--
