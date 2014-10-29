From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Intel: Add Cherrytrail & Braswell
 machine driver cht_bsw_rt5672
Date: Wed, 29 Oct 2014 10:30:53 +0000
Message-ID: <20141029103053.GX18557@sirena.org.uk>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
 <c716a6624d4227908ee879cbbc9de6d9bca1a0c0.1414495605.git.mengdong.lin@intel.com>
 <20141028164822.GB18557@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B702FF6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2495696700197723379=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46E6E2604D5
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 11:31:25 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B702FF6@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2495696700197723379==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fuU9j9YCfY4B5HM1"
Content-Disposition: inline


--fuU9j9YCfY4B5HM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2014 at 06:45:05AM +0000, Lin, Mengdong wrote:

> > Nothing ever stops the PLL - a set_bias_level() callback with a handler=
 for _OFF.
> > Otherwise we're wasting power.

> Can we introduce a power supply widget for the platform clock used as MCL=
K?
> That widget can be added into the playback and capture path.=20
> So when idle, the platform clock can be turn off and let the codec PLL se=
lects
> its internal low frequency clock only for jack detection. It's verified i=
nternally.

That should be fine also, it's just usually a bit more work to add all
the routes for DAPM.

> Or we don't change the code at moment, until we upstream the platform clo=
ck
> driver at first?

> Which way is better?

Well, currently the code to load the driver is also not upstream so may
as well have the driver be what's wanted!  But it's not a massive deal,
main thing would be to get everything done as part of initial
upstreaming instead of having to come back and work on it again later.

--fuU9j9YCfY4B5HM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUMHcAAoJECTWi3JdVIfQbF8H/11uRIXJwyViykJFuY3NlNxM
szJhMLyEcLutWgnIvTpsRSilDffuM0Gh05h2lYwZjTIvaqlR5z0QqVdw1RZkRMBa
Xe02vrDLc9ewXR1gieUwXj97z+vwLGPeWECu7i2RnTX3S2mxaxfG6WH7WaZhiTsA
fxHBdOcTdR5QkcSQeVr4eZvS24Ou6OIJJzUsig+RQEXdQ/0HU6OmRrkUeKxiaJf2
4HKs7Ji/GBOUUS6coQbSCRftC7ULG0QiZhVoPE7czeAgwnuGDnAicOOLh1YPfqgD
safJ5hKtJFObp5NKyKE42A2leR4NfoAkESXd+22FNLBIOxp2dYZxTIV9+3Cvi7s=
=QsJY
-----END PGP SIGNATURE-----

--fuU9j9YCfY4B5HM1--

--===============2495696700197723379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2495696700197723379==--
