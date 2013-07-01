From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: sgtl5000: defer the probe if
	clock is not found
Date: Mon, 1 Jul 2013 13:51:13 +0100
Message-ID: <20130701125113.GK27646@sirena.org.uk>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
 <20130701094525.GY27646@sirena.org.uk>
 <20130701113310.GA24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3548516172631435293=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A01326513B
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 14:52:02 +0200 (CEST)
In-Reply-To: <20130701113310.GA24642@n2100.arm.linux.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3548516172631435293==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ttU9AGiyjxxpUEJf"
Content-Disposition: inline


--ttU9AGiyjxxpUEJf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2013 at 12:33:10PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 01, 2013 at 10:45:25AM +0100, Mark Brown wrote:

> > Why not fix this in the clock API - the same logic is going to apply to
> > a great proportion of clocks?

> It's not ever clear whether a missing clock is because it's just not
> provided or whether it's because it hasn't been registered yet.  The
> decision to defer on missing resources is something which a _driver_
> using the resource should make, not the subsystem providing the
> resource - because the driver should know better whether that resource
> is optional, whether it can continue to initialise without it and maybe
> try again later, or whether it does need to defer.

Given how common it is to have a hard requirement for a clock I think we
should at least have a helper which implements deferral, even if it's
not part of the default request function, since so many drivers ought to
be using it.  Doing this in by default doesn't prevent the driver
overriding, though - the driver can choose to squash down the PROBE_DEFER
into a fatal error.

One nice thing you can sometimes do here in the DT case is to have the
subsystem tell the driver the difference between "this clock is mapped
but not yet registered" and "this clock is not physically present"
though there's never any guarantee that the provided resource will
actually load.  I don't think the idiom for the clock API is to provide
every single clock in DT though so that might not be doable.

> Take for instance a video driver. :)  It may be that it can't do all
> resolutions, but it can do some without an external clock, so it may
> decide that it can initialise without the external clock and allow one
> of the possible modes to be set - and when the external clock does
> appear, it can then allow the other modes.

Yes, that's the sort of case where you do definitely want to just carry
on (though there is then some vulnerability to changes in init ordering
with things like modular kernels).

--ttU9AGiyjxxpUEJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0Xs+AAoJELSic+t+oim9OqMP/joS8xf/RzTHAs31qvxLP0BV
9qSDpqBodKIBVQ7joeBp/LjL0oje8e/F8p1mt/Zrk5Ea37hwRypQ7UVtfkTlHqEo
jskEElSF091GdrUeoBrvnm6vcSQDCKT5PZrPDYir0th+qVPmaz6MxBfNd6oFL5AT
kK5UR9fgK38YW3NuNOYqUapJm5JzYaCXkLxC+0FMSc++rDVNOlErh9EpJUU9jMDc
P8M9M2LxULn6o18uLkF50p92PzOeFEg6M/66JHk+PJ1/YEVs+GKAuQyZtsoATR8X
pZDpMSvG45qUvojY0PBIwO/q+SRDpLbvTydc6yR61vooKMmNWOVkgmwLQfjNHDz9
M1xtzCSaUZ2aLzbyiayS0lLcOYlk8DYk8DJZfmCCgfuJG/YhuwI3GLsprIpUzDqJ
De01e2tso7pRl+KPYqgEUGrT3Hot/mZF0Rj/K4bGqw8D7NCxE4V8IIDrToafdbIJ
4CU9hJCg3GzQ42i/ruHf8z9o+Qaz68FeXNcCd7mjYOV5rro12n4kdOWeYlP+mgWI
QqCPWta2LQxiX4rLWd2uG359g6uY8nfPCZ03S9CftG+wVzUDSCna00AYGjj1Jm9C
qTEd75U2iCSA0B1IdHmgwxFhr1P9glTPd2Pkak90sk40x2Lgz6LtiTketZZXyzwt
PjInK1VW3elzcz4HBMHk
=O4QY
-----END PGP SIGNATURE-----

--ttU9AGiyjxxpUEJf--

--===============3548516172631435293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3548516172631435293==--
