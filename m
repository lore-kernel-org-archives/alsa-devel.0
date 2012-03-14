From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 14/16] ASoC: Ux500: Add platform-driver
Date: Wed, 14 Mar 2012 12:31:27 +0000
Message-ID: <20120314123127.GD3133@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-15-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224840.GM3177@opensource.wolfsonmicro.com>
	<CACRpkdZdZpB+hP1sz-p11Tm=bgS4VjfKWnEJDezHZ7n-kHEU_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2385084640237783756=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6622A1044E8
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 13:31:28 +0100 (CET)
In-Reply-To: <CACRpkdZdZpB+hP1sz-p11Tm=bgS4VjfKWnEJDezHZ7n-kHEU_A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2385084640237783756==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 14, 2012 at 11:50:28AM +0100, Linus Walleij wrote:
> On Tue, Mar 13, 2012 at 11:48 PM, Mark Brown

> >> + =A0 =A0 cdesc =3D dma_dev->device_prep_dma_cyclic(ux500_pcm_data->pi=
peid, dma_addr,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 period_cnt * period_len, period_len,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 direction);

> > You're using dmaengine here it seems. =A0Please refactor to use the
> > dmaengine helper library that was recently contributed by Lars-Peter -
> > it should save a bunch of code and make rolling out dmaengine framework
> > improvements much easier.

> That stuff is not even in linux-next so I don't know it it will even be
> in v3.4. But let's see.

You're not looking at a recent -next, it's been there for a while now.

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYI+YAAoJEBus8iNuMP3dS+IP/11eWmmtxpBpftXq5e8snfPW
s/oNnHVnGNMHVH73tYj3N3/h2vS+IvcDRnTSc/XaWDF0AtOssyfngecCfq9Boe2H
seRZ1OoQv6FJq9iYyY0pRujhFIaD3iPDTlscei42B/DoiGVrVcZp0Y7bX6iGbyYq
R4tZgfc1nccUQTYxiMzxdbmX8Hs+3IQSkuZvZ6n0CW5upYtqJWWY1Eo97/XVplbx
gUWGIpOtdwkB8AvyqMerAnYSpKIwK80cCScQc/FQa52sTaNOxalYtPwi41t4UUOo
/T7wMZiqIatKnlHMTK7SHxGqTLnma0Ttat3jUHxjjF5MaITzNyKnbepuknqfd4yc
ILUnPUdXB1VF0FFZsI4kHv49+/70sSwDMiXDwgmy6Ky7vi+NEtKGjbckf+oGvPVt
2ceX7li8rwo0P4H/Ff0rwZ+rV6cSd1HmZ92AD919KoLYn53L51m9RtL7Dwql/UNZ
ZcZSgNh8k/0FmPutOr+xo+xJncBZpYLiPqUA/ZMpTFw0E89CuoL0RtmyGkR12+by
peLl0+t4ZUCsm1qCjOIolZxEzBKVizg95dRPxj8q2hMjB51pBagpl+5NBAqHWFMJ
YBkBNzxeCdrNeOnwq+YudzLwidBiBPR2ythfywl7kx+W0S6PHsyMrIS8wdOXTf0i
qaIhOCKxmhS1nua1sKKj
=QZTz
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--

--===============2385084640237783756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2385084640237783756==--
