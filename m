From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Thu, 12 May 2016 11:53:01 +0100
Message-ID: <20160512105301.GZ6261@sirena.org.uk>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
 <20160511152950.GL6261@sirena.org.uk>
 <be1f0f5c-5dbe-65f8-d55c-df07a92a558e@axentia.se>
 <20160511205353.GV6261@sirena.org.uk>
 <6fc2f0ed-6193-c99f-bcf7-7898029dab73@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWAbeGC4mMoqIxdF"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6fc2f0ed-6193-c99f-bcf7-7898029dab73-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--uWAbeGC4mMoqIxdF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 10:24:11AM +0200, Peter Rosin wrote:
> On 2016-05-11 22:53, Mark Brown wrote:

> > The code needs to make it clear that this is an intentional fallthrough,
> > an explicit default case would help a lot.

> There was this comment above the two if statements leading into the switch
> statement:

> +	/*
> +	 * Check if Integer Clock Mode is possible, but avoid it in slave mode
> +	 * since we then do not know if lrclk is derived from pclk and the
> +	 * datasheet mentions that the frequencies have to match exactly in
> +	 * order for this to work.
> +	 */
> +	if (params_rate(params) == 8000 || params_rate(params) == 16000) {
> +		if (master) {
> +			switch (max9860->pclk_rate) {

> Maybe it wasn't clear that this comment applied to the whole if-if-switch
> block? Will it be good enough to extend that comment like this:

Not only is that not clear it's also not clear that we intentionally
handle the case where they don't match by falling through - missing
default cases just look like bugs.  Tweaking the comment helps a bit the
reader will still see a pattern that usually looks like a bug and need
to think about if it's OK, a default case means it's clear that it is OK.

> > It will disable the regulators but that's not going to end well if
> > you're including core supplies required to maintain the register map,
> > it'll disable before runtime suspend and enable after runtime resume.
> > The regulator supply widget is intended for supplies that power
> > particular components on the CODEC.

> It is the DVDDIO supply that kills register content. I carefully left
> that one out, and only added widgets for the AVDD and DVDD supplies.
> If/when someone adds DVDDIO it indeed needs to be handled like you
> suggest. Is DVDDIO support required to have an acceptable driver?

You should really manage all the supplies.

> > That still doesn't explain the bouncing on and off here.

> I just read the comment for clk_get_rate() in include/linux/clk.h

>  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
>  *                This is only valid once the clock source has been enabled.

> The driver needs to know the mclk rate, and it only needs the clock to
> be running when the codec is in use, so do you suggest instead?

I don't think that restriction on the part of the clock API is
reasonable TBH, you need to be able to tell what the clock is doing
before turning it on so you don't misdrive the part.  I suspect that
it'll do the right thing almost all the time anyway...

--uWAbeGC4mMoqIxdF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNGCMAAoJECTWi3JdVIfQRqYH/j95j8nslarSVuLhe155idaz
OetYOprJqUFGE9NsA4hd61pzyQz/wPiM2w9gCFWqHrzLzifH1TESyyRPLsLFRjRZ
AmyUK3qPJTsIvskcsGRteR/PkQyeJyTrllm1rcCakw475yqFobZQfMgeVsqZZdhm
Mhym6Cl0FjyyWvxgDI7gE5WKGs5xDP2uhl9ukXhJW2zJKcbAADdHhDlp2KizTKuV
rK25W5bcH2I5MY4GHHj2/PSmLQRvYMmHBqVLWWBJiP74a8l5ddb15bsFbLoKKCC8
IN9F5E3GHKBZaQB8Qc266LLmwdUjK+wtGmLGl+yjRe3/C7rO+F8GRj9qGHaV/Kc=
=o3Rh
-----END PGP SIGNATURE-----

--uWAbeGC4mMoqIxdF--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
