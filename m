From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v2 4/7] ASoC: dmaengine_pcm: add copy support
Date: Tue, 14 Feb 2017 17:16:30 +0000
Message-ID: <20170214171630.qgkyoymxyqjiiblh@sirena.org.uk>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3306803402351320719=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BC2F6265142
 for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2017 18:17:36 +0100 (CET)
In-Reply-To: <1487003909-11710-5-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, olivier moysan <olivier.moysan@st.com>, kernel@stlinux.com, Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org


--===============3306803402351320719==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hicslhhs4zfgzzsn"
Content-Disposition: inline


--hicslhhs4zfgzzsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 05:38:26PM +0100, Arnaud Pouliquen wrote:
> From: olivier moysan <olivier.moysan@st.com>
>=20
> Add copy support in pcm damengine operations.
> As example, this allows to:
> - process data before rendering (IEC status insertion),
> - process captured sample ( sample mask and shift).

dmaengine with copy...  so not DMA at all?  I'm a bit confused about why
we're extending the dmaengine code to have a copy operation rather than
just writing driver code.

--hicslhhs4zfgzzsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlijO20ACgkQJNaLcl1U
h9C+ZggAheP4mEFbWQ3/f5hPBO1PLdptmUMpXbC/tiCkGNiK+TmpEsRkG0KgDbZ3
ybftSnkXa2ayTeaaCYG/MEo4BZM5HRhUY1gSINgV+aLsb858Af16cXkHlYMlbjPj
U4NYhZvDRZ2BLGS3FNwslIsKSv6dj0ACxypyXF+LVpTXShaE0kVqPXznIVOxtJF4
Yc2Jo2LcApERM2ulnkAtmsHDjKClEzMtSzJfAyLcyWvHPAWzfm24ZTfxB9keodbM
DLD80zL3H5dahdUwJAWjxC6T1JXPWR6YQi1NSocvMXv2Z2MHstIhiXPRLEo97zKM
Tu3E4yzY8FYtambuZQwJzUTIOVIdAQ==
=xEbl
-----END PGP SIGNATURE-----

--hicslhhs4zfgzzsn--

--===============3306803402351320719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3306803402351320719==--
