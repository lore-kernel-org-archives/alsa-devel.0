From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Use dev_set_name() instead of
	init_name
Date: Sun, 17 Aug 2014 08:53:26 -0500
Message-ID: <20140817135326.GC14537@sirena.org.uk>
References: <1408267715-19237-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1851450131124397049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C07B265083
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 15:53:47 +0200 (CEST)
In-Reply-To: <1408267715-19237-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1851450131124397049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 17, 2014 at 11:28:35AM +0200, Lars-Peter Clausen wrote:
> init_name is basically a hack and should only be used for statically allocated
> device structs. For dynamically allocated devices dev_set_name() should be used.

Applied, thanks.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8LPOAAoJELSic+t+oim9nmAP/1mpEVHqYCNK4I7Rc2ogmt3h
8YPm6D/LSbig//MMiQ/1nzrZRMh6AOe6MRZVUIRPtev9zvAQYuqVSLIr2no+UAZp
XcN0ugdH6JEuU3UjjPIxg5uusdz3TmS59lutwqy7E50O/XSEYD+Z0qYLOegzC1Dv
ZPlDKm0s+03F+rFwKH34AFVwZ52MJAoeXLsw3K5n5I23aX7SdXzgSQw1xnpX5mJF
Uk2Db7AlbzJ86BzlMq5MlkjDTGl6W8hlEMNeVoD8+q1UqklQ3HwgV9urpI8ootFx
b8hskdijToNyA5Y7VrB4j9K6XaNifS8FS+HE/nTp2ER9mxOJ/rZfE71xvwf2u8t2
DZcih4eF+fhCVwJdg4GT/s5e3PmHQy6NW8AVICTfLqyQ4wNDLsmoPsFUHX3CwmhC
anHCH7EcpPCnnN6W39TXRyPlnlxFEobnzUHgehlSVmESLl5dF5D+D64Pf3U7AKvn
VSGqhfdJwscm4ZMUKcWyME/KbsMWfXzLBgmCNI+ev7CqltjHOmBCdxK9pqiLB5S5
kz0svLeR7Mp/O6mYEw9EhgaOumpVLgoEnGbozqfX+aei8r48AMWUBKT7av4A1sg5
d1FjwQX62XxRllYcmYgod+XlL+NZtxDxywQ6P1POPQVqwDRGj71aZ2cb9n5k6NTP
6CqDlC5mNgpdDr7kQ0UA
=6JCJ
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

--===============1851450131124397049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1851450131124397049==--
