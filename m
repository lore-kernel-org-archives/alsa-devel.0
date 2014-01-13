From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: imx: Allow using sound with DT
	descriptions only
Date: Mon, 13 Jan 2014 17:51:34 +0000
Message-ID: <20140113175134.GI29039@sirena.org.uk>
References: <1389358827-381-1-git-send-email-shc_work@mail.ru>
 <20140113183212.22f73787442da8af0879d012@mail.ru>
 <20140113174536.GH29039@sirena.org.uk>
 <1389635351.629972498@f244.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2991495686112311318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D3BB260850
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 18:51:42 +0100 (CET)
In-Reply-To: <1389635351.629972498@f244.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2991495686112311318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3fquP/57BBR2yLsK"
Content-Disposition: inline


--3fquP/57BBR2yLsK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2014 at 09:49:11PM +0400, Alexander Shiyan wrote:
> =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA, 13 =
=D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2014, 17:45 UTC =D0=BE=D1=82 Mark Brow=
n <broonie@kernel.org>:

> > No, that just means that the same problem that Shawn identified affects
> > all DT users which isn't really moving us forwards since all these
> > systems use DT and they probably shouldn't suffer anyway.  Why not just
> > make each of the drivers selectable?

> You mean add descriptions for the options and thus make them public?

Yes.

--3fquP/57BBR2yLsK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1CejAAoJELSic+t+oim9CXMP/30NrOd2ZeEa3Ztu135GpfkE
b2lFM2zVbdyKFpfc9UzYOHDfjty/pRkrAGVZkp0upn8xUE4LUEbnPs1aAAfcFwq3
u21J1k7cUh1hBtbVSuNxALnz1DHHJme9o8gO2AMIyJn/YpHtCr0Ncrwfkjo2DEZZ
j2qRrDDdtoX/9BS4i6rPbxKqil4nFR+LTceG1/spi5bF/BClxPgujHWYDDmYBVjo
TRKh01k99UT0JfgAABhApp0ijzZvl6gbT7qC+fxKn/QO7f8QzqbbFoBXmOT7X9o2
XQpOdr1Ofn8+uf+2z/Oic0uumXQnBDbyRLqv+9+bt2nsPWjYiz0b3JoOMCwZ20R7
bPSdWwilSIiGnVzUkf03XZE42RNEpjRIatQQCdZWlRij9r2zfbQfC29o01sW5xZb
CPXZ997lQ4UmBFpubC5vPEKL9ZB3MM3B//jA/gAv2SrQuxPtRFZ85Cl4VHES9Rhe
KQHcBDG0ceLg5HLU2MU0wPrS0ujJT509lzqqod1ioQFMHipLDze3SV81JKO99v2b
yzoesdwhxmOskuu6aGt1u5dXw3tmHHHbnFNFAsUm8EXRsNXWoGAGorPEYPw0jYwh
3j53g1NFmVBBBBHLFCHTBnTHnGFXCJTpayy8WZMn03s04VCs6eqwxJqfvt1JdWGr
3KiLD+OgI1mwDTnc/RIm
=z4ba
-----END PGP SIGNATURE-----

--3fquP/57BBR2yLsK--

--===============2991495686112311318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2991495686112311318==--
