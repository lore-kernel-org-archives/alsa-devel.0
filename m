From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] ASoC: codecs: tas5720: add TAS5722 specific volume
 control
Date: Mon, 15 Jan 2018 16:41:34 +0000
Message-ID: <20180115164134.GA12018@sirena.org.uk>
References: <20171211190157.12371-1-afd@ti.com>
 <20171211190157.12371-3-afd@ti.com>
 <20171212120121.GH16323@sirena.org.uk>
 <ada57df8-66c0-0692-9250-422ef37cce95@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ada57df8-66c0-0692-9250-422ef37cce95-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 08:50:09AM -0600, Andrew F. Davis wrote:
> On 12/12/2017 06:01 AM, Mark Brown wrote:
> > On Mon, Dec 11, 2017 at 01:01:56PM -0600, Andrew F. Davis wrote:

> >> The TAS5722 supports modifying volume in 0.25dB steps (as opposed to 0=
=2E5dB
> >> steps on the TAS5720). Introduce a custom mixer control that allows ta=
king
> >> advantage of this finer output volume granularity.

> > Don't do this, it's just making things more complicated.  Instead do
> > what other drivers do and register different sets of controls depending
> > on which part you're working with.  The normal thing is to have a big
> > table for all the shared controls that are the same on all variants then
> > register additional tables during probe with those that vary for the
> > individul devices.

> That is what we are doing here, the reason for the custom mixer control
> is that the controlled bits span two registers in a odd way that is not
> supported by the standard handlers.

That's not clear from the commit message, it sounds like you're
introducing an an extra control rather than replacing the one that's
currently there. =20

> > As ever all volume controls should end in Volume (like the immediately
> > adjacent control does).

> This was done so this table exactly matches the existing table. If you
> would like me to change this then I can, and can do it for the other
> table as well, up to you.

Of course fixes for bugs in existing code are welcome.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpc2b0ACgkQJNaLcl1U
h9A+Tgf+J9b/7AVInlfTZZU5+zvRCdfwNvt08QHYvXnOhC6Qwy7yJ3T+M3qvxbFM
HKmLTUL1HZ6C1CYkpj43zoj7dUyQeh4uPtl51LGEnYdaY1GJnYMCKx6CW4VkLftH
JCLpEZ+dArp5F3Kziqe5Y2OYZZ41Rt1rk8DHWik92b37FAWPUdz6IbajHtQRFHMt
e2u5l9dqV5beBRLgflT2PESynGCdj9a6P5WigjaUFFRXU60Yr3X8pboIoT7BqNvs
aAq01uSE4/Neqf4eg89Yj7cbewTKFKxsVwxPeQau42qmOhpIr+rJxjHiBenk6c8v
yeIj0Y71O5nShQ2ckvZU6rXrufcTBQ==
=f9pb
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
