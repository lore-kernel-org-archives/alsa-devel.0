From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sta32x: Fix cache sync
Date: Sun, 23 Feb 2014 10:49:31 +0900
Message-ID: <20140223014931.GA25940@sirena.org.uk>
References: <1393090037-8824-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2924215076727667584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 350F7264F4A
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:32:11 +0100 (CET)
In-Reply-To: <1393090037-8824-1-git-send-email-lars@metafoo.de>
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
Cc: Johannes Stezenbach <js@sig21.net>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2924215076727667584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utUizcr4eQAkV3Ky"
Content-Disposition: inline


--utUizcr4eQAkV3Ky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 06:27:17PM +0100, Lars-Peter Clausen wrote:
> codec->control_data contains a pointer to the regmap struct of the device, not
> to the device private data. Use snd_soc_codec_get_drvdata() instead.

Applied, thanks.

--utUizcr4eQAkV3Ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCVOoAAoJELSic+t+oim9ffoQAIsmZT1L5o5tTGnFGRyCrkZa
NMDtVjGtjrTPn29NBbgEsEeOwNd88dvoEwawKa0Iw8dtVDqRLzbiUbH1+zIu7Nep
TfbcL6N13lBy/fF4iwXqhULUFcdh9ZfVDqLoBQLMUEYHOKXsTVHaq7SvemXLclSe
aTXFBlf0RiyLs3NVMXnHJwQh+IwjFhNqKyOh9dPhZbCKL8e62tk/RzgcSmVXdj51
UtFjbHdSGNx8Zn022gKftvK2ajhpQdzAoU7J8+g0g84YVtkxqscnzXTO6QMhdsbU
2HS6kFYlnaIaX8aYW+zUi16iRbD1VopauL+vdSTz7qEjLNQkXL256HEXgCe/TDG5
5jIAyKd2kf5+cFcN2+DkC8JfbbtRdG/feAwoG5raEirWkKLru4iGfu57CQzdo4Of
wu9WyeIi2u5TgJ4NlAVqGIHj40THChi1OPXMKaIRO0rEFF08ik/Y7MtzhOW+Tnvo
GKGjQZeA92p/WXFiOzmiG+XkKF5PfAuAO2PMNQFqEPC0xgA45sekcqqDk79qGOs7
//+Gnfk1Tn1A23VzQnwZQlwRvvS7VLIlJ4ovi2FimBDL2Hazc1arJKhfYIYl1BsY
G4XvI4tkcPN2P51ckbIPp4hVRCbGlJHrVQLZtAvXNJP2Y6pa5I/gC5Xmurk96D6G
MfmF41oXqfqV+VyQGSPG
=AwPW
-----END PGP SIGNATURE-----

--utUizcr4eQAkV3Ky--

--===============2924215076727667584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2924215076727667584==--
