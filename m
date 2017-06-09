From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm: Add new widget type for
 constructing DAPM graphs on DSPs.
Date: Fri, 9 Jun 2017 18:53:33 +0100
Message-ID: <20170609175333.6ift3olr3thobopr@sirena.org.uk>
References: <1497021829-5680-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7731753404220782570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4BD3267695
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 19:53:39 +0200 (CEST)
In-Reply-To: <1497021829-5680-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7731753404220782570==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tmbxkeqmklmmtgxf"
Content-Disposition: inline


--tmbxkeqmklmmtgxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 04:23:49PM +0100, Liam Girdwood wrote:

> Changes v1.
>   o Added some documentation.
>   o Split codec widget into encoder and decoder to avoid confusion with HW
>     CODECS.

Please put the inter-version changelogs after the --- so they get
filtered out when applied.

> +Pipeline
> +	Collection of widgets within a DSP, can represent a sequence of DSP
> +	widgets and their collective configuration.
> +Effect
> +	Widget that performs an audio processing effect.

I'm still a bit unclear about how a pipeline and effect are different
=66rom an ASoC point of view - it matters on the DSP but from the kernel's
point of view a pipeline just an effect that happens to have a more
complicated implementation on the DSP?

--tmbxkeqmklmmtgxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk64JwACgkQJNaLcl1U
h9BM5Qf7BZEHZC7HnkSCidJ6AftDpma9s0N+cCSf9OiS+WWn9icRwwnPuK8YMnk/
Cudvp86pGTuvfuOcWrlCuvirZN799Xp1+18UdY85eIUeqBNSblSR+npVxzUHw9W4
FYAPVrxfNmuG32gHfGU2peShm/5E0tGbtLf0bb6co/nXSG8It6mq7Vzo1ORB+y74
4LKNKJB+H2BrCGWMQ3GZ7UtGzvhgSti4U/ANovJapYjUjUMKnaPqDmJOMpfPVqSq
7rWHv5WnYD6OrVjQKkek/f4hZa1KYRmwrFxB2SoGxb5/bSzFGoUHj8rbYf+CNPa/
1amcX1Bm2vqxBgz5a+HXiobAL1WTgw==
=bPiD
-----END PGP SIGNATURE-----

--tmbxkeqmklmmtgxf--

--===============7731753404220782570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7731753404220782570==--
