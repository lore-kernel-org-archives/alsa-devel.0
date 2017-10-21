From: Mark Brown <broonie@kernel.org>
Subject: Re: [INTERNAL][PATCH 4/7] ASoC: stm32: sai: fix stop
 management in isr
Date: Sat, 21 Oct 2017 11:16:07 +0100
Message-ID: <20171021101607.uwnt4wniycthdld3@sirena.org.uk>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
 <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2946829544656077648=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 15691266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:16:17 +0200 (CEST)
In-Reply-To: <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
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
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


--===============2946829544656077648==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7u74fjcsblg3ksr"
Content-Disposition: inline


--n7u74fjcsblg3ksr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 03:03:20PM +0200, Olivier Moysan wrote:
> Add check on substream validity.

Fixes should go at the start of the series so they can be applied
separately and sent to Linus without having to wait for new features.

--n7u74fjcsblg3ksr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrHmYACgkQJNaLcl1U
h9AUqwf/bjjid5cbjGdvnjMp8ZwyhiDJQFTLXUAMIqCxpp+P3oGlPuOcETEc6Cc6
RvTgTV6K3DcQ8iUQ5pFjkEjxUFGSgXfM8VdMsrzJ9SShxx1TbU/GukcIEgC5W/jr
wY7e+M6Gt1XL/PJuVILu9iOHGFYd9ztKEMueDS92sTv9J2gtWDnkZYHFf6ye1YpD
UsNF5UXXcJkj/e4l2xJs40+3v2rJJ7cPy7Qc6yiOa74i2ZQnY1tDAQxrtexVbif2
KMMe0xCl1QOQ/rB5uz4rzsN8O1DdUiMpGzdlefENtAgJXva6WOq2sESs+GGqvn8l
uQD/8o/lNdNkEwZ1gslxkMyPiq35Bw==
=wCWl
-----END PGP SIGNATURE-----

--n7u74fjcsblg3ksr--

--===============2946829544656077648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2946829544656077648==--
