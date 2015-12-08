From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Tue, 8 Dec 2015 12:47:13 +0000
Message-ID: <20151208124713.GQ5727@sirena.org.uk>
References: <1430be98728abfe543d9a1e245d9b80f6d8f3c44.1449567072.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3724799843949066852=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7554F26607D
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 13:47:24 +0100 (CET)
In-Reply-To: <1430be98728abfe543d9a1e245d9b80f6d8f3c44.1449567072.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3724799843949066852==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LqInKle6vr1NBc7W"
Content-Disposition: inline


--LqInKle6vr1NBc7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2015 at 05:40:13PM +0800, Zidan Wang wrote:

> + - aifx-format             : set format for aifx, such as "i2s", "left_j",
> +			     "dsp_a", "dsp_b".

> + - aifx-bitclock-master    : If present, aifx wroks as bit clock master.
> +			     Otherwise, aifx works as bit clock slave.

> + - aifx-frame-master	   : If present, aifx wroks as frame clock master.
> +			     Otherwise, aifx works as frame clock slave.

> + - aifx-bitclock-inversion : If present, bit clock will invert polarity.

> + - aifx-frame-inversion	   : If present, frame clock will invert polarity.

> + - aifx-continuous-clock   : If present, bit clock will be continuous.
> +			     Otherwise, dai bit clocks can be be gated
> +			     (disabled) when the dai is not sending or
> +			     receiving PCM data in a frame.

Why are these selectable in the machine driver?

> +		model = "wm8960-audio";

Cut'n'paste error here.

--LqInKle6vr1NBc7W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWZtFRAAoJECTWi3JdVIfQmM8H/2/nBmXw5rkbliJv2icMo7km
yVPa2HmtjtLyk6/1/7phkUnJnpgdDBs1Nu1vezK9vEZZYrKns40MOkDWYaybsKkK
avNSe0RXrnUEKsHwuaZWU2E9PXNAefX85SgIMKhv7Ip4ZNbwYtKFoMPd4ySXkxMM
jHYp5YfgywXqRb9JIq1/IVVb8QPcUjDjYxn0pTerc7uDalpUc8Uk4axxsWdMMQuu
hNJ74+rUuK5l3mYynWiq7xXF7MKhIgd8mIQ5anmwfXhoP2UHguHmBP7n+sDfBOXS
ba2ltlajqlC2Nv/AMsnfPlVxAceAsXnx+rxRR0vEAUddj/t9d2SHYVodiz5dfCs=
=kJUu
-----END PGP SIGNATURE-----

--LqInKle6vr1NBc7W--

--===============3724799843949066852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3724799843949066852==--
