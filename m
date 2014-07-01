From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] question regarding codec DAI ops
Date: Tue, 1 Jul 2014 11:14:22 +0100
Message-ID: <20140701101422.GK23300@sirena.org.uk>
References: <53A44007.1000008@st.com> <20140621102644.GQ5099@sirena.org.uk>
 <53A7D78B.1050508@st.com> <20140630103127.GX23300@sirena.org.uk>
 <53B27F4C.9040900@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4205879501220085395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7903C2602AD
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 12:14:56 +0200 (CEST)
In-Reply-To: <53B27F4C.9040900@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4205879501220085395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cuYGGMKi0BuiS2pJ"
Content-Disposition: inline


--cuYGGMKi0BuiS2pJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 11:28:44AM +0200, Arnaud Pouliquen wrote:
> On 06/30/2014 12:31 PM, Mark Brown wrote:

> >No, this is is not at all sensible - don't do that.  Think about it for
> >a minute - if this were something we wanted to do it's going to apply
> >just as much to any other I2S controller so we should be doing it in the
> >core.

> In fact what i really need is a dummy codec driver.
> But, perhaps, may i the only one to see advantages of using a dummy codec.
> if it is the case i will implement a dummy DAI in my codec driver.
> Otherwise tell me if you are interested in a generic dummy codec drivers.

This does not seem like a good idea, but then the only use case you've
articulated is running with no CODEC connected which doesn't seem
terribly useful and certainly doesn't seem like something we should be
open coding in a machine driver.

--cuYGGMKi0BuiS2pJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTson7AAoJELSic+t+oim9GGQQAJIKHK3lymDybAaLPgaO7znT
71Y45QmCLaUiA2QWJsbbF5CCnaxTxNt5izEp8SBHe1+Aa98rNnWBYIjfWgei+mpM
BmNe/bmUbG59No/MgISZPMzN0sjmvVgicsQryCqTD5QL8UO9mFynMALR3YCKXBR0
WoelXiBRlDGw0KJpsWGtYG9HRptJxZNLiCxvBugF8aN6pM4w/jMmAD0qwJ9CgYT0
yIcjuyIMIyNL9clWa7jONlwufP7Zxc7qzLLBOAb/EcqSnnZWEejn+V4bIwLcRWrM
Zl0iu30LU4AWnziBxzcIq41/MpKABEa3RHCAcEJ06bJYi+4L7TpNxYlZExr66f38
AQMkh4hOBaamSZScvxFydvfKUYExO37PwVWdY7dqgOJdHJlppQGePKgTaY/7P4TQ
0972xNU1fVT898aj+zUPZRK0kj/9apWbn9oYILUtgx0lbiJSyCAprqTwFjH9QDM3
PPmIx2CunaJ6hWyD9UHvVPSACq81h6bstrI8niF6f+P+OdWCspuSSzAny309rBvg
Foh4xhqvWh/9ij8vqfDMHb1Cgw2z0aEw0NEFs0GN/zgrEk/xlq2Nw0io/3hy6BwF
BrhmmrYuXixAP7IG/1/unttPiKkNTVm1ROqOnWyRRMLXyTB1eC/0H7TcwDFB1Lj+
jOzlnlJJHvRIIufYSw65
=5MV4
-----END PGP SIGNATURE-----

--cuYGGMKi0BuiS2pJ--

--===============4205879501220085395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4205879501220085395==--
