From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: add support of mclk clock
 providers in wm8894 driver
Date: Thu, 14 Dec 2017 17:30:25 +0000
Message-ID: <20171214173025.GL9788@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-2-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5272956603471632064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EF05C26732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 18:31:04 +0100 (CET)
In-Reply-To: <1513270438-18523-2-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Moysan <olivier.moysan@st.com>
Cc: benjamin.gaignard@st.com, alsa-devel@alsa-project.org, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============5272956603471632064==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f54savKjS/tSNRaU"
Content-Disposition: inline


--f54savKjS/tSNRaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 05:53:57PM +0100, Olivier Moysan wrote:

> +	pdata->mclk1 = devm_clk_get(wm8994->dev, "MCLK1");
> +	if (IS_ERR(pdata->mclk1))
> +		pdata->mclk1 = NULL;

These should special case -EPROBE_DEFER so we defer properly if we need
to (and ideally log an error in case there was a MCLK and we legit ran
into an error).

--f54savKjS/tSNRaU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloytTAACgkQJNaLcl1U
h9C+2gf/TmIoffIsdWnVIRfpxSlAyBqZ2beewn59NgorOHA5QVzZqevBds3oI1gR
8cNJMzXS6l7qCe5MdUNPfOvC0chWjsMJwDaqOQ05y/75OS7i1SDFrn4PmzpIRHJS
f6VU3X8D95jnTAiOp1rs+08I/q6BCNjTMAqSZBLSu7l0QqmrAt878Vmwl6ir/Hnc
kjyGaHef8FMqOUMIxBIf/gmwKnu/EEHbVsaFPaNb+9YJYOFEwjDzvqohHizemYxt
Hti+2ZhCiEYEyq5l4jdo5J3OOWoxU4kTD+rIHHkAZvP9OHx5fpkt7pqE4EVwlWHc
ja7BlXylJ3xLCZgJO8MgIlQ8zhxYOQ==
=kKuY
-----END PGP SIGNATURE-----

--f54savKjS/tSNRaU--

--===============5272956603471632064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5272956603471632064==--
