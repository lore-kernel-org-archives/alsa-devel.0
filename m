From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Convert to using %pOFn instead of
 device_node.name
Date: Tue, 28 Aug 2018 19:03:35 +0100
Message-ID: <20180828180335.GG2414@sirena.org.uk>
References: <20180828154433.5693-1-robh@kernel.org>
 <20180828154433.5693-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5785909535817611445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 41189267741
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 20:03:49 +0200 (CEST)
In-Reply-To: <20180828154433.5693-2-robh@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Takashi Iwai <tiwai@suse.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Carlo Caione <carlo@caione.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5785909535817611445==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8TMLq6GPUuN4DysL"
Content-Disposition: inline


--8TMLq6GPUuN4DysL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 28, 2018 at 10:44:28AM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Please don't send new patches in reply to existing threads, it makes it
harder to follow what the current versions of things are.

--8TMLq6GPUuN4DysL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFjnMACgkQJNaLcl1U
h9BnyQf/cdl8XKMk/yZXqmTYdTxNvRvHBV00zFsFCpmSB2fxFPQl9u0BC/JZSMSb
QJ2GfCxUgp1/j2S8iDUSWGCZG6bq/turgrP2m+ZYZeTvA7wsVduGMBYEVqwurAxX
6XNPCGC2ZrvUV89j1fYc4jxXjTC0vPYWnK6M3sZCKqJKP4CTeRxFDyFdBtGlmHdZ
taXllc0H3Kpp8xU5P3zmlwBW4kErt8XwBb/yj3cN0pbJbXqwrOOUTIFXTf3XFg+x
xM3pTAUEZjyhDNQHg+C6yYv8rpf8oqAeu/v7WLj9q4UsQ0y7x3vfxYmlQe7Qt+5Z
BvxDzb2t7uzOrvhRrEhcRSRs5j+EIg==
=Bsjk
-----END PGP SIGNATURE-----

--8TMLq6GPUuN4DysL--

--===============5785909535817611445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5785909535817611445==--
