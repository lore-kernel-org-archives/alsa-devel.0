From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/10] ASoC: ux500: Store DMA data in the DAI differently
 in the pdata and DT case
Date: Tue, 19 Nov 2013 18:51:06 +0000
Message-ID: <20131119185106.GI2674@sirena.org.uk>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
 <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1IYcr18XUmgwOrO2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384859269-19801-8-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--1IYcr18XUmgwOrO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 11:07:46AM +0000, Lee Jones wrote:
> In this patch we do two things. Firstly, instead of open coding the
> store of DMA data in to the DAI for later use, we use the API provided.
> Secondly we create and store similar DMA data for the DT case, only
> this time we use 'struct snd_dmaengine_dai_dma_data' which is provided
> by the core for this very reason.

Applied, thanks.

--1IYcr18XUmgwOrO2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi7MWAAoJELSic+t+oim97TIP/RYJrwHpHTHs47UaBuycd/Bx
iYV2kAxg+T5HB4QhJ/A0O9KNPoCzSQqWFtFR2htNoCD3wqYx/78igxuCF2XBtqVE
r9hXdjazV+D1hBNVzUaFfINYenCGdBxBIP/TCA10JxIoPqLweVci+fum31h1qUiJ
63gdIDixIhYE/0k/+PNj67cKjiJx2lgtHcCsF7Cup11TcOxRZy/doJ50frJf7Lw2
E0xiPbuNEzhi1zFyyekjS8SWYZwkAtrfj6IIDP5yZ9Hrqe/T/riVZKLCA/RpkhV3
ad1QVZ/A/ywE4QE9010k6eYsXIMrBF7jwzwXczNTgpkjanpzZK2LS6y4u54wOndO
WgppGO0Lyz0n9BMjnLSVBsjMRZgdEK5BS7Yx39R8rQO8jwnkbVLlYkYhy2ML3gf3
1xIkGiPkPpoKlgJBc7WdH27OWCn4BpyZ7Hg8ogq6r9+l3/+VB1Zpv7bYpKRxJ3Bl
ZN4nF4a7dRLAxiuZzrB2EzTkm5wQPdvjGvsv1T7bj3qRa7A1UjGueooFiKUoiF0h
DXaIIyxfFUMHzzvVb6KAF4NL0f0HeO7rk0oI52tv4LatTBKs6UEUh/91FbW1AJgY
sA64DVXlyz6LgXX3rajEvamXIfXtt1hGQW/NpILvba7droMwzhEOSnM81mA3ZLwO
SlsMyH1gGw9XoDwVkKOc
=Ht2p
-----END PGP SIGNATURE-----

--1IYcr18XUmgwOrO2--
