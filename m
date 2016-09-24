From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: simple-card: add support for aux devices
Date: Sat, 24 Sep 2016 19:00:45 +0100
Message-ID: <20160924180045.g7ayhbpbaxle34pt@sirena.org.uk>
References: <1474614673-12350-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20160923222541.GA25693@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="juilldp5ueknfzut"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160923222541.GA25693@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nikita Yushchenko <nikita.yoush-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Otto =?iso-8859-1?Q?Kek=E4l=E4inen?= <otto-Gh1NM5ZPXYb1KXRcyAk9cg@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mengdong Lin <mengdong.lin-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--juilldp5ueknfzut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 05:25:41PM -0500, Rob Herring wrote:
> On Fri, Sep 23, 2016 at 10:11:12AM +0300, Nikita Yushchenko wrote:

> > +- simple-audio-card,aux-devs		: List of phandles pointing to auxiliary=
 devices, such
> > +					  as amplifiers, to be added to the sound card.

> I think the property should be specific as to the type of device. What=20
> if you have 2 amps? Maybe simple-card can't have 2 outputs. What if you=
=20
> have a chain of devices and need to know the order of them?

Sorry, missed this bit...  We already have the audio routing properties
which define how things are interconnected, this exists to get pure
analogue components into the set of things that can be routed to.  The
abstraction we're using hides what the device is well enough.

--juilldp5ueknfzut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5r9MAAoJECTWi3JdVIfQO8kH/RPjkaokLHO+mmnnrUZu7Edx
nOCR6HGJbGP22fz1glZyoYhMH9xZdjQA6fCzuIQZLtypS8DX9SkfB9qfxOdmOLNk
t8ZwnLZ+/EKxd0QXLUBpSkyfVkQPIh7mk/zb96TAqFJQiIl+q8xGfjEbxn+odHYu
e/o5t1wGqepxXXM5wlEaNy1Hp9oLtjxKvPwY0BfQONj5FwV1lx8kesvMUINgJtsM
NBLmVenbJZzuHxAH8YTxhzjq8qYWh9Ycrh0wzAEDWL/JqTrfOwQjwQBWjjqP264S
OodEpg6n2Qq+/pNY8HrK/KnuhuG1+jrFI98eeHrUt7t3T+nJ9d3yKWeDLfSiIkA=
=x1D7
-----END PGP SIGNATURE-----

--juilldp5ueknfzut--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
