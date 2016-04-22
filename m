From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Fri, 22 Apr 2016 16:31:24 +0100
Message-ID: <20160422153124.GH3217@sirena.org.uk>
References: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
 <20160418164727.GI3217@sirena.org.uk>
 <CABCoZhDLyT_2xMhOqkiw5+9rOtA9FUqcvxy+1Pz=2QohAZEcHA@mail.gmail.com>
 <20160419094629.GP3217@sirena.org.uk>
 <CABCoZhAXqXTdMebSHLXTMbAUYCR-8H320F_0EOViYcGqMwisWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5964907501765237977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83D002617A4
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 17:31:29 +0200 (CEST)
In-Reply-To: <CABCoZhAXqXTdMebSHLXTMbAUYCR-8H320F_0EOViYcGqMwisWQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5964907501765237977==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5y45gzHVJWc99xXB"
Content-Disposition: inline


--5y45gzHVJWc99xXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2016 at 11:14:40AM -0700, anish kumar wrote:
> On Tue, Apr 19, 2016 at 2:46 AM, Mark Brown <broonie@kernel.org> wrote:

> > Hrm, that looks like the driver may be able to set it automatically
> > using the regulator API and just have a switch for the guaranteed.

> Should i pass it via device tree then? I didn't get your statement about

I'd expect to look up the value by looking at the supply voltage if we
were going to go that way.

> "switch".

A switch is an on/off control.

--5y45gzHVJWc99xXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXGkPLAAoJECTWi3JdVIfQLCcH/3HzmVAI20yRrsr3GdeNGJgj
V8ENKUi9jB1YXv6HrTeYtTBwTsmHn7JjhfUVfacA3/VcpxOk4fEDMVjXEX78xksG
0nvCgTvq8Bt2SIycX5ljPg63QaOfYlGGlDB7xk07IEMStZ8oqHa3yxgM8CZ91amo
oDkMVe5GD797i0cbHoNbnrYj2KcJAlb9EfqqSIVuFnMRn00B/cWR9NVDfc2tNa9U
lDRvFQDiw08dTVqjEwSSd/z4AA3IEDoedqOVqIm8mOIIxcH11JGXQ8viphP49b0s
+KhWHRUma8SAV7m7C/TToE4H/sKWADMLsROMS1jR9CZ7JDoc6CY0IxGSnC5R+bQ=
=uocy
-----END PGP SIGNATURE-----

--5y45gzHVJWc99xXB--

--===============5964907501765237977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5964907501765237977==--
