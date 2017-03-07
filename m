From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: dio2125: add dio2125 amp driver
Date: Tue, 7 Mar 2017 14:55:48 +0100
Message-ID: <20170307135548.hienxpgghn4ztanw@sirena.org.uk>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
 <20170306174451.24406-3-jbrunet@baylibre.com>
 <20170307123653.jg7jqe4sft2pqycc@sirena.org.uk>
 <1488892400.2420.26.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8096362252575645596=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A28266EEB
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:56:00 +0100 (CET)
In-Reply-To: <1488892400.2420.26.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8096362252575645596==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="veb6vqchn3vwmbhz"
Content-Disposition: inline


--veb6vqchn3vwmbhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 07, 2017 at 02:13:20PM +0100, Jerome Brunet wrote:

> Indeed, Thanks for pointing this out.
> I have question regarding this DAPM control.
> Here, I put the control in DAPM so it can help with the pop noise
> reduction, but I think it would be nice if the user could force the
> mute if he wants to.

> Would it be OK to add a user control and some logic so the output is
> enabled only if DAPM and the user agree it should ?

You should be able to do something with an autodisable control, or
extend the mechanism to support this.

--veb6vqchn3vwmbhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli+u+MACgkQJNaLcl1U
h9Ak/wf/dgbiWFUrL9lT8qlIbP94qb7jKZ16JbzMH/6QhI1rIH8wgLNjHVtAQJHR
z27ucREyLMTWzCBg4WYUNhVC+shGYLr0GSdqrabkp0aNJyrYqBVJEfqczsycAgqV
Eb/c1/09kpKGatBfU4nKUOsUu4oUZTwTJ2I3vGDE+W1C5+hbYp5Q5sjcKea9bQk1
5NoGSR2Vj7+q9J+8ClY8I0sklcX4cT46HCIvgQNsQbF/weyErbScxUNoRLJdKL9t
N6vA3t1CDzRgkllPjgyGvQ33Hgr3wcwxUyCcVgHF8+6bLoOlwY46oIiMfZf8rj4b
oAAcYPqAEGa3b7hcEnHRQYIXpuXH8w==
=YWHR
-----END PGP SIGNATURE-----

--veb6vqchn3vwmbhz--

--===============8096362252575645596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8096362252575645596==--
