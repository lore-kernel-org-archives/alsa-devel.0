From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 13/13] ASoC: stm32: add DFSDM DAI support
Date: Wed, 29 Nov 2017 15:37:48 +0000
Message-ID: <20171129153748.awllz4aoziaxpk2c@sirena.org.uk>
References: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
 <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0396587120412731283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 03E6D267426
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 16:38:39 +0100 (CET)
In-Reply-To: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>, Alexandre Torgue <alexandre.torgue@st.com>
List-Id: alsa-devel@alsa-project.org


--===============0396587120412731283==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ubr6w2kr5kkkan2b"
Content-Disposition: inline


--ubr6w2kr5kkkan2b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 28, 2017 at 04:05:57PM +0100, Arnaud Pouliquen wrote:
> Add driver to handle DAI interface for PDM microphones connected
> to Digital Filter for Sigma Delta Modulators IP.

This is basically fine, if someone could send me a pull request and the
relevant patches when the IIO stuff is sorted out I'll give it a final
check and apply then.

--ubr6w2kr5kkkan2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloe1EsACgkQJNaLcl1U
h9BVlAf9GgCBlhd0NGfdwnmtmo4I9hpicJhKkSm5CoRoPoSVZrjSoO+hSxQim9ea
mslKawzNOUb5yJkXpmiYIXq2AKDsZqTNTPH5s1MsUeeGvOsVynPjFD9AdQvwFY0u
kCz3DrTRH9eijZ4/3yUhzNZE6xE810JKKfMh8/GVO8JU/WzWLqfQW/hJNB43JS3w
47beIOvNyHWeqoYOPqHasndk2Z7vKX3StMJqXBm2aND4V2S/sDbPr5Ibxm+pxKBn
bK8i6+fP+8nbW00narB67Or4n1NUbE6o0wDFwyDP+Hqk/VLVZiDOGFgMpD+IBWw4
lF0HSawOKJHYRKjx6uwUc893stEjQQ==
=9NM4
-----END PGP SIGNATURE-----

--ubr6w2kr5kkkan2b--

--===============0396587120412731283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0396587120412731283==--
