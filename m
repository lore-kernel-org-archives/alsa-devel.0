From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] ASoC: sirf: add sirf platform
 driver which provides DMA
Date: Mon, 28 Oct 2013 09:11:48 -0700
Message-ID: <20131028161148.GC13643@sirena.org.uk>
References: <1382912628-13796-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9144994520623670896=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D30261689
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 17:12:12 +0100 (CET)
In-Reply-To: <1382912628-13796-1-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9144994520623670896==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 06:23:48AM +0800, Barry Song wrote:

> +static struct snd_pcm_hardware sirf_pcm_hardware = {
> +	.info                   = (SNDRV_PCM_INFO_MMAP
> +			| SNDRV_PCM_INFO_MMAP_VALID

Can you please try the recently added support for automatically
discovering the configuration from the dmaengine driver rather than hard
coding things?

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbozBAAoJELSic+t+oim9R/kP/21qwF6kvRpCRNG8HyV8joAl
BH2OuvMZns0hy/ZskJZyK2jU8C6BG/53wNw9bNaB1z7Wg87v9WgbukO1kzhbAf7E
tt5AEKCDZdsgK+3epI/SxHKJ6O8jL4JiLHBStmc8Pmc0TcvvGaWpAxqU/SqfksAY
W+35LpdJOliU/EoSP2aiwAIhgGccweaA4EBvv20npE9Dk4uonHdZPwgn2JqyXRmw
2MH8J8N5f6L317mzwOKdgVwBfXENv32u0HLmqXmClg1XhbgbRPh5M3ONjpLg0NFM
p2cMQaR5jAmn/TMxHs1cQmyHUTbruVMyFHJdfMOHNiz8R+6f2rekx3428Zz2GwiH
a77DhCNW+ckE156v0TUg6y8sfGQDSeV2NsFQIAQeok+l29GcUW28ZmoGK7F5O3Di
iTIlIFpFzEZJ+xSe9DVw1FE8LF2qXs8RbxVm21EhGih/2lB7Hhf+v08mgldqR/kc
zWtxljzLjWtPWGRt4jdMWfoltkvoBtOJ1Rh3w+SC2vDOwq5slHFXGQ3DipP2xt62
uEl4KKBKBZ0nRdAzL5OuS+notBnsFDMbw65PZPGPdoicIFx/zOShjhWsVS3VvCxP
T+KPsKZD4rw4vCkKv5Z3Dw/R3onnR4X4cYWaK+J59sgsFJ203McrZIpUgQqc83I/
qg36/Z0jMibwe0A3PpLR
=jLpy
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--

--===============9144994520623670896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9144994520623670896==--
