From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] iio: adc: STM32_DFSDM_ADC should depend on
	HAS_DMA
Date: Tue, 30 Jan 2018 16:35:07 +0000
Message-ID: <20180130163507.GE10525@sirena.org.uk>
References: <1517318506-14664-1-git-send-email-geert@linux-m68k.org>
 <20180130150337.GC10525@sirena.org.uk>
 <CAMuHMdWhADAPSnj_34R04Oh_H_puyc0vzx--tpihAaUM4NDMQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6598885211294441214=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 18EED266A74
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 17:35:11 +0100 (CET)
In-Reply-To: <CAMuHMdWhADAPSnj_34R04Oh_H_puyc0vzx--tpihAaUM4NDMQg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-iio@vger.kernel.org, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============6598885211294441214==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2018 at 04:31:24PM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 30, 2018 at 4:03 PM, Mark Brown <broonie@kernel.org> wrote:

> > Once again I have to ask why we're doing this per driver and not having
> > the few architectures that have this issue set something up.

> Because doing so would lead us to

>     depends on COMPILE_TEST || HAS_DMA

> in many places. Is that any better?

Honestly I'd just not have any dependency here, I'm not sure the DMA
dependencies are really covering a good percentage of what's really
likely to be found on these platforms.

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpwnroACgkQJNaLcl1U
h9Ajqwf8CzwrV4U8sSZ0G25bzklvvsjHNQkf4CgeH9Kw6v0OptVeyPYs4tJaPTIm
RTyK/WEMzBVrBk1vyV7WyrguSx1R/aTpdx5G9kPhHsCq+Yt5sXb21iNGZYgyW0Ri
ymakDUq3I9qS9pm7raimmwr5ZYfcFmtXxZyDw0uPI1Cp3vP1g7GHnllKuJLdbR3m
w8Neir7C81QqgSyFGTdP/oin9JcfQ88bddvE77m8kMRopQ8pu42otddhpt36E3NM
fIkVq1nyYYoO9wdb3QYiTrAWYIZFe1KvU/Qu4ZpaAFkt4xdUDZB7+WWcSnBI6qkL
CP4qPBnGnXl8XYa1mOYaTgfixJppCA==
=KIZ9
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--

--===============6598885211294441214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6598885211294441214==--
