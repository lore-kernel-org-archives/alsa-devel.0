From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8903: disable IRQs during BIAS_OFF
Date: Mon, 9 Sep 2013 21:27:26 +0100
Message-ID: <20130909202726.GU29403@sirena.org.uk>
References: <1378752289-6301-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0783558640358891196=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 306C42651E4
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 22:27:32 +0200 (CEST)
In-Reply-To: <1378752289-6301-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0783558640358891196==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wE3zBBerMo04BEsn"
Content-Disposition: inline


--wE3zBBerMo04BEsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2013 at 12:44:49PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> If the WM8903 IRQ is triggered after the device is suspended, or before
> it is resumed, the underlying I2C bus that the WM8903 is attached to may
> not be available. This may cause the IRQ handler to emit the following
> error:
>=20
>     wm8903 0-001a: Failed to read IRQ status: -16
>=20
> ... or perhaps even cause a failure inside the I2C driver.
>=20
> To prevent this, explicitly mask all interrupt sources when entering
> BIAS_OFF. Also, modify the IRQ handler to immediately return if the
> device is in BIAS_OFF, so that shared interrupt lines don't cause a
> similar problem. This requires that WM8903 interrupts be disabled to
> avoid interrupt storms.
>=20
> During resume (actually, the transition back to BIAS_STANDBY), restore
> the desired IRQ mask.

This should be being handled in at a framework level, there's a generic
problem here that affects essentially every device out there which might
need interrupts over suspend (and causes relatively frequent problems).
Your fix also won't help if someone has arranged for the wm8903 mic
detect to be a wake source which you normally want in phone or tablet
type applications but is where this sort of issue most frequently bites
since we'll never turn the device off the interrupt does need to be
asserted to kick off the wake.

Drivers usually work around this by disabling their interrupt with
disable_irq() between suspend() and suspend_late(), then doing the same
thing again between resume_noirq() and resume() covering both the
windows where this can happen.  This preserves the ability to wake from
the interrupt but it's not awesome; ideally genirq would be able to
understand that it can't deliver interrupts to a suspended device but
then of course at the minute genirq has no idea that a device is even
associated with the interrupt.

--wE3zBBerMo04BEsn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLi8rAAoJELSic+t+oim9n6oP/iw584tQ2XtNSbdcC8+GskhD
KMS2txrIxSljpdG4CYnoGkOXj0k/cTlXNCfxn/FSCuEQNmWr6f+eJHk87IEdqM11
Svr0Lc6CBClb6y1ukHrYZcSOIueRc+MdZFd1dVlBwRRuUxlBL+bs9P1YCUejl/m7
oeLn3VLyfYIbXUhzvBC+sp5rNNWfy4cQYsOeAr7AfJg3w//4Op/E5XiRyM5HP+zX
R0L7kWqYjbv1LWN1JnbKBP5uRpe2DEbqF9IvMQPGkiL152VllrgKtbbo10SVRdBf
V7lR539lNPbp1SfpvTvXf/fQm5iD6iISTZIzH5PmQHxYy6mJVVcvmbX7K42MFuF6
ClJYkRZGuIUsPWBM0br9M7iII/27jpzCyCiWE10OvXACU3gRbTNzaSiZUvuPWet7
6DuWWNXBWDdm50SbqlXPY2gr69QOw5/A7v8KWhmgJdKTJWUnaEna0xEfETe4v1IM
VOB7oeUFaP8buTo94Wm53RQQ7Qt8SDemNHrXY+8nDXQyEvLvZxY/FekKCTVERfLw
pLwB6iEFkFa9Uvgueh9C/WJ17f35xA+sJq9o9l2jpY/xSm5I5cbNGcagtTj/0Q37
4f7w4HRIlym/eIB5YqI7grh2akP2xIoAPk7gk7+7eIPOmGpSqoNs+KrO6Ufb3mvP
l49gjHDAmuSWAKoo0Qje
=D4q4
-----END PGP SIGNATURE-----

--wE3zBBerMo04BEsn--

--===============0783558640358891196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0783558640358891196==--
