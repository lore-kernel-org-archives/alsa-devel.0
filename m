From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/7] sound: soc: enable Kirkwood driver for
 mvebu platforms
Date: Tue, 11 Feb 2014 12:38:24 +0000
Message-ID: <20140211123824.GN13533@sirena.org.uk>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1391102051-5319-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0828986471087388858=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CF96264F1A
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 13:38:33 +0100 (CET)
In-Reply-To: <1391102051-5319-3-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0828986471087388858==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 06:14:06PM +0100, Thomas Petazzoni wrote:
> The audio unit found in the Armada 370 SoC is similar to the one used
> in the Marvell Kirkwood and Marvell Dove SoCs. Therefore, this commit
> allows the Kirkwood audio driver to be built on mvebu platforms, and
> adds an additional compatible string to identify the Armada 370
> variant of the audio unit.

Applied, thanks.

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+hm9AAoJELSic+t+oim9V8UQAJMhvOjt3RQ8ylRI2PkMGnkv
lLZuPyL4QooeE8ZBoFemwSCT5/AqyQL6QBgsoPbqJfHMT11eUf8IE9ZyP4zWrxbZ
YGnjaRJ75o/mGqLeVvBZsNtafDFja+v1RunAgDgULLI1cq0ApF8+8acy8LwPntg7
RO3wc2Df7H0XcdeSuKz//5q1Hvm4j5uvZwFSrQxG2yQKopCNR6njU4w2Hip7DVGI
b+8HZkoJjORky0SfdGh4mbT+884peSrlOpWN9QKEJCzIt4Xyu1J1cwOR6rzZq8ag
O6L3YOShjiewGdfoX7Fq7pQjgUiCTLpfXksWt8q/pImYFRkYSSQdURhK5jGw88og
MDatyJsVIhmIY9ndaRgatoiszUICYPIpPgVvHVldyJW7cI8iEqJf6MIxyboxyS4G
s4OjEdVnFetlFQ00w6FQPczUnfFxQY9/ekQ4JEGi8MrTMY28U7za+qKDm+cqzyNv
H5NxYhETMN8a9tn3Tp8ccGKKjC6cmaJ5e0GIx5loPO9+OTQ6W0q6bFD8B+cEvjB9
76NzyESCWxhGYsfkcEdbw3Kk3h/rUvBSfR1C6DubRNkUlFdwdD07MDs7RkGPpThb
0s9Lbwsv03sn4IMZFZL13Y22PlPzDrqN6GO3sGbYGZRo3bfS4/n4dBGYnidLES+p
LgjaLM96p8N3cGAZE9gx
=Q8PG
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--

--===============0828986471087388858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0828986471087388858==--
