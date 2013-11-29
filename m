From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: Add support for the Analog
 Devices AXI-SPDIF driver
Date: Fri, 29 Nov 2013 12:06:29 +0000
Message-ID: <20131129120629.GU27568@sirena.org.uk>
References: <1385665372-29477-1-git-send-email-lars@metafoo.de>
 <1385665372-29477-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2472299853773091013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B01C26556D
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 13:06:32 +0100 (CET)
In-Reply-To: <1385665372-29477-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2472299853773091013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pq8tEKHpn00JYbZk"
Content-Disposition: inline


--Pq8tEKHpn00JYbZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 08:02:52PM +0100, Lars-Peter Clausen wrote:
> This patch adds a ASoC driver for the AXI-SPDIF core. The core implements a
> simple SPDIF transmitter and is used on some Analog Devices' reference designs
> for various FPGA platforms. For now the driver only support the PL330 as the the
> DMA controller.

Similar comments to the I2S driver here.  I'd probably apply them but
I'm holding off in case there is review of the DT bindings.

--Pq8tEKHpn00JYbZk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmINCAAoJELSic+t+oim9KqcQAJYXP7JElDOEu5Tzpl7pFQFi
FxYyN2/r0DhIb21t1O6MJe6HCGxZ6DPSxDOJSzUWvyp3TSd86pQljzVzj8Ofa/Z2
K2vvNpTHQp3i4NVRtd/UcdRC5bYlp9PreoY6IXDWvNlcSUC8WHwK1bY4UKrNeXKn
6QHt4+SQKCF252QIkn6ARTohg9i3CdsvQkp+z18HvXtQ1z+4C6gPhoHRzPdsNZBE
O0eh/6jss/cOYDQgQcOQJSBY+nlqsS3sn9ZYmvS8yGvrA4aThHakqrodFUBtnMu5
hEpy6kUmQU3bj2BE7CTUi0e40yUjxk6RPjQ1F6W6o8oJk7a1f5tAHA3gYRLXvsN5
Gbup26tMqpTN8V2simAGNmcgGgpplxjYHdAjsENeVenHmo94xluKbqRPS0YSDqd1
duwDnQ+g/CbaGmnPkqv4J2Z4xles9eeCRbUo+ezIezJXQk9AZCplbViHPhWzaZIV
lgFQmXVJlLAe8Q7RJ89ll/YxO7//2daiZiqXeoVE5Bnu44MRZ7Yyb7oE+zMtFxV7
vNY0BJeaT7+oNi5yRYcnnou+Ah4UfIEw40+Ij8Dd2Nx9V3MwFJYTsVWb0k59ySFW
rRx3Lmlq0Ca04LSCgrAeuBYZLtwuqyQBnMGVNpHrFg4aAIbvXW9EagfGKky1WZ1o
xwdprQu4Ai/ElywRKOxs
=izkP
-----END PGP SIGNATURE-----

--Pq8tEKHpn00JYbZk--

--===============2472299853773091013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2472299853773091013==--
