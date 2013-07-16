From: Mark Brown <broonie@kernel.org>
Subject: Re: Connecting two Codecs to the same CPU DAI
Date: Tue, 16 Jul 2013 17:20:43 +0100
Message-ID: <20130716162043.GS22506@sirena.org.uk>
References: <51E55925.5080208@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0606578494083623939=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 874EB264F8F
 for <alsa-devel@alsa-project.org>; Tue, 16 Jul 2013 18:20:46 +0200 (CEST)
In-Reply-To: <51E55925.5080208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0606578494083623939==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96icqjDFsSi85SgI"
Content-Disposition: inline


--96icqjDFsSi85SgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 04:31:01PM +0200, Daniel Mack wrote:

> This is cumbersome of course, and I wonder how the core could be
> augmented in order to handle such cases correctly. Ideally, it should
> only expose one PCM interface and handle a list of Codecs in the back.

> Or am I unaware of an existing feature?

No, no feature here.  Off the top of my head I'd suggest soc-pcm plus a
virtual DAI for the second link.

--96icqjDFsSi85SgI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5XLYAAoJELSic+t+oim9sxUQAIMCr4HWIJNlQyaPPg8h4Pxj
1wl9wsnDrtX9hu/8KVr5j50mAahwijbnJ/1xgtdKN17xbHrPPBFJpyW3W/+6nqfz
Jdwox+elucpuHyCwH3qXncz45APPgzqVKDAtFM0Bxt+o47cLZrng+U+2nvnPFJ44
4W4fItzSNGJzWc9zh5mV0U8nF4q7ouVQkpjMJdgdND0Nht8b3lMbuz5k914GCsrp
l7kv5omSfDi5SyuePSmi2M3kqnHRjyVrUENjCutx9lLjOg/tnYimvcYLktv/2vex
hFNxImvH41drfhQGOcWzS4+W3CUe+ITa4op6dhD18ESRgOdfEIyz0NGrj8LOPdC7
Pwyk218skvu6F/OVM/+jflpUNFlkcpU8urGbjDoArWFiyX5s3XMsCLHRYiWYsI8y
97uZs36oHn8m6Oxn9bdqefNEFwXBpI+8UADmnTUKXT1j5OFECLjJI6D9vJFH4Q34
rnHs4wZF4Atkr7TL+mVzTnhbAgxXd1vdRQn9HDf81RMiLt5apju3rka7aplD2Tbk
GP+b122PWH63QYWHgHNizsnNiKlfqHsiMtZ5hBCez3X1q8/bGMWPqW8MlX+QMyt4
M3/okFR5mC8TQpFAkbSs1vOWzHNCh+YHa69NXrX/g0Nmfd30VtWOlgw5IiMnBwbl
5umLQmaajGEIoIMqYu/7
=lCyL
-----END PGP SIGNATURE-----

--96icqjDFsSi85SgI--

--===============0606578494083623939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0606578494083623939==--
