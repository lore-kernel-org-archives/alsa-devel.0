From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: atmel: add wm8904 based audio
	machine driver
Date: Fri, 19 Jul 2013 19:06:40 +0100
Message-ID: <20130719180640.GS9858@sirena.org.uk>
References: <1374226977-10188-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1589702500555351179=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E91B4265759
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 20:06:45 +0200 (CEST)
In-Reply-To: <1374226977-10188-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1589702500555351179==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QHhm1I6mwQR20oIa"
Content-Disposition: inline


--QHhm1I6mwQR20oIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 05:42:57PM +0800, Bo Shen wrote:
> Add wm8904 based audio machine driver for Atmel EK board

Applied, thanks though...

> +	mclk = clk_get(NULL, "pck0");
> +	if (IS_ERR(mclk)) {
> +		dev_err(&pdev->dev, "failed to get pck0\n");
> +		ret = PTR_ERR(mclk);
> +		goto err_set_audio;
> +	}
> +
> +	clk_src = clk_get(NULL, "clk32k");
> +	if (IS_ERR(clk_src)) {
> +		dev_err(&pdev->dev, "failed to get clk32k\n");
> +		ret = PTR_ERR(clk_src);
> +		goto err_set_audio;
> +	}

These should really be devm_clk_get()s and use a device.  This can be
revisited after the common clock framework conversion though.

--QHhm1I6mwQR20oIa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6YAtAAoJELSic+t+oim9Z8wQAIwPA+NLNgcF5wpF6sDGrAX4
whaqsklBUHymofdSppfsASqEZciHlbFfoM83b5UW2o49R04vNelqaVemIwMb/aQH
OQfc1YAPr1ed7M/odN2hQRb6szlF3lkiZZQfaC9FFqY7oMYwvHvctPodtoGsIrO2
t0Eajcsdo+4UPdC56G9VTl0HWW9SyC1FQjiViMxyphDxQfGplaNKk6GzaiHISv2G
1UWN28crYqyZMfOuKam7Y41ek/yrHnYZLT4+WG02XnWTawacO7zfm1HTvOYTNk4U
hNczwHhj7sow6Zmtl5gZqqlY6it4s6J3a4OtIOm+EKCtugho6szxHSipUuOZNNNK
EJucRMUsEdfvHOQTQqY37QVNOXuK9vF5odF9IHaIyHEWb7ug0jL76plOrJqXrkiX
UNyqCBPqFeEHp9/9mWfV2qAVqpY6EokV8gKZouCB2QUJNHX+3VCVxDktIhAiEXDO
VSewpQFk04nIsfMqQD4NqTyr1An+qIH56bw8vQj2WZygN/uWVwTpMatc+oo+jNWd
NwHQMxsHQeq0BzW6wTD0hH2WzH0NWstDV2+8rl1HRKzfs7sJtBZoE1XHbdmqQF82
Emdg1tS5xlc179EM3G2WoexeETJ/zudhoDi10qrcZkguSkraIMyJdXqRXTQgJ++3
PoYM5r9UyLUtqm3dqmnv
=YeMp
-----END PGP SIGNATURE-----

--QHhm1I6mwQR20oIa--

--===============1589702500555351179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1589702500555351179==--
