From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da9055: Partially fix device
Date: Tue, 14 Jan 2014 19:51:59 +0000
Message-ID: <20140114195159.GW15567@sirena.org.uk>
References: <2E89032DDAA8B9408CB92943514A03376B7CC95A@SW-EX-MBX01.diasemi.com>
 <20140109121353.GG31886@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CC9BE@SW-EX-MBX01.diasemi.com>
 <20140109202446.GQ12858@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCB98@SW-EX-MBX01.diasemi.com>
 <20140113211858.GK29039@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A03376B7CCF27@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6380814554649081802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AAA0E264FB0
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 20:52:06 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376B7CCF27@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============6380814554649081802==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1gsfN/+pS0/2Ta7u"
Content-Disposition: inline


--1gsfN/+pS0/2Ta7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 11:04:22AM +0000, Opensource [Adam Thomson] wrote:

> I don't disagree with you on common patterns, and I have been an advocate of
> following these when working in the kernel as it generally makes things simpler
> and easier. Here I'm not trying to be awkward but am trying to get a simple,
> flexible, solution which fits best with our devices, whilst still using common
> kernel frameworks.

That's not what's been coming over.

> The PMIC is configurable via a register in its register map, and the Codec is
> configurable via an OTP register, which a customer is able to set themselves
> through a series of register writes, in the Codec register map. When you

Are you sure that it's not the other way around?  It's much more common
to have OTP for PMICs...  In any case, for the device configured via the
register map is there any real scenario where someone might use that
feature - devices do have this facility but it's generally never used
since by the time you can do register writes to configure the address
register I/O is already up and running so it's just making work.

--1gsfN/+pS0/2Ta7u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1ZVcAAoJELSic+t+oim9J/oP/jFEPaZ+i9Vs8raMd5X1zZgR
8JzOzqVg04PFRX0c0Ak324pyd3J6BAgA16f2ykmkXSlFCjgkotR2fuHi0PZxRZFe
y3JBXgioZQ+sDAaUziAKHBUREra9YiMANPpOyWD1d+nF/j1OeJTrGD5qGZcb6jpv
WB6VD7FAsmG6OEwv6dgp4NdMc7WX0EQL1Is9S/vbZWzzH1LFZc6+zpvz7hrwpsr2
dL1WcsRfUF2hRm3EatwEpi48ou6FtUb1+FJuP9kRReCgm6p0dH+W93KgHM9K+xoS
N+oCWMKIte0YdAQ2di+rPI9Yf+maNzlunIjzo+RGfKrbZ5dfCpeVPyirxaa0nIso
TjzNlTsbcHA5efDYO8QOvVDtG1T1gGQfwZknHfbuZ67X5U5OXyTgmKKXzJCSFC4k
U0r5+WKVyZSZg1nar5hprbTc8v7sGU1SH1VF0HxAgi3GM6o0UXYiPhaLiUNGfSl/
4ohow7l/IEuFxE4UA8HwG550MV/LktQ/WFWGdvqHprNo+QjjzMFdoBtsYyJee9ui
36MDLBOfEch/oH72OixJ0Aq+0GYCDxQv3gZ0JEMM/L7rs2fO+KX2iruww9beb/5/
aUMJzmMc2ZR8scI2VHB4ru1WG4Ija3mDYMTgVxfeawC/XwdORXf+EkqIOt+/8tmf
kBa3Wl39hwzVffX3Pb3j
=jU8A
-----END PGP SIGNATURE-----

--1gsfN/+pS0/2Ta7u--

--===============6380814554649081802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6380814554649081802==--
