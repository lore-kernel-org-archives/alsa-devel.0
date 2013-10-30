From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/9] ASoC: rt5640: Fix ignored error checks
Date: Wed, 30 Oct 2013 09:49:24 -0700
Message-ID: <20131030164924.GI2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-9-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8958568056566709919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BD98265555
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:10:11 +0100 (CET)
In-Reply-To: <1383118507-21503-9-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8958568056566709919==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Content-Disposition: inline


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 08:35:06AM +0100, Takashi Iwai wrote:
> The negative error value returned from get_sdp_info() is ignored
> because it's assigned to unsigned variables.

Applied, thanks.

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTiRAAoJELSic+t+oim9l80QAIcXpFH7pPBeZUZ8pIRxmPEO
BcrLDbn1a9js3cYASNrgHSjiYRVeTA/LWXtp6mxDcWDUNT6wdsZWOGe//JIEXIno
gd3BcPx8qkBLJYGMmPY+8ZcN50HajJtNc4xgcsZ+5Zi7G+n5Ld/geCZd6O15YYl8
80i1WGfdAMxzQsqAcHcgvlR+ig/xp9Apm0WgYAH92i3LzcH0e6bh2iqFg+n7mPu/
Cpaxfz0EFCfgL1cQfU8m/dRo5ZqnyBkkcBWv1ThDyPhsiTSa9+f3m2irMTXLu2S7
pRH22ZhccijO03Oox/TrDlp5nnc1Vx0LmRFdm+Lz1qdmXIN4dIlmi8lNs8inrNRJ
op34JSo6UsTwt8Hwl+wHXUa6LXTSo30UrP8OqNOMzrwz+K8sJhf1o0GkePBtsojN
Pv7UZXJtQVR5NJ+smq03Ixmwyqs3eS3TsTziOq3DIzgiOmfvjLbyRPeQMtop10eL
GW3reMIS5MkvkhntMj6z3ZeLxLqEe2aUToO+M+r9OkfKSxExvqA2kzuGstKgoDxG
XgDbTpDrDY5iHHHeEPBWr9xxlZ74zGf/KuXCJuoAa5Sf0k2Y+5Ds1MT2a/STFkyR
MJMn2kJjMF8CbwKcbWt1HR7jAR+LEADMESASNIgQRfHLYxIslP/QqTidziuTay/3
9jb6nYe3DpekmK1KehaT
=7iyw
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--

--===============8958568056566709919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8958568056566709919==--
