From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: cs42l73: Use DAPM routes to hook
 AIF widgets to DAI's
Date: Wed, 9 May 2012 18:18:33 +0100
Message-ID: <20120509171833.GM3955@opensource.wolfsonmicro.com>
References: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
	<1336583644-12349-3-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8048329707494353720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0419104540
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:18:35 +0200 (CEST)
In-Reply-To: <1336583644-12349-3-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8048329707494353720==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="glNuw4S6NeIZr5j7"
Content-Disposition: inline


--glNuw4S6NeIZr5j7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 12:14:04PM -0500, Brian Austin wrote:
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>

I'd also expect to see the stream name removed from the AIF widgets,
otherwise you get duplicate links (which is harmless but still).

--glNuw4S6NeIZr5j7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqqbjAAoJEBus8iNuMP3dqjgP/0mQRigm2CkFNzSX5qyo+dMA
wRYzkHKbCBJbVAPcU7modRev7b0mLMgVmfs+74PmQ6BeJbrQXWdbIi6pj2v7OHO1
vGxm28M4yYW7siWwYsgfEr9Wt9jLZd72y5bSTxaOYC4Nmg0k1ph+AZHrFe21zkZS
lwMNOcmfAp+lESvuwIFYgHDv8b+Fptb6Q3ClOcbvsGpN+srMiQqmtKSR/SnjnYR8
ImclbOdTPNq2CRgYhesxPLNMIfVW9J0oMr5plTPrhQg+ngJrrFTdBKf+k0/68Pg8
ZUny/1wH/GHGCywslhL81oTfsuvU2d5ePGs5JAvZzhvrCD87DU1gFAIShWt9n7xG
XJkdCGtUiEYe/qGkXtEpch8dwKI3hIKIlOwOPPXtw43SUqUb1Z7g6zGsJWeZvUP9
ubVSU+a4+5eJ77w2LYF8wkM0YgJnjk4CC4xkdE/91I/Da7xbClayPphIEq4P3Tjy
x9BJulOxWnhPXZzYb6Lzk1GRpkySdT7CbQFaGSUjYReiiOf3A1TTdqk6rcS+EpPG
cwe5X7eJ7VWJa84CVGqQ3/2xPiZXb4N41v8gfnOTegfQhjSDpD2A+TyKL0rN79te
cCFkgQqnrEXUWhfVz11obAQ95Pe4StHEPqwALn/NNEWdG4vQu/DSgh8ncHfAAWIW
6PlRzObMUskTqtCHTrqj
=nAPL
-----END PGP SIGNATURE-----

--glNuw4S6NeIZr5j7--

--===============8048329707494353720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8048329707494353720==--
