From: Mark Brown <broonie@kernel.org>
Subject: Re: wm97xx touch does not work after ac97 delayed dev
	reg removal
Date: Mon, 19 Jan 2015 19:17:34 +0000
Message-ID: <20150119191734.GH2809@sirena.org.uk>
References: <CAOLZvyE3tEec4QpdeYrJwNJEjcf18zodjF1XtQjzaeRdHA32wg@mail.gmail.com>
 <54BD4CDA.50309@metafoo.de>
 <CAOLZvyFHAoQauzA3gyUZkwH+dxsW6vov9j9ukhzx4QJ4U+7eZQ@mail.gmail.com>
 <54BD53CE.4050306@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1120616369645340392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 77ACD2614D9
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 20:17:43 +0100 (CET)
In-Reply-To: <54BD53CE.4050306@metafoo.de>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1120616369645340392==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2015 at 07:58:22PM +0100, Lars-Peter Clausen wrote:

> Ok, thanks for testing. I'll try to put together a proper patch and then
> send it out tomorrow or so. The wm9705 and wm9713 look like they need the
> same patch. So maybe it is possible to add support for reseting the device
> in the core itself rather than doing it for every device in the device
> driver.

There was the ucb1400 (or some similar part number too) which was the
same deal with an integrated touchscreen and CODEC and probably needs
the same thing - it used ac97.c.

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUvVhNAAoJECTWi3JdVIfQR40H/jKFbTHHgzZNeMt6FEIAaGOi
B6f9UWgu/4g2+S5KeaKVtVNcxZODydi2gExjOur26kuJaN5hBRmXjjIyGEGUNig1
9lUfdeEs+RBWgQCyPK4IfZG8aFR+rBxuVIkm3ROwXleBpAnXTHRYqduev1tICx3a
7/acEo2mM+RhwQ32rHXEGeXIfy82DWJlFh8v9EhFn7hUzJBU+YNttHUT2bWEyNQ6
sQwsUnDMtJMXeAJJA8ydX+zEzZ67BV6VCumaVDwu76H4t2GL+iVGLRWNpuV921Oz
Irw/L935eL1zt50kfBiTwSo7XeIb0qNvZYlxxfcPW4zCArt4SIPrWvk5cwjYDcI=
=Jm/a
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--

--===============1120616369645340392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1120616369645340392==--
