From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix maximum value for
	microphone gain
Date: Mon, 24 Dec 2012 15:31:47 +0000
Message-ID: <20121224153146.GB30837@opensource.wolfsonmicro.com>
References: <1356284731-19380-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5804350309653043830=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 24040261637
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2012 16:31:48 +0100 (CET)
In-Reply-To: <1356284731-19380-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, eric.nelson@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============5804350309653043830==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 23, 2012 at 03:45:31PM -0200, Fabio Estevam wrote:

> -	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 0);
> +	snd_soc_write(codec, SGTL5000_CHIP_MIC_CTRL, 2);

Hrm, on second thoughts I see we're already changing the default so I
applied this but we really should just change the driver to leave the
device with whatever setting it powers on with - this is an example of
the sort of thing we're trying to avoid.

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ2HVcAAoJELSic+t+oim9ohkQAIS+wkrc/SzNqmVeeDLwyJFJ
xf1PUeYjg2xYZWihnH9qmpzP92439oyQO0ae0bX7JpHqWkbOo8AzuL8mcnIYgOJQ
RuFEiXDf28P50nONRhFbl/54NlyqSpE9jU2dO0LYcO6AJ6zmfiCf48iMgmjvQhUX
RnfXsVblv7UPIkSqaNIgaEAQChIgXVKp18e268X/emvawXIQ38QrXM6e618n4z5O
rGazyjmZ+YGRY7X8F8zeOC9Nwr1myRx5vzuZJlgzxhfV2nPzloAV/qxv0wAu6r0F
qsZs/OTvFk0sqR0tIbMcEt5V/MZEj9GhTLk8KZ7Vb98Uay/WmZRgsv/JDyKxUFTl
w2cEtrb4TTz4Mqqv2y3zO28H2jbWOeEBegrs56Y9luWmHPzKpaslgviLUBnjkPnH
QolCTcwy6PL3+Dg7GhSgoqsmDlsvpAHf3mhzP4zp471h8MAOoSBvmuwd6MRbvFS/
XLwkcCDk7oLa3Zs80AksFPy+MRggfIH3iLJsUvrUPTt4fdKZedgqyXUC/utatl+y
/NGoklHNtIoxz9C3NtqKENYrRmxXsrSQo0XBrZ1KpWPD53L9pF11WBg80ytyNI8d
UtwwEGj1KvkCJY1NdX6fPZ3xWt7l65GBYe6kx0qsSRl/ywlPZ6A3jW8NsiECk02w
AQPaJesTvWLaIjxRaCG2
=qyb6
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--

--===============5804350309653043830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5804350309653043830==--
