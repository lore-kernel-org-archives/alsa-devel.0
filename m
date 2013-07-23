From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 18:16:50 +0100
Message-ID: <20130723171650.GJ9858@sirena.org.uk>
References: <20130723104615.3696f1a9@armhf>
 <20130723123444.GW9858@sirena.org.uk> <51EE7E1A.3040301@gmail.com>
 <20130723132016.GC9858@sirena.org.uk> <51EE8591.7060005@gmail.com>
 <20130723150150.GH9858@sirena.org.uk>
 <20130723151956.GX24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7708567268715138441=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id EE35A265131
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 19:16:52 +0200 (CEST)
In-Reply-To: <20130723151956.GX24642@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org, devicetree-discuss@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7708567268715138441==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IqkiyIW+g96++y1l"
Content-Disposition: inline


--IqkiyIW+g96++y1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 04:19:56PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 23, 2013 at 04:01:50PM +0100, Mark Brown wrote:

> > Why would platform data have anything to do with this?  To repeat again
> > the way the clocks are mapped should be totally transparent to the
> > driver requesting them, if it isn't then the driver is not using the API
> > properly.

> Total rubbish.  Of course the driver needs to know what the clocks are,
> so that it can program its hardware accordingly.

Of course, but why through platform data?  Though reading your mail I
think we're talking at cross purposes here...

> In this case, it has always been the rule with the clock API that it
> shall be used as:

> 	clk_get(device, "internal");

> to get the internal clock, and:

> 	clk_get(device, "external");

> to get the external clock - or whatever names are appropriate to name the
> clock _inputs_.

This is exactly what I'd expect, yes - but it doesn't need the driver to
have platform data as far as I can see.  As you say the driver should be
requesting the two clock inputs the IP has by name which doesn't need it
to have any platform data, it just needs code like you have above.  The
board specific configuration is all handled within the clk_get() calls.

--IqkiyIW+g96++y1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7rp/AAoJELSic+t+oim9lx8P/A6zd6JnPW1PT7sNnz28wjlj
nI6vbPOYAwmpEUFWj82LUBUYAYiPMFa6hdZ0CHjwgiMnOunuIW+nYnuDJ4RTfdxF
TeMH+4VJygPNefIGnOTjRr+V+Lh1zeH2lP/zo3CzmS4c8MoGDRV+HN+A45qZ0XO0
3WfVv1hL2fyw/+3hEdE+4tuJ1RcxS4P+GCXCpqCeEQA/aPgt923PQtIWpH0/5306
11MnyYvaxy236SAicTKem/JabvwsdJ2yjEBjXgZoAG2HnMuqkSrHLsDHwA+kES8W
mRd7aXfT907Mxxvcs6pM4n/kon59TAOevIt2M4oEktFHz3E0L5hXxVGr5iDmNjRg
AtZohC5rqLzsoc/n5yVQs8rdmDDaxsYTbBbN2iV4FxKUhYut6H3YR8P9tdfzECaK
P7Rnt9HNvfMUoNtQcMr2DOamn5reynxZJwOIg157uR/jt0/UeaPd8U3uRs/gOyEv
LgrgPo8SIgbCvacNHujUolIWCYxCLgBK6jL9WxPiJEeL9YvxLU64yeYTRaaytyPi
4NT3NjqkOPLS4OlJnLDRunogj6iwFMxYBZsxo/rbF9FW6h66c2LtAe+AC1AgZCX9
+hsKjoR4hH5FH3mmMGGxCOpBV3zY1uE2xeks1sV7YcUuNawEzEJpnjba2UcC3tXs
pVSgHLdYAUPekmlEJrMJ
=ba8D
-----END PGP SIGNATURE-----

--IqkiyIW+g96++y1l--

--===============7708567268715138441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7708567268715138441==--
