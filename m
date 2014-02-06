From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: pcm512x: Add PCM512x driver
Date: Thu, 6 Feb 2014 13:50:15 +0000
Message-ID: <20140206135015.GR32298@sirena.org.uk>
References: <1391689575-4039-1-git-send-email-broonie@kernel.org>
 <s5hr47gv1yi.wl%tiwai@suse.de>
 <20140206130735.GP32298@sirena.org.uk>
 <s5hob2kv0z3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G6ArjEZjY3m60389"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hob2kv0z3.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--G6ArjEZjY3m60389
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2014 at 02:12:48PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > > The numbers of items in pcm512x_dsp_program_texts[] and _values[]
> > > don't match.

> > Yeah, fixed.

> I'm thinking whether we can check this in the macro.
> I thought of using BUILD_BUG_ON(), but it's unsure whether it aligns
> there well.

Yes, or changing the way we pass things in so it's an array of
key/value.  Usability isn't great for enums in general and particularly
poor for sparse ones.

> > Hrm, it is but this points out an error in the control helpers which has
> > been there since forever - they call that parameter max but it's not a
> > maximum, it's the number of elements in the enumeration.  I bet we have
> > a bunch of other enumerations which miss the last element as a result.

> Yeah, the argument name is really confusing.  I had to double-check
> the code when I reviewed your patch, too :)

> Also it'd be better to have a practice to use either ARRAY_SIZE() or a
> constant there, too.

Indeed - even better would be to just remove the parameter entirely and
use ARRAY_SIZE() on the array of strings we get passed in so there's no
way it could be messed up.

--G6ArjEZjY3m60389
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS85MUAAoJELSic+t+oim9dj4P/1/kOSVCzFKd8t4ppjMVp3ky
aC/CoyIi1cbu7JzM/jNshE86X7ODlMOcPwy/Qe/sD/cml1Wf8RFucXIqnkf/YPMg
Hx8ByebwQlTES8h6FTIkcs8/Ga/F63GGK8hvapYS/5MuAcXylTkNUrLnNDX/VPza
8EK32JbErgcqjejGY8G2IVOgTm4TDStK0bop7iWy+l/UQ3X/SRDGZD5tIPEJkSvk
wggl6mi9SVEGpNlvj+6ADLARVwDexY5zssDauTglpwip/zFHSsEhtimS3mX6GoFY
D5SXZV0Ychar/uzdkkj1HITw9lvs9DLsmX3g0NswRIb+TEp0ucXTDYbCxDHMu503
TZzjh8XKMmRFulhKliAhh1cMF/3YTL0/K0h+55/nVjBLKNjmDLqg5wIycmdooLu2
JyJ1Sbk+dEcO7ttZDnT0754e+X1goKKM69qjm2WEjpYPMAEurYrpXJOnJHLSCyHj
mHE0scKyY6CfPXWqJ7eVNXEykeim96H6EPx0zLXs7ClAc9fYhBukUOv1qKKtvzoj
SIMqOgNzBxnCuKw8X2DjdOEMSoFmmJPqyKo3Fb1htgrzQ9fY9G0bSP5Kgee+cksZ
V0+nCx4fd4ukDxauMX1UOa8NsUQ8Rr1SVv5xuz9kClJO7fF0J4WjYvNk6FGL/mSe
sQWwNtVCZ98X4jLgH+Y8
=q4gJ
-----END PGP SIGNATURE-----

--G6ArjEZjY3m60389--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
