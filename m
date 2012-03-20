From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 16:01:56 +0000
Message-ID: <20120320160154.GI3445@opensource.wolfsonmicro.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7752182951218494748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A5BB10430E
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 17:01:59 +0100 (CET)
In-Reply-To: <1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7752182951218494748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="boAH8PqvUi1v1f55"
Content-Disposition: inline


--boAH8PqvUi1v1f55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 01:13:41PM +0200, Peter Ujfalusi wrote:
> Certain application can experience underrun right after the playback start.
> This is caused by the McBSP FIFO/sDMA integration:
> The sDMA will push samples to the FIFO till it has threshold amount of free
> slots available in the FIFO. If the application picks period size which is
> smaller than the FIFO size, and it did not prepared multiple periods, or
> it did not set the start_threshold for the stream to cover the FIFO size
> the hw pointer will move forward, which is causing the underrun.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

though this should probably have the note about working around broken
applications from the cover letter in the changelog as with the
changelog alone it's really not apparent why we're doing this here as a
driver specific thing.

--boAH8PqvUi1v1f55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaKnqAAoJEBus8iNuMP3dA04P/2V37WCbeqUQhmQRjNi2zvJv
nzXMeLZ/QVbtiuz2AsQsL0XE1LAr17L5pVEbNXYQOLExJ+0g9ipsQ4kyiGVZTaYN
hiidWpdrly9P+mctdBiZ+L3l4jswxp9YR+8QYOXIGF3vW1ICSSMMZsv2tX0hpQbh
HTYyKCgZgToilL4rnDikOqwHa6b2jM2JDuM9uMt431mhteP1LyHA+qac51oC7eeW
ZsgIBFXLMQlclx3YQ0BnCCt1egRbd0rxfFBIEGlIxSuEh1zcHofEcwK6xTZ1whWy
kgMvE93dyGp0rEvhSII9iImJqXUyXHM8nibxTaJFSvA7RQqBIu063JSGmdlZXQzY
xbNfzVuMHsBfYyytO1NGJZiAV6RxDYb5pIs8yUen2mt9MwwX8ts2JkEuCDBGHqo2
NSQSy4+h1s3GImodoIP9q9vZNKss3m66xQ/telpCLov7Uu7JghhB38qWr1N7Aqg6
pE8ATgHjro0hQstPDEKl2NVqRPPMAQRF1sq123jWvC2OxUzWYjzYDo0qw5+eyfia
Y8hsjF7oy53aGN2RGN+ImpKFiqlRRD4kolvlM094nm7dQuvILO2dgT7hleyx4FcC
ziHc8p/6PjBDmPVm0tDn+4lVuwRi+zVpqPh6QrbE1vDAMB+14eYBb89j3HFK/Jj6
PV/cUhYT91IRs59LIS+x
=iN6S
-----END PGP SIGNATURE-----

--boAH8PqvUi1v1f55--

--===============7752182951218494748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7752182951218494748==--
