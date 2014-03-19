From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV
 shift values for ADC, PCM, and Analog kcontrols
Date: Wed, 19 Mar 2014 16:38:28 +0000
Message-ID: <20140319163828.GQ11706@sirena.org.uk>
References: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3740447007239462704=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A08426510C
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 17:38:39 +0100 (CET)
In-Reply-To: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: thomas.petazzoni@free-electrons.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============3740447007239462704==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JT6IvOBpLOBXA07e"
Content-Disposition: inline


--JT6IvOBpLOBXA07e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 10:40:02AM -0500, Brian Austin wrote:
> The shift values for the ADC,PCM, and Analog kcontrols were wrong causing wrong values for the SOC_DOUBLE_R_SX_TLV macros
> Fixed the TLV for aout_tlv to show -102dB correctly

Applied, thanks.

--JT6IvOBpLOBXA07e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKcgAAAoJELSic+t+oim95uIP/jFoNsY6Yw5NTKEb9ZG3cU36
Za3lUqhQtErN58aLtbEWcKL8+F7fATtexJDE/gGl9zX3q+Vkd4dgdCIAXCTlY+8M
BpGB/6Apos1GSddINYhx7Z7nnXedsBWUHNE4KvUcQ43nG9WplcItxt6SiS2U7L4l
OTYOo/jy6HTvkUBl3uu/jE7oJyp9Vg82z+2Qx/loOfTe1kFkmXGSLCgQv3qO3fj8
UANyxNTLZYoLuMv3791hHlJazlJmuG1eXFDlxJ1i3UPF1GfcIu5uUogDCxDoqJwC
akSrqL1rs5dZ5AtVOcCQpPTpcH8PX75tmMkjAG83PVDu2uaIVi0DKnWmnvtXfr5U
U8Kby9ZrpqlnROxJh2uhzUkAsswQ88sdVKEw6wdJ+sJ9TwmBfxiDwHV8EjRVrJd+
B6Yym8DSFoxEPK/4MQoI7rT+P+WB760n96ifhmevs3mRDd1t8ATLrD79VYHJwN0Q
kzgBqTAK62vaMk8zmpeaG8EILKvzXxH2D/2xFp6bBODfwU54FALzPnIDKYS86eW/
heDpBiGGSxXqOhpn/KY08eIS05JNZlFP7klCv0ySf0vmMgiHkupfERJwZXnlJA2u
fQ/SEYOxbmvd3jTCbl97ZWeDVxRng25TVZG8z+kjiCQhtG6J8amy01VBGbMDj179
11tKtiVDY9m/7WxWpjjy
=OznA
-----END PGP SIGNATURE-----

--JT6IvOBpLOBXA07e--

--===============3740447007239462704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3740447007239462704==--
