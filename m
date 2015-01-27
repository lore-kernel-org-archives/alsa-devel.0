From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: atmel_ssc_dai: fix start event for I2S mode
Date: Tue, 27 Jan 2015 17:34:19 +0000
Message-ID: <20150127173419.GB21293@sirena.org.uk>
References: <1421739797-25988-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ORQ7wZOtrZMMlBRp"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421739797-25988-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, Songjun.Wu@atmel.com, peda@lysator.liu.se, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--ORQ7wZOtrZMMlBRp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2015 at 03:43:16PM +0800, Bo Shen wrote:
> According to the I2S specification information as following:
>   - WS = 0, channel 1 (left)
>   - WS = 1, channel 2 (right)
> So, the start event should be TF/RF falling edge.

applied, thanks.

--ORQ7wZOtrZMMlBRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx8waAAoJECTWi3JdVIfQkR4H/A9P2fsnUCnAEbiDDJk1U/N/
kPzDiSJ5qfXs9iy5Mm4UzkZ7wuzQiNQ3ei6BSpyRjfq8H3uWcnteYoT2C69WsT86
vZWp5mhS0eNgRn+kPE2MvSOJWB2yRZLce0Zpde/89iSKPVIZClkz/om0Qi9fOHsp
OClR2u32J9urS991BZofVaNpEQKxs4M7jccWZnNii3GQWkLaMUszagLsP9KC71ZM
e9KzOU55/h7OE7YOiGkNKL2uvIvyP91Ge8BQFAOJswuGvDrTbT4OfWJmoAPzR4h3
DwYuytWl3j2/Kd7QYqT6BM1sNoxv+gBNFM61oQM4nYDdChaanW6g41nIqwkoJt0=
=iV6x
-----END PGP SIGNATURE-----

--ORQ7wZOtrZMMlBRp--
