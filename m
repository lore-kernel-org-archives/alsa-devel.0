From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: sgtl5000: remove unneeded
 snd_soc_dapm_new_widgets in probe
Date: Tue, 24 Jul 2012 20:20:08 +0100
Message-ID: <20120724192008.GE3099@opensource.wolfsonmicro.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-4-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6451018608249354306=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 795C126528A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 21:20:07 +0200 (CEST)
In-Reply-To: <1342776027-31758-4-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: shawn.guo@freescale.com, alsa-devel@alsa-project.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============6451018608249354306==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 20, 2012 at 05:20:26PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
>=20
> There's a driver bug that sgtl5000 dapm widget kcontrols do not work.
> e.g. can not select capture mux with amixer tool(no error info prompted).

Applied, thanks.

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDvUvAAoJEBus8iNuMP3dpcIP/Rw5jVQ46IC5lEVmVCZM2VJe
mSRF0RRyzkNYZCT3F/TihPdGGDhgsjHoZAVy8lgZBFlv2be64pZ6R9tqKPuivWBj
twV/Ci3DscNXq7Wbg3ifF9d8pAHRiXuwci26mteCw0VRcY2Qe5xWLLrUK48b5oTN
+dXthEYhHZiYF+JiC5I3two3gGhXcr9Nx+HvuQYk4UY0zr/XMX/LdvwECQWbdb0g
TLR9ni0m0RTn3nbjIXo7WToxCASuDztmLqTvnDcRRNvhJLJhsEAQqVWcwd8h2Yob
x6tg+N21+Hsr1y1TcdytCtz4ogMb4R6u7Az/soYc3LMn6TDbZ5y8CodY4nWGS2Uf
0CCLI9+NfaXGSoukxRhu2LX40WvEfXstF7Wk1K++95w69y2sLcof5RHTvFcD2puJ
l6OV4zlUJJaWtwBvBjkgML6Ce0z5UrVEBdM32aT4HXpTW2mkAHngLwBR3SC4I2OZ
eC45Xax/dGHVw9YJy+eSQmixPD7PoAjFNv2sInrFyPGUiscNmfjdWT2ig4m57b/w
7PcOnrMyTmqpJlU2Ih0YXTJfDSN71Cpaw66KynU49KEIeucNkKP6L7bZFNAk4fiW
KBn3765wCsdC8SXFZivXEJ323LCIgCYyqX8nO+shIFwTHYFRYriwUgP2xHhPFS/Y
KSBcBhQvDvuQ6GdcEill
=EktK
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

--===============6451018608249354306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6451018608249354306==--
