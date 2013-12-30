From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/19] ASoC: ep93xx: Don't set unused
 struct snd_pcm_hardware fields
Date: Mon, 30 Dec 2013 13:59:58 +0000
Message-ID: <20131230135958.GI31886@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9006292560797225759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 158D72625D3
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 15:00:01 +0100 (CET)
In-Reply-To: <1387545625-19240-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ryan Mallon <rmallon@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9006292560797225759==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZaBLw/ITdVUrVb8x"
Content-Disposition: inline


--ZaBLw/ITdVUrVb8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:20:11PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--ZaBLw/ITdVUrVb8x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXxbAAoJELSic+t+oim97HoP/126pT29Ja07UJANXB1Gyxr1
UcxP+W6L6jNgiY3Yi78U5vtkw6ePkGZoH9CAZblEc9DnfwfQ9zfRAVvia6rAY95o
qR8Hn6ROdiU8Kv1flEktElLbKPE8S1gz3qVHl04BdWlk9cZtHo3tjx3bgbsqPlrY
JuURQ9bDv0FVR2MIOL6aIYdjATR9A1V0lumbJjzanMx9Oio7IoBfJDwKDqssaJSU
hhfd/GTDR9jRaB2QVa8c41Uga4ozT3gFdWvRru7RBBOgl8OpjtisMatw109KY4nx
Y/PGXgqkVrbciSQyXAW++9XGP7PfWZWeFPco4StsaDK9bas29o/6tpf+NtXRzdUe
6hyM0508FACNFv+LRGFW7guSsHqPyqyK4L1QvMVzPV1YnKebLz4b06FQxEWKlCoJ
xqbV0NZ0swQZi5txetXD/mYLMPfkGKEtdGiJBMRiTNByD9YhFZBdvdBMIeb27NAp
HYW6F5l7vprGoKPtXVp+qCpB5HmjJj9NyKixozL7AiT8M4D7NqkpNRtIk4TI1C18
+gbUdYocXoKwUDQtkw9uwyWX+KM0A3P93VN1YrSesMY+qW5zDebMsdn/4EwQ2kOc
X497faGLO5SEQzngbdOwNsfXgOKmUi4CUT8N9XrWaUNcGvNrHRhNsWQsYDlUPP8f
VxO5eoA1+du78y4iz5M1
=8afb
-----END PGP SIGNATURE-----

--ZaBLw/ITdVUrVb8x--

--===============9006292560797225759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9006292560797225759==--
