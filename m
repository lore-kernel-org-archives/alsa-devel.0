From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 1/3] ARM: at91: atmel-ssc: add pinctrl support
Date: Tue, 13 Nov 2012 17:50:54 +0900
Message-ID: <20121113085052.GR18224@opensource.wolfsonmicro.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GTGEtWEe6jD60dxL"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352706028-750-2-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--GTGEtWEe6jD60dxL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2012 at 03:40:25PM +0800, Bo Shen wrote:

> +				ssc0 {
> +					pinctrl_ssc0_tx: ssc0_tx-0 {
> +						atmel,pins =
> +							<1 16 0x1 0x1	/* PB16 periph A with pull up */
> +							 1 17 0x1 0x1	/* PB17 periph A with pull up */
> +							 1 18 0x1 0x1>;	/* PB18 periph A with pull up */
> +					};

Do we really want the pull ups here?  Normally CMOS devices don't have
pulls, or the pulls are disabled during normal operation, as otherwise
when the logic level is different to whatever the pull is doing power is
wasted driving against the resistor.

--GTGEtWEe6jD60dxL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQognLAAoJELSic+t+oim9AaIP/1vML3ZA6L6eQ2F8+W6iMh1R
B10qq3SKb7Ye4NI67K9ouCD9N6fhrXobEM9vDvKTUi1aKkNE9wIbBMWgF6aNeG9g
qJJXPa17bCSl9ZzLAc+cTWI5+4hfydCk4Adsk0Q/5pw7CCV6wMPOXtnUDo7u+Tys
BuG0aGu7zfsogpIn1RxpsdIHI354wsvLbrkUIsQWnxO1A4a0UzuUYOtn1I6OS8EE
r0Q+iYRhhRT0cTXynux5ivU5g3AobQGe8v2NVOWfXZUx2JPxRH8wQrTlrc6Wdn2C
PcYRR3WBJMkLTOKfdyPmupC5wf9hF8LfcEpQnBVi2x3n+zGcj0kYXTE8odDTRKVh
z9flhmHOSNwPhyCNy9qfAvSLXtZSxqw+z/UQzV46ulay6L9zj0Q35EVsjMeRpMGm
aUk+t8BCWog8esvQRCmSnljn8I8ACXsYamZ3mn3lsI0kjMSX5Bx9byA7vKBN29YC
gstFcVYNDsR4q/AqYFhvLaaLVAmrAiI05Bd/t6AAF7bV4mfJruj1cQjir89Ci1A8
+Exg/HO0gC3nDvBaoH5fJrOvl05Dub5QJjcrLv4+sveMjcv3G+4pNNnO/AzncezL
VDoOrNTMjpy5kzubdehv5vzlIzt7VfwBc9VOyY49HoSpZY3T8R1pSa8arqS06o+U
QDK/e/hU6SEw0Sr6LcVi
=DiO7
-----END PGP SIGNATURE-----

--GTGEtWEe6jD60dxL--
