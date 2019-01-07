From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: qcom: defer probe if platform
 dai is not registered
Date: Mon, 7 Jan 2019 18:27:57 +0000
Message-ID: <20190107182757.GS9570@sirena.org.uk>
References: <1545642133-16120-1-git-send-email-rohitkr@codeaurora.org>
 <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1287588071125759475=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C1F872669BD
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:28:00 +0100 (CET)
In-Reply-To: <1545642133-16120-3-git-send-email-rohitkr@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============1287588071125759475==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jesV4P1FjH8FXPjZ"
Content-Disposition: inline


--jesV4P1FjH8FXPjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 24, 2018 at 02:32:13PM +0530, Rohit kumar wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> Platform DAI component probe is not called if it is not
> present in component list during sound card registration.
> Check if component is registered for platform dai before
> soundcard registration.

Why do we need to do this in the driver, I'd expect this to be something
that we need to do for everything not just this driver so I'd expect it
to be handled in the core?

--jesV4P1FjH8FXPjZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzmiwACgkQJNaLcl1U
h9DQjgf/T0oyN1/MUYlbj/WHJfg5qzDHvFO7pSuwm6jRnkfHq10cSqBiiymFlZeT
ffXyclWvM/TyYKu83AwbKY12XR6E/FYmX7A/xtx4f9hHl4RGkNjZqeEOkwWHFWPU
Da967A58RYhtT+Da+ygBiC4ElQnlXxLMlbOBXWXkO1h8UXHcesl8herw1AwS1RmA
Mtb6OINAR9+azH4wWfRGuwFLNqEbDiMDL8q+ad2q5WHe6KE6t7bLLGelj23BXo1C
UeEmino9DKG0XbNJgkPTWfEBGg/sahv9fqqNGxzgMUl6GhhVuHHBsnqMyxb12XPG
DHVN3hfmzcXom5VwIPGix8MDev14zQ==
=DveR
-----END PGP SIGNATURE-----

--jesV4P1FjH8FXPjZ--

--===============1287588071125759475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1287588071125759475==--
