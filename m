From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: fsl-ssi: Move sysfs stats to
	debugfs
Date: Fri, 22 Nov 2013 18:33:56 +0000
Message-ID: <20131122183356.GQ14725@sirena.org.uk>
References: <1384938262-20554-1-git-send-email-mpa@pengutronix.de>
 <1384938262-20554-3-git-send-email-mpa@pengutronix.de>
 <20131121142208.GU2674@sirena.org.uk>
 <20131122164204.GB5893@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2981551345852175018=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DA2DE265163
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 19:34:00 +0100 (CET)
In-Reply-To: <20131122164204.GB5893@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2981551345852175018==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6tPipYVl+OcoAvSh"
Content-Disposition: inline


--6tPipYVl+OcoAvSh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 22, 2013 at 05:42:04PM +0100, Markus Pargmann wrote:
> On Thu, Nov 21, 2013 at 02:22:08PM +0000, Mark Brown wrote:
> > On Wed, Nov 20, 2013 at 10:04:16AM +0100, Markus Pargmann wrote:

> > > This patch moves the statistics to debugfs and disables interrupts
> > > completely if the kernel is build without DEBUG_FS enabled.

> > We can still see the error counts through /proc/interrupts even without
> > the debugfs file.

> The interrupts are visible without the debugfs file when enabled through
> SIER register. But it does not show the specific reason for the interrupts.

> I am not sure what you suggest. To remove the stats file completely and
> always disable interrupts?

No, I'm suggesting not disabling interrupts completely when debugfs is
disabled.  Since we can still see the interrupts happening even if
debugfs is not enabled we're still getting diagnostics.

--6tPipYVl+OcoAvSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSj6ORAAoJELSic+t+oim9AbAP/1UjE6FddQfZ5an3G+vQRVZX
ZcVKm9ujvs5iQpow2hMPWCkAKlm92b/O0imQCl1wNz+2laWFySyfq4E6F7/YDWKo
YTIoTcYKd7nJmYxsD83PFCz118dVWU15a+vTbQsDPjKEgBGyGVkeCYcwy6NNrHEA
bwmSQdhfESoKrvoLBwGrn6MB+ankxEy1nbtovuzbBuZDpUH9BlVcy+r2+GpDklYL
rgaC6aqCv85qKU7YzCejco3/6p4Nz7rBoPcJqFVSz0afyeueCsBTETEG5g6kylzr
DuZnh8wWfE5PMxMHvSe1QhE96wvDpZMlE2jquByvQcvOZhAkC+Hpya5f+o+U7AVu
zrW9T3y/ua/wOahYKc7SVDQkljcBaYgZred4OhD7DYauu1RdPwKEAX1obVp97ipj
eHjaVKVbzXFTYsQ1KsnMam3kqodlbwnYfCOAhcE5zZ1kSfwioqrCURzTzMDKhxwA
sgEUVDtElxBfoldy1f5LFkYzInqiKEcE99wlHzC+1Cw/TlBtYJ5rePURX6fctBYS
OuVXbtDI3Wi1Cq4InxFIn+rynQuiHDb+lgwbrs56xTl1cBVRAtOHo4uIXOLBM5Mm
/KFMEm1vGgI8bm/Pf4oI6H24qeRuSgtN1W4ulz/qDOvEqurR3lvx+zqxORklYids
iC2aXRQQ6D+V8jbHyaW4
=cHNm
-----END PGP SIGNATURE-----

--6tPipYVl+OcoAvSh--

--===============2981551345852175018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2981551345852175018==--
