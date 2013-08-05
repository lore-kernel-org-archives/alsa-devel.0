From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm: Implement mixer input
	auto-disable
Date: Mon, 5 Aug 2013 15:50:44 +0100
Message-ID: <20130805145044.GI9858@sirena.org.uk>
References: <1375694851-13303-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1742335116275982060=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 28BC926500C
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 16:50:48 +0200 (CEST)
In-Reply-To: <1375694851-13303-1-git-send-email-lars@metafoo.de>
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


--===============1742335116275982060==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qd931lRzp2WpGIxm"
Content-Disposition: inline


--qd931lRzp2WpGIxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 11:27:31AM +0200, Lars-Peter Clausen wrote:
> Some devices have the problem that if a internal audio signal source is disabled
> the output of the source becomes undefined or goes to a undesired state (E.g.

Applied, thanks.

--qd931lRzp2WpGIxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/7vBAAoJELSic+t+oim91HUP/2AJ8inz/dKoNnQ8UTk6fWnn
KkMr3zj43qPt6odbZMnHyRNbALloNVvCpbiBgf2Dc4I6ZDh2bm5g7UyhosM58Op4
Z3sZI1hsp+9SwSZ8tKfJfn0bVsdGO7DT12P6e51uROzvYcV3TK8MrtIhRusmcOo1
NVkvSgsYNualtzfJLrj60dCnWxfVxgc9WJpAyzRHvgFQQs2+mZLhPGhFId2HGdrd
33k7b16PxXcw2X42iEFKNUG5UKkhFntS+1YqrDz4nxLRUAxgyUF91eO/c1CsoQd2
ea7PrqM3CZ/jLHezNeErQ7aLvyJ+R+WMl++31dJ4jDD8IicIkB4L+g42L6+7eGrl
LLfHkpxBdhpZ1vgE9AncS0JXTk45H4sVczcl78dtIEolGWYPspEroPj7lVRwQMHy
jOoKiZCuSLZ/ulofk6E90fkSK67rk6p9tres1DY4mCe5hMU/XVW+kk/aHeNMy3Ky
lJHvyGUGMfnQaWm3JQ2hoaQaGyPjc+A6qv/AazE1u2vpPuq3tnACYL7LLSqOiXjx
BElHnbt5k3oJrcEdv7kWC4qX7igE0OPZoPE4pFHbie0VHILAc8tWhgD6yqZWfHHQ
roHhUQjj2uYVFT/qAtJMicZfBFRiQrF6IboBB2roBw4zwOBbaTaseq8I5iOmQ1ZA
qIvvLysNByzp4Nk5DlJd
=i1If
-----END PGP SIGNATURE-----

--qd931lRzp2WpGIxm--

--===============1742335116275982060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1742335116275982060==--
