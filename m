From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: fix to enable 12Khz and
 24Khz audio playback and capture sample rates
Date: Tue, 12 Dec 2017 10:37:32 +0000
Message-ID: <20171212103732.GD16323@sirena.org.uk>
References: <20171212091450.GA13602@andrea-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4537069509927280172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B363267174
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 11:37:44 +0100 (CET)
In-Reply-To: <20171212091450.GA13602@andrea-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Cc: alsa-devel@alsa-project.org, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Takashi Iwai <tiwai@suse.com>, Adam Sampson <ats@offog.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4537069509927280172==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 10:14:50AM +0100, Andrea Bondavalli wrote:
> H3 ASoC supports 12Khz and 24Khz audio sample rates but the current drivers doesn't advertise these rates properly and they cannot be used.

When someone has given you an acked-by or other tag on an earlier
version of a patch you should make sure to include that on future
submissions unless the patch gets changed too much.  That way the
reviewer knows they don't need to repeat their work and other people
know that the review has happened.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlovsWwACgkQJNaLcl1U
h9A4rQgAg65GKgxHEdIu7fCF55rDfh6pqINp1yg9vocDM/HUk8hDhwdgnUMvHIoU
5IKPfWLoabML+qHDhWHGv7HjxvioYXFj+pyMpmS3QFM7hwZE1ANaB+khRdC//EQR
d0WldV+kTnWzkK0+ItSvgGMxfix0jAV0YfmxHn0c2sVB/N9YBr8jml6yc1fWmdgX
J7c2CyeEYW0bR2Q9w/X9AZB4c8rqVxCqFxytDnlLRBosIXcCjXt/mFQ2gQWQ7m+7
7/Hg5B4cOm6Y6jid8Rlnz2iaASR+NbZLIch5vVZtisX5vmeVe5lqk5S1K9YtnLa3
270Jq2m5EOIvzzRumIV+Glmjvykslw==
=POhd
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--

--===============4537069509927280172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4537069509927280172==--
