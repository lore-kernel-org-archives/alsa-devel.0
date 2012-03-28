From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ep93xx-ac97: use devm_* helpers to
	cleanup probe
Date: Wed, 28 Mar 2012 12:38:11 +0100
Message-ID: <20120328113811.GN3232@opensource.wolfsonmicro.com>
References: <201203261600.09454.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1076014306371051911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F6EC103F5E
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 13:38:38 +0200 (CEST)
In-Reply-To: <201203261600.09454.hartleys@visionengravers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, mika.westerberg@iki.fi, Linux Kernel <linux-kernel@vger.kernel.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1076014306371051911==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AA9g+nFNFPYNJKiL"
Content-Disposition: inline


--AA9g+nFNFPYNJKiL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2012 at 04:00:08PM -0700, H Hartley Sweeten wrote:
> Use the devm_* helpers to cleanup the probe routine. This also eliminates
> having to carry the mem and irq values in the private data for the remove.

> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.de>

Applied, but please:

 - Think more about your CC list.
 - Try to avoid putting it in the body of the e-mail.

--AA9g+nFNFPYNJKiL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcvfbAAoJEBus8iNuMP3dHJsP/3UKtNyTkgbFo3rIuSWJT0g3
NvCpXWI5d7P39QZF1xSohcbf2uIjpHa7/KbgqNm2v18hDLmVNeoF0zQMxg4lsZCs
BABTJJAQcEHXn6fi3ifV9sNn227akHszqFdoyVmd3ayqCp8yegdn8Jqnt8la6MG9
N1W5f9Vc63nynbbSJXnUkD3fObAkLxxM+uLDX2CDGW9oPiNVLcTwmi9y4/WiF3l9
cYsG6Pdx2ZNHLbwHmkWYaI0vlMScYpE4ah25CxfBRKg+RIF1hvILhCwRMHvwxKjS
eh/Lf/Y+AyCgbeU/zqafK0Nj8w1bL1thzNgLVVNxaZIWst2RVPsydW6AFkQhNIrr
j4flpVh5PVtCwhqVsgzSvb4HcqVxcPPY7YEBwmq4XhTKq+RZ41MpFlBoMb92uy8d
YdMcXh3leVESUmk1CAnJkfRwYMHb7fAk2C+2Mt98nQwd7QnqZimNphon1rMDr0zl
qGIXKR0yPdDFsnRp3JaVcy7dYxJsPArLnb+STXoyLA/lqQCvZmAqmkHFItoBjRYc
dlczftj3lnP5Mi4Wmk/MWUyBag3OP4FBeT0q2x3AvcIJjqkZb/GLYmQTmmUtye8x
jdU1vHVQs6lscwHuEuZp+dnc2JFdRJwd/vfeX/FXKYuMllJGqQeNmQM2Eb88iRRa
Ko7yvrBIMsudrERkTXZz
=qx3B
-----END PGP SIGNATURE-----

--AA9g+nFNFPYNJKiL--

--===============1076014306371051911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1076014306371051911==--
