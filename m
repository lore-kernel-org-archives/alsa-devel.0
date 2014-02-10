From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/8] ASoC: da9055: Fix device
 registration of PMIC and CODEC devices
Date: Mon, 10 Feb 2014 13:43:10 +0000
Message-ID: <20140210134310.GH1757@sirena.org.uk>
References: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0072693866589601344=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EAB2B26162E
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 14:43:20 +0100 (CET)
In-Reply-To: <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


--===============0072693866589601344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nCRcqX7cEx7rr7Pe"
Content-Disposition: inline


--nCRcqX7cEx7rr7Pe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 06, 2014 at 06:03:07PM +0000, Adam Thomson wrote:
> Currently the I2C device Ids conflict for the MFD and CODEC so
> cannot be both instantiated on one platform. This patch updates
> the Ids and names to make them unique from each other.

Applied, thanks.

--nCRcqX7cEx7rr7Pe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+NdrAAoJELSic+t+oim93b8P/17Anp84nsAFWorx9xQf4jiW
05Bn8ZIUfZE1UqyyozfwO1Dw3W/EBzEZm0Y3EGHKabKaRp4zYHHcp5vSqi2DJnDb
y74BFAhX3Vr0/A7mKVe05jaGwHtJa5aMLl0XC6j+ZOT68tDz7WQuK+y5cV29rfr+
AyBd3JhugJlQl3FctoQ8HGtVf1/ZUT01jHTZ0F0fX4nGOIF7H+mf0DxPitCcZfda
hkb/rD1VYkN+LiN+vB3yHgnBT6zASIPi7DghfDwLTlcbBIWwxeFCqU8l4bR7qfqD
cS1Q9Ac383CYEpyi0s6puCxgEj7UYpnAcabRv3cStWiI+jKMyxXkyITwqSanylfh
/uFUBlBOorVC7OWnNWvRXi3epNCCr3GeWxDcSZ20toDYXrIMK9ZYKN4zJBGQu15W
aksoRqMA8d62zkCwZkNt2PexkNUFGHDPrIqEJZnmikkSJ4aFgsJsFAYSsKZi8rWe
KdJzSQV++dEb5R47SDnxLKlZnJoM8uGWP0Y9c/MycMDWBZLXm7QWDaY7vuTXQD0d
8E/fCOJU+AevCU/HhGcy5RB0VP/tBMyQ2x+b8PlfbcKMcCpevdI8BNoQpF93vey/
7UvmqIyLSn4pugWNHqDXwvBhzTqcplRLKGAhC3bN6pveP1JNi4NxS4be3ei9fpUs
882sMbyf/va0TWO7byoc
=Vkel
-----END PGP SIGNATURE-----

--nCRcqX7cEx7rr7Pe--

--===============0072693866589601344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0072693866589601344==--
