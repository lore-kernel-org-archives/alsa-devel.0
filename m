From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Tue, 5 May 2015 22:59:34 +0100
Message-ID: <20150505215934.GH15510@sirena.org.uk>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150504113943.GB15510@sirena.org.uk>
 <20150505092411.GA15549@opensource.wolfsonmicro.com>
 <20150505105327.GZ22845@sirena.org.uk>
 <20150505133129.GA26101@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8qjQX3lIKI8OJLo6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150505133129.GA26101-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--8qjQX3lIKI8OJLo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 02:31:29PM +0100, Richard Fitzgerald wrote:

> We can't really tell people what the selection does because that depends on
> the external hardware. The A setting might be a headset mic, or a line in,
> or a builtin mic...

> All we can do is say what the selection is called generically by the codec.
> So take the IN1L signal, on the codec it has two inputs "A" and "B". The
> IN1L Mux control has two settings "A" and "B". That seems clear.

So you're saying that you've got a mux on a single physical input which
has two inputs?  Are you sure that this is actually a mux and not some
sort of mode setting that should be in platform data or DT - what do
these settinngs actually correspond to?  The routes in the driver look
like there's two physical pins for each one of IN1L/R which the device
can switch between for some reason which does correspond to a mux but
that'd more normally be named IN1AL or similar.

Though if the left and right side need to be set to the same thing
(which IIRC a previous version had code to check for and you did mention
in your mail) all the time then why are there two separate muxes anyway?

--8qjQX3lIKI8OJLo6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVST1DAAoJELSic+t+oim9m48P/1ECX/itDcM/IaY9mwUrneaa
6dwMIGWH2zXRN5rWfgtMIT6AJjIkqAMM5aZzPsHAwrE6xn0AY/m9FrAnesQtLdW2
f9dUu4GFb0YZ6jMjItTNswUM5EHM3KkOc4KIVHkq56yIG/gU3gXvy3UYQd8M/tEB
3mXJcisaLSFTOVtbx87Y28ECbpG8IdIzRHAaug9OOC3IjLC7mk2nuwKXTURN5Zej
O7mUXuJ4kApTJ0DlU04aXupw9zAuxnIxm1nEDOnZ1M5IGS8m/7OEIvpUSAlplGkb
+tX/g/XFob1R/wlN/bS8eou1xPAro6Lud+eNRp3DtfoRTO9UC7utGfwsxVD9Vyx9
eTT3titGjoS5RRlCxNa1FaKjPBYEuPi9IySgvrY+GAag8jcMx8rmS/8mHSDALP0k
b7NwhZBr2xRod1h+zxPy0Z5oTtImRc6y3QFIo1dGoc3EiYcgO8T9cLfzW/qr1CBA
Fn0GnzhKyCKdR51AwOCKVAHFlZM86n4QZoX9/eNiz96NbMHVV4xt+5+b5+YR+cwJ
OoYTJpqxB7w0K1C4G3HZDqatRIDyrHCdhKsJDi7+jxTcsMaTgSKw8CDbfncMFkYg
A1XjgcjIzHRksoqLQ80jBH1ZuQuvtsXBBjiIRWgnoE9t+eshsJcXSb9nGZNHnaJR
EoGcfe3Jd6gOkiIA8PEi
=NKOq
-----END PGP SIGNATURE-----

--8qjQX3lIKI8OJLo6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
