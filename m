From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: samsung - Don't setup i2s if already
	active.
Date: Fri, 9 Nov 2012 16:08:56 +0000
Message-ID: <20121109160856.GM23807@opensource.wolfsonmicro.com>
References: <1352414816-9157-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2762902659480493501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A180F26172E
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 17:08:57 +0100 (CET)
In-Reply-To: <1352414816-9157-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: sbkim73@samsung.com, sangsu4u.park@samsung.com, alsa-devel@alsa-project.org, lrg@ti.com, padma.v@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============2762902659480493501==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jB+02Y6wHc2pEa2x"
Content-Disposition: inline


--jB+02Y6wHc2pEa2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2012 at 02:46:56PM -0800, Dylan Reid wrote:
> If the dai is already running when setup is called, skip setup.  Setting
> up again caused set_sysclk to set rclk_srcrate to other->rclk_srcrate,
> other would often be set to the default of 44.1.  Playing a 48k stream
> then adding a 48k capture stream would lead to both streams set to 44.1
> (The value of other->rclk_srcrate).

This doesn't seem the obvious fix here - surely if the setup comes out
with the wrong answer the configuration it was asked for doesn't match
the configuration the device currently has and therefore we should
return an error as the new stream will have an incorrect setup?

Really this driver should probably be being redone in terms of the DPCM
code, it predates it and is a very simple case of it but it's in the
same ballpark feature wise.

> Similarly in shutdown, if either playback or capture is still active,
> return instead of turning off the clocks.

This seems sensible; another option is to do clk_enable() for both
streams then let the clock framework refcount for us.

--jB+02Y6wHc2pEa2x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnSqRAAoJELSic+t+oim9g/YP/04UvJW5Cp9ynSNeu1jySEsE
wZ7JY14csUiUyeMEGonCxPSdrZru90cMQ9pcuBtaLy8/zP6c1/T+5zYIHiHiNB9T
33FkJvBprMbnNa1UCtBgBNEHqBLxaaez/I+SYVEcXzTPHB7qsNz5XQaf79oPCRqe
SObK8uBRCzo4R5WrZnuhcZJwvd5KuBBslS4usW6itd9/KF5iW43HIcdnC3GlEJs+
tXAAaKUOc+ZUz1Rlxw0UDUD5BIU2T8v3SYX6qFPs/p5qb7UlJffImlaeNTDOXEkA
T/zGpasp8Y3ZP7UDaTJPhCX7JDLwqRNTXhrjHCZBpxQiYP2XDqlFljSCUg2p09p6
3CwTiIDqTiCmK5iTNIAd9Q4VpJTLob2D+p1qB+Vd6zpZBM5FBIszbW4VuxponRu9
/UwMIPj/ww4Xs5sLe3X3b6LqR6nSQ9w1uFHXqS+yNkd5YcSK4XO/o83lQWsg54+F
PtQbW7CnKrg/Og58KuBEx0eHYSH9v6EzV6hlXWcgsccuVMcCviq9UH7ciX2MroYP
74isVOr+4s50aOzmZElw5i/NJZx/kEgf36FRRZ2eRbajW67rKKjgbIjOjEDhjEFH
k3Mzlhm/beq6nuxCgVEw8twM+cGUEYoEFP19UTCbu10dHdLmTnCGJ5LA5eiM/Fgd
xsABvDJV8DFmvTKZoHuC
=BY6L
-----END PGP SIGNATURE-----

--jB+02Y6wHc2pEa2x--

--===============2762902659480493501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2762902659480493501==--
