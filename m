From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: twl6040: Prevent extra power
 transitions during resume
Date: Fri, 11 Jan 2013 14:24:03 +0000
Message-ID: <20130111142403.GC20956@opensource.wolfsonmicro.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
 <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
 <20130111115207.GW20956@opensource.wolfsonmicro.com>
 <50F01644.30703@ti.com>
 <20130111134601.GA20956@opensource.wolfsonmicro.com>
 <50F019E9.3030805@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1927989024713488887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14557264ED1
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 15:24:05 +0100 (CET)
In-Reply-To: <50F019E9.3030805@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1927989024713488887==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jcjv6D8puUawUjle"
Content-Disposition: inline


--jcjv6D8puUawUjle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 11, 2013 at 02:55:53PM +0100, Peter Ujfalusi wrote:

> But I wait if you have other comments for the rest for the series.

The rest of it was fine, I was going to apply them next time I go
through and applied things.

--jcjv6D8puUawUjle
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ8CAHAAoJELSic+t+oim9I+YP/imcChIabUvUh7QHcxHS8IFX
AupbH6uPiz7i9f/RTi843eVf9A4xV0xW7u2X8d2svAs35S6KviP1f+xLs+Lm6dTE
3kk07a/TWupNyv0HasYImAZ1z//1O90pDz6SBJMGqiKYgLIriDNk4n+0Su4wpZrU
EaqgfuNmaIlUde3eIlMPDr8KNU+AofiF/Tb9YMb9xgZDPZqMjLhyMWW4vwf92gHR
mGquc8R8yI4kmmSYTOiDiX4uLKCnfP6SMHG9xgh1l1nbw8mVTGCSDrZi0SaIy4x7
BpKhb9wVW+kESr4Jz7yjHVLUNUOCIC2q3Bz/N65tlSa3PZ97XrUuKrrIPfLkYucq
ybpjsqrEjz91N1OPMpoX36LZcffCSJfQrlJP6X5TCqcZ5CMRWU73Rj4qk8NE35Nf
W46MNMT8/d7XVW6ou9aJoQd17+QPQYS8voEZm5TgHU/qBoP1amE10V40+UUcfTZs
PwQFllXFWS9VlhvR8BRjt7pxlXNo9OfdrnxsuaUCC7njmoi6FAwaDR7mVQchnOlw
mhoniH7R182vGhWlrQNSt7Gj/GqJV3ELHWQnBKdaOwndpIZ1s+SY9rBzgDkYopJ6
nA4SlcgktQ5BnqEyxhzLzWVibmeZRMtv6vOPQZz7i3X/62pScDId2FnLVwWeXfqF
0Zy/Q6AZMnuPfR9MDn3n
=+l25
-----END PGP SIGNATURE-----

--jcjv6D8puUawUjle--

--===============1927989024713488887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1927989024713488887==--
