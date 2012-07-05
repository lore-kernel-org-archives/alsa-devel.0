From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: pcm: Mostly constify constraints
Date: Thu, 5 Jul 2012 10:28:42 +0100
Message-ID: <20120705092841.GI4111@opensource.wolfsonmicro.com>
References: <1341423313-9561-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hhatm4rgp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7828991375774178817=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 315762445D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 11:28:44 +0200 (CEST)
In-Reply-To: <s5hhatm4rgp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7828991375774178817==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Eb2dXAwtBqAM4EkP"
Content-Disposition: inline


--Eb2dXAwtBqAM4EkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2012 at 09:06:30AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > There is no need for the constraints to be modified while being
> > applied

> Many drivers pass the local instance to rule->private, and it's not
> always guaranteed to be const.  For example, you can imagine some
> state modified kept in the struct while it's modified via rules.

> In short: you'd have seen many compile warnings for non-ASoC drivers
> if you run make once with this patch ;)

Well, that's trivial to fix.

> As a safe side fix, how about just adding const to
> snd_pcm_hw_constraint_list() & co, and expclitly cast to non-const
> later?

My inclination for something like this is to put the casts with the
users since that way we get the type safety through most of the code and
we can see that dropping the const is safe since we're just getting back
our own data.  If we can see the APIs immediately dropping the const I'd
expect we'd get people spending time on code review trying to figure out
if it's safe.

--Eb2dXAwtBqAM4EkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9V4BAAoJEBus8iNuMP3d/bUP/jYMwi482XwovbA7nGJXdM39
umAi0FwBo2h7Rz368EpEZ8c03CFeP2SxQI1yDSXd00v3tjv4R4Nql2jQepYt1Std
cV5XHB/0Iuc4jRvSrs+BFHV+bWWyHC6fGi8fYGt+srFLx08W7iItc6HjGMHsiU4Q
VJNQBXa4VyJ/0WpPGCTZEAB0Cfhk9hv6Pm+ZfeI8HEcjv4Br6JbgkyD4ARuoQSy1
pLpDjO3UFDFQRNTfskT78tGDgdl9fEFIFzjjmEvlblPapoghcv8g7PKkJL/lGGU7
df2tQX2fmZaDijkF7pMpSOb5u9VCXwcFmqXWqhJrngnnuQoAGnywXu7e/tj0a5LA
99fbUbSWTxjr3gfvpASZfpbdfI48p6ltIaHlG+p0e/OR6OPwchi2Fa1hEd0Sf2Ls
W0iR2iVcvaDvMRdXRXBxsFMES6C5SHcQShp+aN41ePrW0CJwMsh9k+sGPvgfELQ8
78VmAX6eAGeAHnu2a/JHagcDJLLXJnch+BUT1ZcN8M6CZpZtIXUtaC5nwGUoek0o
g3c2cXXmZJNPAfwe6Y6hb8Lo7mKcvCZ1/mEMe8zBXR5gexVHhhhhBZMgtV2fCnbA
Y4R8+TYGcdXc6ICdbijS9xz2mKlNz+pti+q4Jw9vcaBWDnwv8smxMENspfuqjwjg
t6XeFgJ6sJqKJGCu7R8q
=5vMf
-----END PGP SIGNATURE-----

--Eb2dXAwtBqAM4EkP--

--===============7828991375774178817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7828991375774178817==--
