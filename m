From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: DAPM - Use dev_warn for debugfs
	warning message.
Date: Tue, 6 Mar 2012 20:08:11 +0000
Message-ID: <20120306200810.GC19635@opensource.wolfsonmicro.com>
References: <1331057605-4542-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6313953363986787815=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8209E2440A
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 21:08:12 +0100 (CET)
In-Reply-To: <1331057605-4542-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6313953363986787815==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b0bHyb0BmsSIM7d2"
Content-Disposition: inline


--b0bHyb0BmsSIM7d2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 06:13:25PM +0000, Liam Girdwood wrote:
> Remove printk(KERN_WARNING) and use dev_warn() instead.

Applied, thanks.

Everyone else seems to be doing ASoC: thing: rather than having a -.  As
far as I remember it was Peter that started it, though other people
(including me) adopted it too.

--b0bHyb0BmsSIM7d2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVm6fAAoJEBus8iNuMP3dwEEP/jBIjUCMKjF1nskqoba0mjhy
c+esDyFXXKB5cDvAJAUiFwYVdAp/bmkFVRcdfVLFaDBi9pbXDZNh+Smzla5WCRW1
i7j8yjbldejaug1BBH3wcdXb91XARaiRbkRaGhWwDw+TNjxX80liI2cQyOyXKaF5
dwB5rqdel0IaSyhgSpl+Yiy50yb8eYm9SO/hZBAX6MDBvEtR8+kIkWrxPLzgrIWj
WHIqDqNiq2OdWfyzPJ4pyQfyw1Py4AtEqJaKluM9v3SSfAWEsE3ZmE/uORov14XV
gjfYlcjS1kG21s+xWXlouxUBAasl0CF2k9tqzl9XaVcO4F/DGI0qNZhXp27RfAz6
RLCQnMWZviasqx3MuUaLl3zPhVSahVuNy/XI3ZhkjvTCPUaaX4vRDD+JCYRV90pY
bbgp4kBdlQAun5voEzvTg4fxLZRKbdIkbGapOmoYOGm3+Pk5ZyYOi0htNFlidHIF
AlIUhAb7D128y2PLS8/ubET2C4SuzpinLCdeiMeMg5GmzYFkDmZaFLCo6mNeKYd9
Jew5+RbT3CCuAnXEYHAoU0xrH7NSUz9tR7YY9vnC0cHmgDqwK0CaXV2nYa0scHjp
YrGVCYZwYShG0Oaq2eRy4m6GEl1R0eRSP5z/6lRm7mdaIOywfjlhaxDuxVTc4Llq
9O299ZOReHhafDI9iQb1
=1suE
-----END PGP SIGNATURE-----

--b0bHyb0BmsSIM7d2--

--===============6313953363986787815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6313953363986787815==--
