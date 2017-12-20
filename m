From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] ASoC: select sysclk clock from
 mlck clock provider in wm8994 driver
Date: Wed, 20 Dec 2017 15:50:00 +0000
Message-ID: <20171220155000.GD17890@sirena.org.uk>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-3-git-send-email-olivier.moysan@st.com>
 <20171214173624.GM9788@sirena.org.uk>
 <43426b67-3546-8422-7fcb-9fa1ff192679@st.com>
 <20171219093506.GD8563@sirena.org.uk>
 <c51bf5a8-27f7-6d76-f4fb-c8884387bdca@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2726965608148170461=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 180FD2677EC
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 16:50:42 +0100 (CET)
In-Reply-To: <c51bf5a8-27f7-6d76-f4fb-c8884387bdca@st.com>
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
Cc: Benjamin GAIGNARD <benjamin.gaignard@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org


--===============2726965608148170461==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Content-Disposition: inline


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 12:42:10PM +0000, Olivier MOYSAN wrote:

> As a generic machine, simple or audio graph cards are not able to manage=
=20
> codec clock muxing.
> If we exclude the management of muxing through codec controls,
> the remaining solution is to handle it fully through clock framework.
> The current patch only supports a limited range of muxing capabilities=20
> of the codec.
> To have a full management of the muxing, I think it is necessary to add
> a device tree node for each codec interface and to define an aif clock=20
> in these nodes.
> Then parent clock assignment of these aif clocks would allow to handle=20
> the muxing.

Controlling clocking through a clock API binding would be good, yes.
That'd solve a bunch of other problems with use of multi-purpose clocks
for audio as well.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo6hqcACgkQJNaLcl1U
h9DFOwf9EFd8OGa3Gc6X94wtf+ww6JRTcI+zcddC51bU18nM/k39xlGLTyCvqCcT
HiTR3x3qQP1rUCbLOiKVIOARAu7JmhQAovhbzib4jJ1wIZdFov5gZecKX4c7E32G
1opjCwgZ8/tU5ClBfDaXvV6xvKEHPnzJ9oyo4jjFKIY2CxJMbwzBF4od+x2qjmsJ
J60JrXPVT6H3LILm7o2Vut4/tlUN3QAHT0K6nYfXAE5OZVYEHQloLJjbax3EpQbp
W6WqneVffaatVdIyUXsZMJyp7DM3EByj26cziJQ2cuyF02tg95qLIjqUmEP/Wxca
0sxBrWK8s8A6o0a0EycnoECWAk2+GQ==
=ML+3
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--

--===============2726965608148170461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2726965608148170461==--
