From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 17:22:35 +0000
Message-ID: <20190308172235.GA31189@sirena.org.uk>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3494365092631882546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44831F80724
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 18:22:40 +0100 (CET)
In-Reply-To: <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3494365092631882546==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2019 at 12:59:16PM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Mar 08, 2019 at 01:10:57PM +0900, Takashi Sakamoto wrote:

> > In expectation of ALSA PCM interface for hardware for usual device:
> >  - half number of phases of SCK per phase of WC
> >    = physical_width of sample
> >    = bytes per sample

> They are not the same thing.

> Let's take SNDRV_PCM_FORMAT_S16_LE.  The in-memory layout of this format
> is two 16-bit samples next to each other in a single 32-bit word.  Their
> width is 16, their physical_width is 16, and bytes per sample is 2.

> A CPU DAI can do one of two things:

> 1) it can generate exactly 16 SCK clock cycles per sample before WS
>    changes state, leading to a total of 32 SCK clock cycles per
>    frame.

> 2) it can generate more than 16 SCK clock cycles per sample.

> Both are entirely legal and permissable under the I2S specification.
> Both look the same in memory.

> The ALSA format specification (SNDRV_PCM_FORMAT_*) does not specify
> which of these two is used on the wire - it only specifies the in-
> memory format.

Everything Russell is saying here is correct.  The actual
ABI only affects the in memory format, userspace really shouldn't care
what's going on on the wire.  However we don't have separate
infrastructure for what goes on the wire and 90% of the time you can
just translate the memory layout into a wire layout which works so we're
conflating the two in a lot of places internally which is confusing and
fragile.

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyCpNoACgkQJNaLcl1U
h9Cpcgf+KjYZWUq9crNPi9AQNkTb5BLct+i9KjXTeIg9/qZc8A2LooFE9rpfvYya
p3+PzZ+UlaLh4frZl1OMaR98D+S+0HyA74wSC/ldumVvCWbhD/wM34wk7vCG3zsS
ZUfBznIlTTxtCYK9cgoMJq554Hy4tIMhav8esHrc7ykvn/N3SYvHuqT8fi+ztTHn
hp4z0R3Ngazo+mLrgkeKM2JtxtKMMiZDvyDOKN9XISJJuRwnhLP9eLAYe2H5sLc3
oMBuz0UlYlXUtJy65pyE+lG2zlRubDUK8ZfGUwSQJHJm5J6rowuY+ilC9GgUM2ey
M27UzCJIHu93H4SkecdXnvmv0z8ErA==
=IvuD
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--===============3494365092631882546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3494365092631882546==--
