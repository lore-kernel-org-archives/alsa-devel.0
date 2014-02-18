From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: adav80x: Use devm_kzalloc()
Date: Tue, 18 Feb 2014 10:08:33 +0900
Message-ID: <20140218010833.GO2669@sirena.org.uk>
References: <1392639416-11293-1-git-send-email-lars@metafoo.de>
 <1392639416-11293-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4500100848392688618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DCC09265162
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:32:47 +0100 (CET)
In-Reply-To: <1392639416-11293-3-git-send-email-lars@metafoo.de>
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


--===============4500100848392688618==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvuFargmsA+C2jC8"
Content-Disposition: inline


--mvuFargmsA+C2jC8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2014 at 01:16:55PM +0100, Lars-Peter Clausen wrote:
> Use devm_kzalloc() to allocate the device state struct. Saves use from ha=
ving to
> free it manually on the error path and in the remove callback.
>=20
> Now that the adav80x_bus_probe() function is only a call to
> snd_soc_unregister_codec() also inline that.

Applied, thanks.

--mvuFargmsA+C2jC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArKOAAoJELSic+t+oim9fqIP/Am0SyiQhLAx5ZVFF/QMdGom
RufNmMMfV5kbn83YbIT2WhyuLRd6m35p5eUvUAzNURLaSci8Tve2vgf5/1pU7Gkh
H33Y+kTV3lvYrYI3X+xn8UKUXkLgeW7JxeAf18yKBVAtCdlgTSfdqqLvhdzXVifI
LPlItf+qvlmvykIpD2qHAKQK3xIPrMD5P/IJUhDIYJG9GHACGEbs79SlIDXt95HY
4SwAU3RLrNl2Z0Y5pRG3L5ElC98VtjE40d1l14Fb1K4kr7xoinfggSMdmiumqKn/
i9dnPDw/2jLv4Ayqnl+xJ0ZxpeBxK2cLgZuv86v2U20EgkenOEYyElD+VpxybGIN
WXo7p0nV+AN5tJjyL83Vf+i41Ak4rekA6+HIW8IhXEn5AxZ1bGcyyIf6CfFlpSxc
jqbqYUtV5bUYwxVW6FLvwqL2A1g9swm+gEQMhrEtkx3O8KliccYeJTou8bBU3A3/
w5YxcvFvULeeXcmhIDa485e3ub48lhKwhyIwjs7rsTEvrZ5fBpRwmGbB4gyWM/OE
mUCGherBidMwG2lqdm+HUv4Ii7z2J4UWS2kuKg3Qx75KgCMyTRAvygNtJ78mswUV
Yy4Mci83pyOGfH7K3HgTXlk/sy1OFfhhcocGFn5TM6kfaO+eMf/MrHNqyOtKCjSW
kSHX7IFj5K9kT6NJEIUV
=5Ef9
-----END PGP SIGNATURE-----

--mvuFargmsA+C2jC8--

--===============4500100848392688618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4500100848392688618==--
