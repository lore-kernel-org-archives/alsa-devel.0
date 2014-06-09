From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm5102: Add controls to allow
 shaping of ultrasonic response
Date: Mon, 9 Jun 2014 21:20:28 +0100
Message-ID: <20140609202028.GW5099@sirena.org.uk>
References: <1402060445-5455-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8712475862673281410=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA93926566C
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 22:20:50 +0200 (CEST)
In-Reply-To: <1402060445-5455-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.org, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8712475862673281410==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oMQ/0Eds4GFUZehv"
Content-Disposition: inline


--oMQ/0Eds4GFUZehv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2014 at 02:14:05PM +0100, Charles Keepax wrote:
> Add controls to allow custom shaping of the ultrasonic response. This
> custom shaping can be turned on/off at runtime, although, it should be
> noted that settings will not affect a currently open audio stream,
> they will be applied when the next audio stream is started.

Applied, thanks.

--oMQ/0Eds4GFUZehv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTlhcJAAoJELSic+t+oim98KsP/1H5UYrppKRBx4PnAmkU055e
a1+pIczBX+4sqNMFY/sK6akrZM+wgL4No6susGmOmCMk/uuqGQ13RZw7/xQB/uXh
mTPcMF9xAheAwXTcOlD89d2RICG6hm4xb/+xSd2NgrY9b2XGN6VYadlsPjBInaJW
+44uagLfLXyJdUEvBB3m0tWH6zTQsB6MfxcGPP7UowmVPEz+2W/6/ysfhzcmTfzm
O7RvZNTDtypn3PMQIMmrgJ/r/uzhgIOH8Gc0Gb0/0Z1ey0i3Fkr5Rt7S+T8iWEGI
ITzkp131zZaR5oeiC5fB68Fjef1nTeFtK5cT0rBWdloV7bghqO5n4mVKdy4eKDT0
qgPP18ZHhf2Z2g13yOD+4vJvxslcFqDynzG6WFcxSFAqIvuIawLE1Gz9hgyQ/LXq
LcnuZKPtarL9fJDN7ywYZjAo/MYAhHwL9JGsxUH+SwmSSe7S8zpxd0W5dkKK8UuG
Zn9BzQ4FxlQ5k4d17oP1svXtOEhINv8QZBFzTKEUnB55tY0O5ZUG3Us/RSX4/ZyP
KnP4gAbORh6COvUhcGFVPYpB99cR6qtP/fa3i7tP1XelqSOQIWr7lsKU+wsMWjxR
88QWgjOQzwUhg5qf669TC9g4kfjhiJIZisUhXaSeC5NJYXqLBKSk/xKKqVeu5m2I
YKjr5i2bD02+0faMryKt
=ZUIE
-----END PGP SIGNATURE-----

--oMQ/0Eds4GFUZehv--

--===============8712475862673281410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8712475862673281410==--
