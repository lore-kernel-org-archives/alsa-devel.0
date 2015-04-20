From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Mon, 20 Apr 2015 13:21:29 +0100
Message-ID: <20150420122129.GC14892@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
 <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
 <20150418171137.GY26185@sirena.org.uk>
 <CAJzqFtZ97FjzDpgbSJbCkqNGnQx_QiGrzY1v1zV+croAL6_=qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtZ97FjzDpgbSJbCkqNGnQx_QiGrzY1v1zV+croAL6_=qw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 18, 2015 at 01:07:07PM -0700, Kevin Cernekee wrote:
> On Sat, Apr 18, 2015 at 10:11 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Someone trying to use the atmel_wm8904 driver with something other than
> > a wm8904 shouldn't really be expecting a good experince...

> The same check shows up in numerous other drivers, including the one
> for the audio controller on my board.

Sounds like either that (undisclosed) driver has a problem or you're
using it inappropriately.

> >> Is there a stub version that I can use instead?  Nothing jumped out at
> >> me when looking at the other codec drivers.

> > No, such a stub would make no sense - why would we put a stub in all the
> > drivers rather than just making the core do the right thing?

> AFAICT, implementing the set_sysclk callback is mandatory, even if it
> is a no-op on the codec side.  If I delete the stub function, audio
> playback fails.

For the reasons I mentioned above having a set_sysclk() function is not
mandatory and your driver will not be merged with a stub such as is
currently present.  As far as I can tell you are trying to bodge around
some problem elsewhere in either the code or your usage of it.

> Clearing just the LSB would accomplish the same thing, but would be
> less obvious IMO.  It would also require an extra read, and the code
> is less concise.

I don't think anyone is going to care about an extra read on system
init, and in any case if the driver followed best practice and provided
register defaults that read would be satisfied from cache.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNO9JAAoJECTWi3JdVIfQ5DMH/1pMUDSuO9yDgfeD1YsIw2u8
VBPFkawtdtNzJcwmNwQX1fl7RZFacH/2LD5oqB6u7AGUlwcX0gQI978v7KeDLxNY
zAWxVZfWAnCKro0Dd2Od1OehilNto+WOW4JGOI10Cpdk/JdD40DoFVGkj93RzpD1
c1Xtmdo8He00S/7yF3kHklLc1MjAQarmzlIcGHi1X/leMt3l+fbw88Whay0oBYoF
U7dxbBWOTNJSeH2/YMhpl68SlQXumB+wZfyWF/amyVNwx+D/LQVIB2bUrlKZPWfp
sCCSFy0CZh0CBVpBtcjN7b4sRG24TpvaVgr6iPME4+yhxYRuM7CUgJ5qpA8NesA=
=1YpN
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
