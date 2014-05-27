From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 02/11] sound: ASoC: kirkwood: Remove
	unused drivers
Date: Tue, 27 May 2014 20:52:12 +0100
Message-ID: <20140527195212.GE12304@sirena.org.uk>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-5-git-send-email-andrew@lunn.ch>
 <20140526155901.GF22111@sirena.org.uk>
 <20140527164530.GJ26379@lunn.ch>
 <20140527180047.GA12304@sirena.org.uk>
 <20140527181818.GK26379@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0242922816927222539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 477F92655C2
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 21:52:27 +0200 (CEST)
In-Reply-To: <20140527181818.GK26379@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0242922816927222539==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Peq/qsrUuuMridNi"
Content-Disposition: inline


--Peq/qsrUuuMridNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2014 at 08:18:18PM +0200, Andrew Lunn wrote:
> On Tue, May 27, 2014 at 07:00:47PM +0100, Mark Brown wrote:
> > On Tue, May 27, 2014 at 06:45:30PM +0200, Andrew Lunn wrote:

> > > This is an RFC patch, as it says in the Subject line, and the cover
> > > note. It is not intended to be applied yet. Please unapply it, and the
> > > other one in the series you have applied.

> > Eh?  I thought the discussion was that everything was OK and we were
> > going to go ahead with this approach.  Or to put it another way what's
> > wrong with this and what's expected to change?

> What is wrong is that the merge path for the first patch, which
> removes the boards making use of these drivers, has already closed for
> patches.  So we now have boards left in the tree with broken audio. We
> can leave it that way, because these boards are actually in the tree
> twice. One using DT, which will work as things are now, and old style
> board file boards which are broken.

OK, so another part of this is that you didn't send the first patch to
me so I didn't realise that the boards were still there.  TBH I'd have
expected that removal to just be going in independently of cleaning up
the drivers.

Anyway, I dropped the patches.

--Peq/qsrUuuMridNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThOzoAAoJELSic+t+oim9oYkQAJqUd4++e9ZyR/LRqN0PLYZf
isXwhIhxJS4Xu9UT9EW3xJitzpa9s/n42TpQJ7q/ctPYZfB3X3ccutLWuyIc9djs
BwjOv06vewjG5AY8MGvRsZ+ShltT48yEv5kcRYhhwOHsZuTIRmwIS5zX6VE7Oruo
eGuToyb6AQbkF6f8o/oDPzLUQ9GktRTrvMuxDJz/4Js3WMKH3iNPPaJO/znQ+P/v
mvPBqex03J+acFe6VSOD0LrZXOJ3ZP2xcfjXlnQ15DkdE3AQw0A+oo291ihEoUGF
eamIlwDdGaOfriZc+SH4ri4DWB0m2ojSjD7iFzciTGATEPkBfvxuYmtBzs6sJxeu
iXwIJ0YisxglZWQyN2cZ3UZ++jxuQFzUClMvC91dq06FMq3v8U6ZbsF+R6T8bCFc
gEopmQoL3CgPoVi2ZIjXFY7RsCotuLejpIfivW4/J7ukcxZJAGRoBb0tYWroThld
OBbPqsHk4eFAJyp5y9iPMOM/F5KYiSsDB7ZfkTwytkYr0bPhV38GFthLVug1eHHk
+oWo/AFZUDVbunjjkt6DVwOlB0ssVzsS+QA+emmF3Uh381noszb0OsQoQUpI7v1F
ilHXrcS7EcdVezyXUOaSaB+8LLaIwW+vcaxmz8AOkYjFuF1i3Of6dMeRO0WwGNO1
6L/94OBy0PIZIsWTOi/F
=pBdj
-----END PGP SIGNATURE-----

--Peq/qsrUuuMridNi--

--===============0242922816927222539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0242922816927222539==--
