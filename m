From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: ad193x: Split SPI and I2C code
 into different modules
Date: Tue, 18 Feb 2014 10:06:08 +0900
Message-ID: <20140218010608.GN2669@sirena.org.uk>
References: <1392639416-11293-1-git-send-email-lars@metafoo.de>
 <1392639416-11293-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0193195241802590758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B1A2265166
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:32:49 +0100 (CET)
In-Reply-To: <1392639416-11293-2-git-send-email-lars@metafoo.de>
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


--===============0193195241802590758==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8/wErwm0bqugfcz"
Content-Disposition: inline


--e8/wErwm0bqugfcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 01:16:54PM +0100, Lars-Peter Clausen wrote:

>       kernel if one of the subsystems is build as a module (Currently only SPI
>       can be build as a module).

Same issue again here.  You're also going right up to the 80 column
limit here and...

>     * The module init path error handling is rather ugly. E.g. what should be
>       done if either the SPI or the I2C driver fails to register? Most drivers
>       that implement SPI and I2C in the same module currently fallback to
>       undefined behavior in that case. Splitting the the driver into two
> 	  modules, one for each bus, allows the registration of the other bus driver
> 	  to continue without problems if one of them fails.

...and something is messed up here, looks like tab/space confusion.

Applied with fixups to the changelog.

--e8/wErwm0bqugfcz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArH9AAoJELSic+t+oim9zXYP/0nM/GZgBuayrdNGScNNMu5x
cY23oab0DK6QKfu3ZvdbtROcPFfYO3jun8k4FCehRCAe6wT/odpJUe5NrjDmcoaM
Skuz3LgTDJUiVm1dp17NHuTAehUXhFCSHvg/mA6EwLhtW+1UptmzHhtSKBiTGyky
ySNw7NAVcZvkKv3vbcthS0UxQ7gVW7Y2CYv/uqVXe0GxZ3gk1mmNBV4NbtZhpDsq
sBn5k8eMwaX+skGNXb2a5cjNNaVs7vW+C4CTIeJ/7/8mhLiirIzzVu6KqwotmybI
A3M4Qv7fWSSJVVt7QubbilsDaFWqYBElFqimseDpcDWm2ZAnkkuPtMkwqFTwfQRv
6MbK1SU6nWmrlURAuRPagyBeEWTakX40S8k57PFgmIbmmCuXEkj4TJo37nckQ+M0
JxnS+fxztR1RtLx8t6e6u5FlUjy7XLygYpTxcEV7uFv8MSPzg3vkAx/04gbdgPDf
JpTEJtaWiSYaaVBpNQkzDBxdMMr/3bUbDzyY8d82qtGAn2wyFQiUSW4XKHlS+6KX
O/2Ro72ERxb+zNpjCoCjh8t3q010EY2JWsKj9KrMTwuf7X5xoRrjdlAqqqCmfatu
OlUy5h/iSr5m0o4hPvZ3c7g+3Fd90lTGddrVCDLngU8++kA7zvntMrFbP/mllHuF
HKUuHy9577c4ch6PWaSK
=DqPa
-----END PGP SIGNATURE-----

--e8/wErwm0bqugfcz--

--===============0193195241802590758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0193195241802590758==--
