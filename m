From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove unused dapm_get_snd_card()
 and dapm_get_soc_card()
Date: Tue, 23 Jul 2013 13:56:19 +0100
Message-ID: <20130723125619.GY9858@sirena.org.uk>
References: <1374570745-32224-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0026988938594756296=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B0E51264FFB
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 14:56:27 +0200 (CEST)
In-Reply-To: <1374570745-32224-1-git-send-email-lars@metafoo.de>
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


--===============0026988938594756296==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3h0UNLyY10zL13pE"
Content-Disposition: inline


--3h0UNLyY10zL13pE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 11:12:25AM +0200, Lars-Peter Clausen wrote:
> These two functions were added two years ago in commit 4805608 ("ASoC: dapm -
> Add methods to retrieve snd_card and soc_card from dapm context.") but have
> remained unused so far. Considering that the dapm context actually has a direct
> pointer to the card the functions also seem to be unnecessary. E.g. the
> expressions 'dapm_get_soc_card(dapm)' and 'dapm->card' yield the same result.

Applied, thanks.

--3h0UNLyY10zL13pE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7n1wAAoJELSic+t+oim98HgP/iKPnK7767gq+OV0VFsEzqsw
j6ipPfgwFh1qn6Xx6NNTN80nqfXRWXANcvHWO2Wy0NgYitb4wi2xE6RZsDooausa
CIzbqgGPkzb2LBn83wnTlNxvFQOqvR3rG6TQhPeFa5kKH3tODjQLdRqAjPQ4vfOd
II/TKW87yh3M1LYUflYikres8wU7doiT66ilvqfojGeLFBy0C91kdMkg7wq6mgFw
xn08+/IX0UqsPPNS0vmj1UWaTAxDcAAwvv9eIudr8JaAIN2lQEg0AshvS8VT9f6l
gqrM31QPmJuryHj8/TZ3lmOGLfhlVtNgDEOCCCJ6p9mtRAlpQH4sYAAP417pmZgV
6H1gXKNxppy5Soy9U/I/1RmggE3T6fmLNaUxqvCzdtllPC77nv4qVP8ai2ut/sk1
ZzNf5MuuHWf3iRdMP/sOBsE7ug0C9seIfG0iaVQ28dmpDHi38UoF2JCLb6sEbEF9
jsZvh0Z2E3jQIUFELQ8QDbZsp9Xf8TgIujVkM5ho2aitP8QE1Na3b8y1zxyG0qaC
+KkAYBbJsZmgdotAICmMynLZ8jknfL7XBvQqT8lNQ+/5NW9tFRKVjSODyK4f0Nsp
uNN7oRfJ42S4fUfSzeF1BvzaEvV68VIM3MM4s2OLS7nN1y4OzJGGADMLlOSXo4lg
wJFR4ZBiZ864CcKVc76F
=vft4
-----END PGP SIGNATURE-----

--3h0UNLyY10zL13pE--

--===============0026988938594756296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0026988938594756296==--
