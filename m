From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] regmap: Add better support for devices
 without readback support
Date: Mon, 13 Jul 2015 11:50:45 +0100
Message-ID: <20150713105045.GB11162@sirena.org.uk>
References: <1436783208-1529-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6804392011558381249=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4303260459
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 12:51:00 +0200 (CEST)
In-Reply-To: <1436783208-1529-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6804392011558381249==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6xKfvfmn9W5rdvbv"
Content-Disposition: inline


--6xKfvfmn9W5rdvbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2015 at 12:26:44PM +0200, Lars-Peter Clausen wrote:
> Currently regmap requires that a reg_read callback is supplied, otherwise a
> warning is emitted each time regmap_read() is called. This means a device
> or bus without readback support needs to supply dummy reg_read callback.
> Apart from that regmap_read() will still work fine if a cache is used.

This really shouldn't be in the same series as the uda138x stuff,
there's no real interdependency.

--6xKfvfmn9W5rdvbv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVo5gEAAoJECTWi3JdVIfQuxcH/34Sh2Q80ppOnv78iYLQcKPY
vIvgJuoiYyHc6tTRq1p3NCuJn0Nw/rxgQO7YT3VB9IviCJZgTFxRXefS/xNjsmA8
Z0R4oAa7Ae8Rn1i5ADEqBQPWQvzOE9zoLpGA5id4TfnN1tq/ykPanvyLHGkyKY+Z
00Jx8dx0Rvvozuv2yGMK03z94JxH4piBYSFBbSYG3pEfBLpMJ6ta76vZXWCniE6A
xw0UUo8qSFC2Vir0tcV7FoSeib8bkG2uBatiIubsSa9rmLeLG1YVFTaMgfoeQZdS
HZA31WzJJ+72y6T6bSIYCA2i7UHIKmcQHcegQ0mrE+L2yQ0SWwqsKJ1PC4oQMe4=
=CNBg
-----END PGP SIGNATURE-----

--6xKfvfmn9W5rdvbv--

--===============6804392011558381249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6804392011558381249==--
