From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Mon, 20 Apr 2015 21:14:01 +0100
Message-ID: <20150420201401.GP6023@sirena.org.uk>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org>
 <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
 <20150418171137.GY26185@sirena.org.uk>
 <CAJzqFtZ97FjzDpgbSJbCkqNGnQx_QiGrzY1v1zV+croAL6_=qw@mail.gmail.com>
 <20150420122129.GC14892@sirena.org.uk>
 <CAJzqFtY3-jYTS-NmAE4UtsD+VXZHBUJUVuVQ=X4htB1akCThMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IoGhzFUztgUGyjlj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtY3-jYTS-NmAE4UtsD+VXZHBUJUVuVQ=X4htB1akCThMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--IoGhzFUztgUGyjlj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2015 at 08:12:36AM -0700, Kevin Cernekee wrote:
> On Mon, Apr 20, 2015 at 5:21 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >> The same check shows up in numerous other drivers, including the one
> >> for the audio controller on my board.

> > Sounds like either that (undisclosed) driver has a problem or you're
> > using it inappropriately.

> I don't think this driver has been posted on the list yet, but the
> checks show up in these two functions:

> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/sound/soc/img/concerto-audio.c#108
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/sound/soc/img/concerto-audio.c#147

> Any suggestions on what to change?

That driver has not been posted previously (and looks like it could use
some rework for mainline).  If it doesn't care if it set the clock and
is just trying for information it should be handling -ENOTSUPP, that's
why the core returns that value.

--IoGhzFUztgUGyjlj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNV4IAAoJECTWi3JdVIfQXvoH/1ixR5v9Aqshr0pA5YIU3WKW
ee7JO1fgi79H7UprhSioxEfB/nyNhU6crR8Rm0lFsigk+OAJ7J+1rW1rc7TmWunq
376Z2Ek+oBNT20oqPoiQtnehXjlcexeW3YygvcIsyYPmM3xwEjx79A9gfawQCkiT
QGd8fGrkq08+4jWxIY/t+Uq4u+0pTj25scGwVaQZ0jXqtDCNCVxsSEcNt5NoUmFc
jcl1Om2i1mVPhpfZrlwv7yUIWQ6c86wlONSxhbfbbasK7ENd6E8i52JEbyHi2zzf
a+b3XyB76z5IR2EeTGq4hRgsnCsnK8OKyojuAiMWHtQdmlKfeWX4IgZ+1oo/IjM=
=yQ1T
-----END PGP SIGNATURE-----

--IoGhzFUztgUGyjlj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
