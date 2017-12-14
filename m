From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] ASoC: select sysclk clock from
 mlck clock provider in wm8994 driver
Date: Thu, 14 Dec 2017 17:36:24 +0000
Message-ID: <20171214173624.GM9788@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2407842773460160101=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B23B267B18
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 18:36:32 +0100 (CET)
In-Reply-To: <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
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


--===============2407842773460160101==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Content-Disposition: inline


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 05:53:58PM +0100, Olivier Moysan wrote:
> When defined in device tree, MCLK1 and MCLK2 are used
> as sysclk for aif1 and aif2 interfaces respectively.

That's not a valid assumption as far as I remember?  The AIFs can use
either MCLK depending on the system configuration I think.

> If clock rate is let 0, the frequency provided by
> wm8994_set_dai_sysclk() is used instead.

I'd expect this the other way around, if we didn't specify a frequency
then read it from the input otherwise try to use clk_set_rate() to
propagate things up.

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloytpgACgkQJNaLcl1U
h9Bgbwf/eUrYkksw12oV72tVF+EUygd2UaaGc1hsadmCZ6bMOYYZLsA8fibV/xQE
n7KrG8DUrpmD1iAhDr3orh8s3TgYNAb9k99vGmnlN8s+gO0noKpYDmHprK9IqlF5
Ignnpsle3JSyAuojD//Igfckmr6zip8E1QymRme1nlQR+UtHX1ZJgC0QAum6fzFY
RDG1eIqL+Cj5dl9yj9Izhj+dCsthTtIHThGuZeNtBLVz7dQ+txzWI0qISLa/yqKl
8Zfvaax2UI9I+J7cJ1fgtPxv1JN0FGX1MMKV05l1ezmBkXIKlS0JlHn0ccbYmQvE
tz/jTfqM4K49ZGSMV+xLvNawMJkunw==
=ZSzv
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--

--===============2407842773460160101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2407842773460160101==--
