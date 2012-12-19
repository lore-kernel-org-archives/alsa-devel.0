From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix the unpaired
	runtime_get/put cases
Date: Wed, 19 Dec 2012 09:11:27 +0000
Message-ID: <20121219091127.GL4985@opensource.wolfsonmicro.com>
References: <1355913397.17896.10.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6602134240804818888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F03B261716
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 10:11:29 +0100 (CET)
In-Reply-To: <1355913397.17896.10.camel@cliu38-desktop-build>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6602134240804818888==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KjSGHOmKKB2VUiQn"
Content-Disposition: inline


--KjSGHOmKKB2VUiQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2012 at 06:36:37PM +0800, Chuansheng Liu wrote:

> But some devices has been set to STANDY bias directly during device probing,
> such as cs42l73_probe():
> cs42l73_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

> Then it will cause runtime_get() not be called but laterly runtime_put() will
> be called. Also found some other uppaired cases.

This is just a bug in the driver, if it's idle_bias_off then it really
should be starting in _OFF or at the very least starting actually in
_STANDBY (including taking the runtime reference) rather than partially
in _STANDBY.

> So here add new flag get_runtime, and the logic will be:
> 1/ when device is from off to non-off bias, runtime_get() will be called if not yet;
> 2/ When device is off bias, runtime_put() will be called if runtime_get() has
>    been called;

This is really not a good idea at all, it's just adding new special
cases and making the code more obscure.

--KjSGHOmKKB2VUiQn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ0YPTAAoJELSic+t+oim9hqMP/2l1ssTb35Vs8asi4E3anOMy
iOs6WNQ6mk7hhDeJrfv4RXLO8+u40c7N9jE1RluGjollfBfyhvjrME5LlVFc2M8P
ADEqt8x1IcZMPBMphYo8qPn6PdoQEwKWZSmS3XICC03NuYSQTR8v08hVWHdWAKZ+
tXYD0ucmUwr3MtZbT2OXOlsi+YIujTdW/XU3ysB8GbrEwUSl5FA+ErlkXQBTE5mX
XvYmix+UpmBSpgStCjJ17ZLJS55uswGHNLRD2Ic9PPpX97ruoiLQtb5HWPf3qCOI
PeAXHFBVHbnkab55v9+joAYwCuvEikO2D3xsXaxCPaApzlNRrJdpnn3y5Vcdu8lK
U7dSQIM21h1UP2hBbV4qj/2Qq+5oCvAr7tz8Ypuy0ngxe3CMYvwTQj6By9reuVy9
ekHvG0q3xW0T8mzDik0RN8xzFhI/pqcJ1uXGANhtkG1NnvyZIGCLRogA2XsOPfdN
Kc3utWmdY5ljAHqLe4rijnsN6sssykU9zOfnB3Nk+3IoBb1j8TCsteJcam+gIS4l
28h2sDV1A3d94o97ZTaz+QqDehj8g+HkWPWeAecaJI8ZAEmKI2D5cuH9vxhORAAX
WRI5ZJWKOaCIqkdGA2oZqVgymCdAtyRmw94ZtgBVfmKP+q+2NGroVcsAZZRv8+eX
dVE3wVpSGF2r8vl4NpLa
=mott
-----END PGP SIGNATURE-----

--KjSGHOmKKB2VUiQn--

--===============6602134240804818888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6602134240804818888==--
