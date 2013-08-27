From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: Pass card instead of dapm
 context to snd_soc_dapm_new_widgets()
Date: Tue, 27 Aug 2013 15:42:09 +0100
Message-ID: <20130827144209.GT10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2734455079683355618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A31512652BF
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:42:19 +0200 (CEST)
In-Reply-To: <1377611461-3638-8-git-send-email-lars@metafoo.de>
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


--===============2734455079683355618==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FT/vNgDLxVq4t/AU"
Content-Disposition: inline


--FT/vNgDLxVq4t/AU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:51:01PM +0200, Lars-Peter Clausen wrote:
> snd_soc_dapm_new_widgets() works on the ASoC card as a whole not on a specific
> DAPM context. The DAPM context that is passed as the parameter is only used to
> look up the pointer to the card. This patch updates the signature of
> snd_soc_dapm_new_widgets() to take the card directly.

Applied, thanks.

--FT/vNgDLxVq4t/AU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLq+AAoJELSic+t+oim9fZYP/jJDwMM9BDFy6cEaMyYbzBZ+
SyHXhhbzpjFK2k+OZGeeoOAqJ5SuVb+7q/sya+zzjwYS4HG8LOvuKBijUQA39BXs
mEaXyAjNm4SODTkfHm4UAITgcqdJ10HQo+yqyUbsxTrSm4KKW050V6scuPkFZlqQ
7vj/5G5raEu3P4b0Y+rjNuRc8XCMWO/buxcxmr5VZ1x7ZDb1utrHfvdFpMvKrDNQ
1M7kDbkUMO2qMVAw6Qw2egHA//TXBzueVuRa+vyr9snABHPahs3haQxvaQPkdN5o
4+74qkIDYmvkgAmi0W4zVgwBUwFeq9O0rOzXN0OufzGlksXApN5v1ONlQe2AOs8L
haymmb8DQnXW8Vu+fSrtMFnxR3IotTUY4yZiqfOtxt8WLWSGsDak+oyOUZj7myxb
xNyVz7GsL5LVGJY6TgUgNOps60zBP7IqIZSbrvJSw+XEq2b3sHDidqZMxREnur9o
yhyY0IFusRHLqLstJoLv6hL/WKZOMFEr+qCnJXTcHBSxs2gOakuDDpHvM6b6ACoL
99ZNsbg6vZnY7V+e5DbrxRT7KCkWGKrEY96ssYbiPHVY+p/JyB40Qpgwi2r5gVHU
hkl6vOYALOKQrfIb0me1Cfk7cHLI4KLd2AoXn05t7cEvgRj8pftL6llS4BtKkvU5
6wLS53zKxMnPLA1lUKA1
=CPoE
-----END PGP SIGNATURE-----

--FT/vNgDLxVq4t/AU--

--===============2734455079683355618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2734455079683355618==--
