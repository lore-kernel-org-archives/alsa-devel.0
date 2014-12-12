From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-dapm: Fix comparison of pointers
Date: Fri, 12 Dec 2014 14:17:14 +0000
Message-ID: <20141212141714.GN11764@sirena.org.uk>
References: <1418162021-32229-1-git-send-email-linux@rasmusvillemoes.dk>
 <20141212132109.GH11764@sirena.org.uk>
 <87h9x10yrk.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8977459469714619670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E252B260669
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 15:17:29 +0100 (CET)
In-Reply-To: <87h9x10yrk.fsf@rasmusvillemoes.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8977459469714619670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OL6cD/Uw4z31vgI6"
Content-Disposition: inline


--OL6cD/Uw4z31vgI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2014 at 02:43:27PM +0100, Rasmus Villemoes wrote:
> On Fri, Dec 12 2014, Mark Brown <broonie@kernel.org> wrote:

> > If we're worrying about standards conformance type stuff here this is
> > also buggy since it's out of spec to compare pointers that are not part
> > of the same array like this.  Casting to uintptr_t is a better fix here.

> I'm not worrying about standards conformance. Casting pointers to and
> from [unsigned] long is done everywhere in the kernel, and that's
> fine. But subtracting ints or longs and using the sign of the result for
> comparison is simply wrong. See acbbe6fbb2 (kcmp: fix standard
> comparison bug) for the long story. In this case the narrowing (when
> BITS_PER_LONG==64) of the result from long to int just makes it even
> more wrong.

*sigh*  If that's what you meant you should've said so in your commit
log since that's distinctly non-obvious.  In any case, regardless of why
you originally wanted to do this the fact remains that your new version
is out of spec.

--OL6cD/Uw4z31vgI6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUivjpAAoJECTWi3JdVIfQ8YEH/3Bj06wf2U9O08OxFodtzSvG
gPYm/zfLVtqTaNtr++07kQCtMp70RKVW5a4JLa3I75r5cpoZnC9CHqhbjgUbcQKR
4NrxlRaoqlD1R4BVdPg20Nr0TkKFWuljuoFv07iwHBUnDSeZQs3mFTpTqB9l0KBT
ljjEV2dXRNMNxbdnYp6FODJlknWQC/LYO06qK2Fn5XAVA1r1nE+GoHcDQY1hWBC+
UCqVmGCimG4iCaCXJVWXYke7bLOd4DJEVdANal5c4dPm/U7CLcDVW+ajdVJCGXqm
h9VpacBKqH4aE/SJkEQFZwBDMkgvCHD9pcSZ6QV0rkSq6aQu4zuIAbNVXVskdEY=
=krAJ
-----END PGP SIGNATURE-----

--OL6cD/Uw4z31vgI6--

--===============8977459469714619670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8977459469714619670==--
