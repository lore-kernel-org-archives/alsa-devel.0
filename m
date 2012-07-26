From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC
	for Device Tree
Date: Thu, 26 Jul 2012 12:50:55 +0100
Message-ID: <20120726115055.GD3099@opensource.wolfsonmicro.com>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0494557238660219966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9580A265E74
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 13:50:59 +0200 (CEST)
In-Reply-To: <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, linux-kernel@vger.kernel.org, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org


--===============0494557238660219966==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UvwuEPigQXXfOf7G"
Content-Disposition: inline


--UvwuEPigQXXfOf7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 26, 2012 at 11:28:53AM +0100, Lee Jones wrote:

>  drivers/mfd/ab8500-core.c               |    1 +
>  include/linux/mfd/abx500/ab8500-codec.h |    6 ++-
>  sound/soc/codecs/ab8500-codec.c         |   79 +++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 2 deletions(-)

Yet again no binding documentation....

>  	{
>  		.name = "ab8500-codec",
> +		.of_compatible = "stericsson,ab8500-codec",
>  	},

Why are we doing this?  The MFD cells are a totally Linux specific
thing, there's no reason to represent them in the device tree unless
they're in some way reusable and the "ab8500-codec" name suggests that's
unlikely.  Just put the properties on the parent node and instantiate
the MFD cell as normal.

> +	/* Has a non-standard Vamic been requested? */
> +	if(of_get_property(np, "stericsson,amic1a-bias-vamic2", NULL))

Coding style.

> +	if (!of_property_read_u32(np, "stericsson,earpeice-cmv", &value)) {
> +		switch (value) {
> +		case 950 :
> +			codec->ear_cmv = EAR_CMV_0_95V;
> +			break;
> +		case 1100 :
> +			codec->ear_cmv = EAR_CMV_1_10V;
> +			break;
> +		case 1270 :
> +			codec->ear_cmv = EAR_CMV_1_27V;
> +			break;
> +		case 1580 :
> +			codec->ear_cmv = EAR_CMV_1_58V;
> +			break;
> +		default :
> +			codec->ear_cmv = EAR_CMV_UNKNOWN;
> +			dev_err(dev, "Unsuitable earpiece voltage found in DT\n");

The platform data code picks a default, can't the DT code do the same?

--UvwuEPigQXXfOf7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQES8YAAoJEBus8iNuMP3dwT0P/0QsSbEgelm7n6tociwR5ajK
p0T8qOAzbVHeg3n3C4ZSEXlE5X57NtwN0LzGJ6GPthhORRXZ1crPpkpGmFrJb+X5
JZr1bQ4xWc3LV7JkoPr9YFe4VcuqKgDXZqU2WtxsL4x0lMid4yDn0Y/zGn0VnRbe
yW8cIiW87AOEcVlSALPc53W3EGCIOCJfpV+AX+RDbv2I5FqssLOAUg85a0E9bgiE
TSwr4XQb/oQGJK8OeaBmU+sXx+qiKuPN8QsID0FQjrDwX5jkoAb5YUU0SqQCmmkZ
Tkry956vHmpxdZKKZlFoj6IbZLHaZTYckDkgKi3XsDZ0Z1CFH+Ho20X3dIBfQuZj
qnO59SB46kmFSv+8690lNUl6g2wR6unN0Y+CHONBrmM07GevJ480cJXb/ftFttuP
TkG/Y6MZQa5vcBe3qYGhHvAQGkf3epxX4O8SvSh6/4Ap32EvIgMwLmXPsoa4En+O
MqdWsOF5xbpTV3qEvDbnP/9EPjEF/RVqGtVE6A2krAPg+FDwU1pXZAPqxsM4gcOt
uBuI3+9NPI5WP2XjA1cxYB5nM8Ah0addFoJVmz2tv9/d6HsfSZ5BONx+WY6Ow6up
W7ue4OgppScNn9K01dipYp0LoRrKlHs2P65/cOe3va8plz26pH+xlblMCVxKihkB
cGf0vVd+vAIgfFcgNDQk
=TwLY
-----END PGP SIGNATURE-----

--UvwuEPigQXXfOf7G--

--===============0494557238660219966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0494557238660219966==--
