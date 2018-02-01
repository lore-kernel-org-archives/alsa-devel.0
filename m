From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: stm32: add of dependency for
 stm32 drivers
Date: Thu, 1 Feb 2018 14:24:55 +0000
Message-ID: <20180201142455.GB10785@sirena.org.uk>
References: <1517475281-6444-1-git-send-email-olivier.moysan@st.com>
 <20180201091012.GA10746@lenoch>
 <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4467705364507342594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A411266D71
 for <alsa-devel@alsa-project.org>; Thu,  1 Feb 2018 15:25:13 +0100 (CET)
In-Reply-To: <3bd3ba89-5c69-4485-c913-ff1c1ad67190@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier MOYSAN <olivier.moysan@st.com>
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ladislav Michl <ladis@linux-mips.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org


--===============4467705364507342594==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2018 at 01:19:28PM +0000, Olivier MOYSAN wrote:
> On 02/01/2018 10:10 AM, Ladislav Michl wrote:

> > depends on (ARCH_STM32 && OF) || COMPILE_TEST ?

> I can find in many configs "depends on OF && (ARCH_X || COMPILE_TEST)"
> This seems reasonable to me, as the driver always requires OF=20
> dependency, regardless the compilation context.
> In fact, I cannot see why OF would not have to be selected
> for COMPILE_TEST.

There are some OF functions that are stubbed out when OF is disabled and
some that aren't, if the driver is using the more obscure APIs that
aren't stubbed it needs the hard dependency but if it's using the other
bits that do have the stubs then it can be compile tested without OF
being abled.

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpzIzYACgkQJNaLcl1U
h9AyAQf+Meui41IfjGEXX68Ml4jX9krdGjzE3bdVK6etUerjl4R1RgKGvB2cXyeI
u0NVrVL4We94NUHB6jVnZPOPkRmIOWHB15TkJd4Zp9Nc6tObQMmn0tJsuU6TJjer
3PE342uRbyI6Z4LuXjSbZI7iiwCdgYxVFVF6cDKNzKbaPTUqyNLwDHnmVIXxd8X5
LC61ITMnH4/hDPoKSep92Uv2FgDpydIXs3RINSLKH+fbisw/Cm756990anK9t8EB
ffP0QSbfQoDWN+FHul00zYhSOpv9BqJEfFhaFdLiI6k5wTgRTs54w9xJWfzPYNNL
sdqvOLxUrnVcx7I3TIp71+8KNy44XA==
=Dn27
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--

--===============4467705364507342594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4467705364507342594==--
