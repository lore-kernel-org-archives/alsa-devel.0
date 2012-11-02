From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: bells: Up clock rate to 48kHz and
	512fs
Date: Fri, 2 Nov 2012 14:05:06 +0000
Message-ID: <20121102140506.GV4413@opensource.wolfsonmicro.com>
References: <1351861316-19739-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5464578571094170201=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E10C7265086
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 15:05:07 +0100 (CET)
In-Reply-To: <1351861316-19739-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============5464578571094170201==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6h64vBu9tReNbGLX"
Content-Disposition: inline


--6h64vBu9tReNbGLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 02, 2012 at 01:01:56PM +0000, Dimitris Papastamos wrote:
> The current WM0010 firmware images expect a 48kHz * 512fs
> clkin.

That's not actually the case, it's more flexible than that also...

> -#define SYS_AUDIO_RATE 44100
> -#define SYS_MCLK_RATE  (SYS_AUDIO_RATE * 256)
> +#define SYS_AUDIO_RATE 48000
> +#define SYS_MCLK_RATE  (SYS_AUDIO_RATE * 512)

...if you're doing this you need to update the clock rates supplied to
the CODECs otherwise they won't be able to generate the required audio
rate.

--6h64vBu9tReNbGLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQk9LUAAoJELSic+t+oim9p64P/2OH3Gw4LtYoMtnNioln2rln
kad5GHg+JNgJVr5QORQuKVTn0aQTqL4oa0jTxNlffJQl0xCRkdd4exCuXuAfxCpP
4Bblk8o3vFYQzaj5l4tvPgzXvxtAEHTnTFv+X4BwdlCQgmqRcs2K++9Cso3up3Ar
FD6kVmOq5jCrCFrGywMGqwiJjXwiwc73/XzhnfE4SaaHqe6ScAv5eIxNb0WVv5X6
lZpC2BvfD39nKs9I2i2Z84KGvVQJo06K5RdarR0+f/5PdoYc73sYfVfBdsZbCvTu
/thc4o2mq9AaVEbC1erHVf6D12pJauzbPuwHzFPKx9TKrceeyR7hbmlkvTYEJAsW
zud5NWojwvg+NvHx+wMfCLENQsMSkNyFAJTL5bkpNLc1o/X5Az5mlfUqNm2KnFVD
7RDLyfe/FOcDWUuusBa0E4ucGAeccZFrSwjbaO249r+kM/DyTV4cTDkPFenyTMDS
PfCE2sYng7U27UgF7uton80iSULFWmLyu9ptc0uiogmrhOaQ35yYJywXBcqVJ/OP
jRMJr6kSbVzYs2ybNc8NYvTED+vsud/HM0GxMOS24gZipc5uA1aJnwKvS24POEns
nrqZ0XL7THMCJFOIO4gf12q0Nbz8Mv5MLvidAMulhuhCXWy+64NJWe0/F/mGuc9f
ohdyxY7Lhpufgbvmibax
=p9HA
-----END PGP SIGNATURE-----

--6h64vBu9tReNbGLX--

--===============5464578571094170201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5464578571094170201==--
