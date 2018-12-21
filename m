From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Fix a double unlock in
 pcm512x_digital_mute()
Date: Fri, 21 Dec 2018 12:10:50 +0000
Message-ID: <20181221121050.GE4996@sirena.org.uk>
References: <20181221091120.GG2735@kadam>
 <f8f14c6a-46c2-995d-2df4-4ae821e1b895@gmail.com>
 <20181221120056.GD2240@kadam>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6293002783734069330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA32E267A78
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 13:10:53 +0100 (CET)
In-Reply-To: <20181221120056.GD2240@kadam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Dimitris Papavasiliou <dpapavas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6293002783734069330==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 21, 2018 at 03:00:56PM +0300, Dan Carpenter wrote:
> On Fri, Dec 21, 2018 at 01:23:37PM +0200, Dimitris Papavasiliou wrote:

> > Maintainers, please let me know if there's anything I need to do
> > with respect to this.

> All you need to is reply with a reviewed-by tag so we can mark on the
> fix that you approved it.

> Reviewed-by: Your Name <email>

I've just gone and applied the tag but yeah, what Dan says - there's
tools that can pick tags like this out of e-mail which is also useful.

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwc2EkACgkQJNaLcl1U
h9CHBAf9Emf/6IDm28ipzwOCjOsi6yS5BkX1Fndn2XHu8RVIcDIxR7khhyFPqJig
MkqMs4l4f7jAwsZmL7ngvWNN66tObRni5vCPKHXqJOVXdfmY0fdPRO6KiqKGDRcH
26FjXs+HvqVsF4zKqQqQs4yt7QabV5sXJ0GfFVxAHtfJRA1PUgikOV1dUVy4Pb0d
/uDhxXNgddrtFF1oWrstAjz0lCbyIJ2C9TJVt79EdThU1yarynxNVWT8tCB0psL9
2Q+E79hWhh2Y5cy5NY4O1vqmUqpBIdxCSAYZ0ufis4L+9PoYsrt8CyU0smd+C97H
bi5pmbE2o7SYRh2RWfYSuPbqPDWloA==
=TndT
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--

--===============6293002783734069330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6293002783734069330==--
