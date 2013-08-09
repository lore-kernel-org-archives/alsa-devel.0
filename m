From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: change widgetsequencefordepop
Date: Fri, 9 Aug 2013 15:58:46 +0100
Message-ID: <20130809145846.GD6427@sirena.org.uk>
References: <1121E117AD4ECE49880A389A396215BB935C692E81@rtitmbs7.realtek.com.tw>
 <5200DE78.5060409@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692F72@rtitmbs7.realtek.com.tw>
 <5201FB09.1080105@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692FD9@rtitmbs7.realtek.com.tw>
 <520204BB.9080603@metafoo.de> <20130807093629.GU6427@sirena.org.uk>
 <520225B4.5050208@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C6932CF@rtitmbs7.realtek.com.tw>
 <5204F0AA.1070209@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8885004181721255396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B3F22657B8
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 16:58:52 +0200 (CEST)
In-Reply-To: <5204F0AA.1070209@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8885004181721255396==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3l764Q7zY5HuAgsB"
Content-Disposition: inline


--3l764Q7zY5HuAgsB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 03:37:46PM +0200, Lars-Peter Clausen wrote:
> On 08/09/2013 11:05 AM, Bard Liao wrote:

> > Does "virtual switch control" mean a switch control which will not touch the codec's register actually?

> Yes. But Mark seems to prefer the solution using {PRE,POST}_REG events.

I don't mind that much, neither way should be a problem for the
framework.

--3l764Q7zY5HuAgsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBQOjAAoJELSic+t+oim9aeYP/j0Aor513ym5191LQ4NU8zs0
4Lc3fJXHbiv7mJNBNNZ87bfDLM+SmeAKwmD4N6DlZac4Jd0sf8IREJSajKWxp9Ns
nXioosWuk2G4TgquIUe1QZX28Aq90KiiOVVI+pkFdGfL4k0HyQfRHlu9sz6ed+e9
4fWnmOoQxEVihYYxEyVV/Xky3UuFsE850VyTY7HiIBXcjcGOLGD5UulvUh58ThaQ
S/FqCtwjpksR49cN3ZlgHY3KlMA00Qc+IwW197j41HdrkGeZK0dPBghqeFTgaeiV
CTefe18VbpII9KgsgWBTBjPvCl+73Vval8uWEJRy0KTiox/a8ew+enIpGoPkrFxI
znyP5EBnCO6Im48kd3/3O1WdKzIuP8g4xjfHHbBwcG2W/EQO4uXzTtU/RfKYTSdw
NL2KZ59CqibFv9hGr+wrwC3pVC+8SoC/mdZPq+6r2Ta3bh4lF2bw6vVjdykFAsNr
RcVjZM93l0u0i1jJBMoQ9ZDVGh/UX7EZNa1v/ZyhE/VxWCoQlfVW+3pfbn4aYSVC
Qyy3btcKJDINdESrlNu6qWvKMxcIxxybDVyLJ1d5UDbdV1C3GknXuD5m1ndiPmda
25CaYlz3wlOgIgTrbpbVYeK80cIj6WljeFllvHk7IymBVlAWQhgdiqN2Ryntrzg7
TVswq4/113ZroP/xB71v
=GRyi
-----END PGP SIGNATURE-----

--3l764Q7zY5HuAgsB--

--===============8885004181721255396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8885004181721255396==--
