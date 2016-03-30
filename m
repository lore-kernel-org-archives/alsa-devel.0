From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/5] Sound: SOC: TAS571x: added missing register
 literals
Date: Wed, 30 Mar 2016 10:21:27 -0700
Message-ID: <20160330172127.GL2350@sirena.org.uk>
References: <1459237178-12920-1-git-send-email-petr@barix.com>
 <20160329213305.GO2350@sirena.org.uk>
 <56FB8B00.4000408@barix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ura8jf0QYTXVPAoa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56FB8B00.4000408-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ura8jf0QYTXVPAoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 10:14:56AM +0200, Petr Kulhavy wrote:
> On 29.03.2016 23:33, Mark Brown wrote:

> >On Tue, Mar 29, 2016 at 09:39:34AM +0200, Petr Kulhavy wrote:

> >>The list of TAS571x registers was incomplete.
> >>Added the missing register definitions up to register 0x25

> >According to the driver the device has registers up to 0xff?

> That is indeed true. But from address 0x29 on (0x26 to 0x28 are reserved)
> the register width varies between 20, 12 and 8 bytes, which I'm afraid the
> register map is unable to represent.

Say what's going on in your changelog then.

> >>+#define TAS571X_DEV_ID_REG		0x01
> >>+#define TAS571X_ERR_STATUS_REG		0x02

> >These look like volatile registers but the device has a register cache
> >and we're not adding a list of volatile registers (or readable registers
> >for that matter).

> That's a good point, thanks! 0x03 is a regular RW register but 0x00 to 0x02
> are indeed volatile.
> Is it better to make them read-only, or volatile?

It's not an either/or.  If they are read only they should be flagged as
that.  If they are volatile (if they could change value at runtime) then
they need to be flagged as that, I'd expect this applies to
ERR_STATUS_REG.

--ura8jf0QYTXVPAoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/AsIAAoJECTWi3JdVIfQ5fsH/3Ifubqa+pegij8BLimPJiUe
Iyruh6Egm305kGUKEzfAlnZ080vHj4QxSnOR+atoiJG8gjl2qG6WPNhLex3pm0PN
0L4Hym5TmfX06z3xVOeVKIIhxST5AW0w1glTVZ2aU4Uzv7EKX0tyAfJxS+HJGuhj
90tyO4G0I8A1zGROhERBRqc3GqLuXAvg4HJoPCdxE7uKFupyWKOaxJk9tWg8N7oG
M289RxfCCLcHmb6n8i6vfpjxGbnN4cPy+nlT7qCpBre5xLD+EQQIGwIf8FSl+jsr
WOtj3e27P5lUmF7ttSdlUNw+EmWuqZoB90vn0birDVjYgZTpY+qWBlzuTnz8UOo=
=3PH6
-----END PGP SIGNATURE-----

--ura8jf0QYTXVPAoa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
