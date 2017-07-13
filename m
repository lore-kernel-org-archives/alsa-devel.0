From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/18] mfd: madera: Add register definitions for
 Cirrus Logic Madera codecs
Date: Thu, 13 Jul 2017 14:03:05 +0100
Message-ID: <20170713130305.ytrk322lqe6dusla@sirena.org.uk>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170713080210.lbsjnmlciovoxe4g@dell>
 <20170713100539.mqvyxgvwqowjim6i@sirena.org.uk>
 <1499949850.4826.88.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dnu4nyp3x6jvsw2v"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499949850.4826.88.camel-WeElTRBN8n0bEPBeyYQi64iQ8/zYDDdY1BehtkLrGTY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--dnu4nyp3x6jvsw2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2017 at 01:44:10PM +0100, Richard Fitzgerald wrote:
> On Thu, 2017-07-13 at 11:05 +0100, Mark Brown wrote:
> > On Thu, Jul 13, 2017 at 09:02:10AM +0100, Lee Jones wrote:

> > > This patch has been rejected by Linus.

> > > https://lkml.org/lkml/2017/7/7/579

> > Hrm, when I used to push the register definition patches I did elide all
> > the obviously repeated register banks like the write sequencer one that
> > Linus is calling out there.  I'm surprised by the "every single line"
> > bit though...

> Linux doesn't say what he wants us to do about it. I could manually
> strip out a few more definitions but seriously, it makes the code a lot
> harder to maintain if we can't grep it for use of registers and register
> fields. They are big chips, they have a lot of stuff in the registers.

I'd take it up with him, if you can explain why it looks very
repetitive but isn't actually that'd help...

Building up copies of the repeated IPs with macros would help too (the
AIF and especially frame control registers stick out like a sore thumb
here), as would removing the individual registers for the write
sequencer block.

--dnu4nyp3x6jvsw2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllnb4gACgkQJNaLcl1U
h9Ajzwf/UT3dCb8Miwi/swDRP0ZvxT512f4vbdv9H1+mx+lXkUUQ3xQOYHvfy2Fp
7qnitYjeGzzPk5Qm5sfkEHDgmm95Ju3OKAPQqsib0qYHRIWQ1Tbfk9/USplc6oqb
TyKqII498Tt1t5Uq4ZmjVynwGweem1Hy2TqnjqOgsc9jtRB9mcvup/BFGDwY2Tq6
T/9Wudte3/BkK2Pd9tUUAT+lSHnukOi6lmCdfM+bYJhF8aveEm4ZAzvrhHTETu/E
tcn7GcbK5hjMwBaQGtOdJioYdvYJd4CbWSmG8Qb1y+CiTkXcvKZaG/KtNe7TJRhV
RuvJHVmYXTilhvtTxIKvkBnbmvB8Uw==
=pWIf
-----END PGP SIGNATURE-----

--dnu4nyp3x6jvsw2v--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
