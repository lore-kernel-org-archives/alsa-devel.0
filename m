From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dt: Move WM8903 pin list from Tegra
 board binding to CODEC binding
Date: Wed, 7 Aug 2013 18:47:05 +0100
Message-ID: <20130807174705.GQ6427@sirena.org.uk>
References: <1375866978-14726-1-git-send-email-broonie@kernel.org>
 <52026F84.5030204@wwwdotorg.org>
 <20130807163031.GK6427@sirena.org.uk>
 <52027DBF.9010501@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8054723193243148671=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C54C261793
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 19:47:10 +0200 (CEST)
In-Reply-To: <52027DBF.9010501@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8054723193243148671==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utew04vv9FCWZJ01"
Content-Disposition: inline


--utew04vv9FCWZJ01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2013 at 11:02:55AM -0600, Stephen Warren wrote:
> On 08/07/2013 10:30 AM, Mark Brown wrote:

> >> Probably want to remove the line "Board connectors:" ?

> What I mean is that there's only 1 list of the jacks now, and that's
> already introduced by the trailing colon you added in the line "+  and
> the jacks on the board:".

Hrm, I guess.

> I suppose it's fine to add that later. That rather encourages people
> to think that only strings are acceptable for identifying the pins
> though, which I'd rather avoid, but I guess it's fine.

Practically speaking that's the only option right now, actually doing
a numbers based binding isn't sensible without infrastructure work to
look things up and it's not particularly reasonable to insist that
people do so.

--utew04vv9FCWZJ01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAogWAAoJELSic+t+oim94woP/0dekSjTBIXyYJ8OHDnD6j7o
796zE8loP5zPvF75qSw2X2wzjFVSmhtIPPX6AutQx0mrNCIRJUVvhY1Ka05OSksZ
C36BzuXuyZKtUNKtykZn3wSZ2r6M9YIYZ7Yg+MsUFQYG10FjXpGkspVz5sYkz9vH
XiujztM0sJ+5eCefSloepbnV4UGJmxPQEZmTjsMJQ4kc5STzvjx2c7KJNMwrhNv/
RgJTJ4tH68hw9IR4e7X0U+GY8IU3SKx2mHXRwJ/CkSQCXLBfn8qFtqst2zVK0uqG
qSsMo8aGnnupXslC7SdjeMTeoWpESunLpxM3MY+5zm3PzPhOInNZlS4mUPM3gr7A
wEa5DHAc20n+jgEe+Hp/VNATrEeyljJL7CwvKKY7JPQFY3EK55MkbSY2LjdigMxW
A21+j35gOZAK8Jwz7xPZFlt1veVlP/A14cNbYWuJCaoxlq/cHf4VHgfXUCiJcA30
ikPvNbADZvPy3JZ3w0zRtZGWgR11y7dbTk0xxwLEiOPUeWSE01cUxZ0KTW57Hzvu
4rX+OBABc2ZBL/0apXcypHQB37omXyDXFhR7JPkB7R1ynUNCwweibQk9AVMK68DL
XyWbOWcvcIOd/2nJWgNylxspapClQFlN8mbUY2MN8pJe+0LXayyOZ5ChwjgIf6hd
IvzX+5lNmme63jvt3BKi
=MIDA
-----END PGP SIGNATURE-----

--utew04vv9FCWZJ01--

--===============8054723193243148671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8054723193243148671==--
