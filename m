From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 15/18] dt-bindings: sound: Add bindings for Cirrus
 Logic Madera codecs
Date: Sun, 14 May 2017 19:04:03 +0900
Message-ID: <20170514100403.nocjlb77q5r3nvo2@sirena.org.uk>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-16-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170425155257.s6m4wgrzxxsxcggo@sirena.org.uk>
 <1493137664.4826.75.camel@rf-debian.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cza46krmerc4eir5"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493137664.4826.75.camel@rf-debian.wolfsonmicro.main>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--cza46krmerc4eir5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 25, 2017 at 05:27:44PM +0100, Richard Fitzgerald wrote:
> On Tue, 2017-04-25 at 16:52 +0100, Mark Brown wrote:

> > > +Required properties:
> > > +  - compatible : One of the following chip-specific strings:
> > > +        "cirrus,cs47l35-codec"
> > > +        "cirrus,cs47l85-codec"
> > > +        "cirrus,cs47l90-codec"

> > You shouldn't have compatible strings for subfunctions of a MFD unless
> > these represent meaningful reusable IPs that can exist separately from
> > the parent chip, that's clearly not the case here.  All you're doing
> > here is encoding Linux internal abstractions which aren't OS neutral and
> > might change in future (for example clocking might move more into the
> > clock API).

> While that's nice, the of_node doesn't get populated if there isn't a
> compatible string. And people don't like workarounds for the missing
> of_node.

What workarounds are you referring to?  Why would this need any kind of
workaround, there is no requirement for magic broken nodes like this in
the subsystem and if there is we should fix that rather than bodge the
ABI.

--cza46krmerc4eir5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYK5IACgkQJNaLcl1U
h9DG+Qf+MXO0kmiz04BZDxWrTzENEIBa0GMVAU39Xh5Kfnbf49VfGU7sb2DuAsv7
AC2U9wLbIU+Anp5msmrw1LwLym1andkGKHhJu7TKx9QvlVZCkakVUQa3Trac8PGA
8oFljIE1yossxLtxxz2wa3fIRkRyFIehXMZvxvGL74Y1tpPhU2mFfn6vgzUAMohH
51As5HEODdIxqrH+PdNgJOPF472UqQsrj2aLrgjThjskeMBoprsr7x1mpvIZTXPY
AOIzFYeSr4tWORWoMrXYFoiQcrlDh6oWhxcOUTthHOdaUjjAv/ehHzs4rLF966CT
jDvebOibp9h2ir7DTcavUnGqiVZn3w==
=hpjz
-----END PGP SIGNATURE-----

--cza46krmerc4eir5--
