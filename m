From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 000/102 - chunk#2] Add const to
	SOC_ENUM_*_DECL() macros
Date: Thu, 20 Feb 2014 10:53:54 +0900
Message-ID: <20140220015354.GR2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8085667330023375087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A2BF026537D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:54:14 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8085667330023375087==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bhWRZWkimNlt1+0z"
Content-Disposition: inline


--bhWRZWkimNlt1+0z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:15PM +0100, Takashi Iwai wrote:

> The first patch adds the const modifier to SOC_ENUM_SINGLE_DECL() & co,
> and the rest are to remove superfluous const modifiers.

Further to what I was saying the other day about too big a series -
the fact that you've got headers like this in the middle of the series
is an indication of good places to split things up, as well as reducing
the spam factor it having these series headers in the middle of the
series (which is not normal and hence makes things confusing, it's why I
thought there were several patch series each of over 100 patches as
things were coming in).

--bhWRZWkimNlt1+0z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWAvAAoJELSic+t+oim9omUQAJlkSGROxAD9G+zxqD9q6In8
01IwZUJPBVsb2ux2QIzUOzz59p5qd8vjo+w52KLVZxN51FPyJOulz4GfsXsAS7J4
YypG7C++VVPwqoFfvQdhNCkwflC5SuV8VY8rGtT/z9ldtgSMOA7wAINKasZ6l8IH
GX9CSvk/srwyEhxgAa93LNZ7g3n0l3oGGo54Zpm4g+q6G1QD9C111BcW5cl+DdAW
C3or4PsDp7hIGHR1XyRJ9eyGj4sYveTkEOakcuA0z7w1DS23o9ylQ973nOJlKw9v
SsHYMsWU/gAuYBzdt4G//dyud27d3wgee57HZlzxHZ/lDW1PxuNzKA6YxM25KIL3
DPIGZBsP/ZnQYcuCmEpahokM/bwlXKXqPyyEH35qNnDQUYtweW6PwKa6g+HwdBs7
JfolasbbzRjYv+L/qTpdDiWYeOzqt64lEeZ5iArW1ayTfy3seMz6FGXfsOmZh+gz
+YNU+89cD2gmpo/J3I/m7mMj1AX/8HRxBEZ8v6MT2P6+XqfoFP9HtYmrHBgaHIUH
iHxYn9YOi0wrMzIBiuSQj4VBTTAfhPvLNsCsi6QVbMUnRYjl9ixXy+frlkjVmJoC
Sojqgi0+IpRDp812coRJ2jZqdmE23qFqI/g9O+Ztj5AtV6843xxknpDH1v1LxRbm
k/kO/JY68AolxwmvnjnW
=cVBD
-----END PGP SIGNATURE-----

--bhWRZWkimNlt1+0z--

--===============8085667330023375087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8085667330023375087==--
