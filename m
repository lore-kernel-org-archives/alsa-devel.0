From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Configure wakeup in
	later phase
Date: Mon, 5 Mar 2012 11:56:47 +0000
Message-ID: <20120305115647.GC3224@opensource.wolfsonmicro.com>
References: <1330940165-16086-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8158027729430577854=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 56E7E103C32
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 12:56:48 +0100 (CET)
In-Reply-To: <1330940165-16086-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============8158027729430577854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 11:36:05AM +0200, Peter Ujfalusi wrote:
> Configure the WAKEUPEN register at the same time we configure the rest of
> the McBSP registers.
> In case of OMAP3+, if the sysclock has been reconfigured we are going to
> disable McBSP for the duration of the clock change, which will reset the
> McBSP registers. The WAKEUPEN register need to be configured later, so
> the changes will be effective during runtime.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicrocom>

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVKn4AAoJEBus8iNuMP3dobQP/igFzOYMzqTYILpXu9UzrMou
DM7qNc+GLVwlkloZliMuE2HicCJnqCCvJV8a7eskKTz4W96EnKWjBk5MvbUwlvXM
f5CMeXUk1IjPozxn9Zhoj9nJw3TQDMrBclbom1n9vE22/1EB1WqxuFGWW/kQ9hFx
AWsRtTet6NYcxdVtUKoWq9CW0B3QT7afAdF2GCFAdXQzIQ1OBUcortTIOSBpsaWy
cEAZLWWD9UUm5CrfJ0wQzOVPWIZQJvqEhOltEz+fMqkVvfyq1cXBJaYShK66Osnl
jHnLwtU+z0gBmtLQjtS9mgXoQjIq8piD2wS0rWVirCkqsF3jtZKdJOPcUe+2wd63
Jv+nRw3WaVGk+fky/4RoEu3nkQ0zY4i6bKlLxsQWk2ytzoC36CmFip/FWcAFfSaS
NjH4yN0ZE3WqjJlnmlRqidauJ/xIxwvmWXtgxsO1C9JOwFH9BcOpmkKx4sAtwCRe
+Ge0uQW5Pxul/cBjkmZfCHAJC/lLA0pbkVLZ21zyKuZXMR3kPFdtv2oNttSPOslP
z9aISzxZRvEUE7sj4jvgHtjAkwVrLiBjV1Y+iDu3xF9OvcES75rilc+uGMOKbZKc
3iISBP/vofxZ0Y/SpyRhbE+ugtYpEXgX5X39C7k9F83aa7LsD2imZOhzJdfWpPvy
cUSArrbCjW8Jxh1YnwSu
=8g9w
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--

--===============8158027729430577854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8158027729430577854==--
