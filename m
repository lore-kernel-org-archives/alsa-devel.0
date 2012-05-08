From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 09/11] ASoC: Ux500: Add platform-driver
Date: Tue, 8 May 2012 18:51:57 +0100
Message-ID: <20120508175156.GI15893@opensource.wolfsonmicro.com>
References: <1336485444-27369-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1107935806519214491=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C85C24150
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 19:51:59 +0200 (CEST)
In-Reply-To: <1336485444-27369-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1107935806519214491==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="95nVhCDQCgPWiQqT"
Content-Disposition: inline


--95nVhCDQCgPWiQqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:57:24PM +0200, Ola Lilja wrote:

> +int ux500_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_pcm *pcm = rtd->pcm;
> +
> +	dev_dbg(rtd->platform->dev, "%s: Enter.\n", __func__);
> +
> +	pcm->info_flags = 0;
> +	strcpy(pcm->name, "UX500_PCM");

Hrm, this looks like the framework is missing something - you should
just be able to just configure this in your driver and have things
copied in for you.

--95nVhCDQCgPWiQqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqV02AAoJEBus8iNuMP3d3t0P/2lzqkyQxhxEey7oRN0SpR2Q
0X8MmU89TwVysXK3BoBZoxZFOjagVURFmzls3eFJxsemuMjGKLclpqSoj5JcK3gH
6CXf1/bxMx6ljk4FN1mp6PIIYlNhqSFnbgP6QCBN2Xh5pjQB5bXsEA+4O8ZTuf8T
oYp/Np9arX+EWWqaNfEB3u0oVJf20bSIaxsCkU92SakQUq6hjpBwBRROZZL23iX7
xuAluObdAvIzqzzCWVHXVMqvALB6WqMhMhQ4r5iI1kyZDdzQ6+dcUEUVyG63/N6/
y37LwbO6I6TytYWtgP5XXIsFOF4PNpjEpUMJaAkyxYXBsPbWnA3JfPcLq2i4nCsj
9Q2KzDl/9yo7tqx8H2HIh508LSqAXziMSIUaDqAaWxYrZXfbl0IJQ+7yCb/fCR6m
clUV6q5x9kB7fz+gpGKZEhtiC5TJcH3zG+ueqmFv6emDKH5y+mA5gi8jgqyb8ctu
nrTCRRScL8i5kHPfMXUHw8Tyw7JYRLHjzSd95HULxPmgrYvVhmJuZEJ4DKxfylwZ
pVgbmqBzFU5uj19GSk0/vUFnYtxBQ4G0hbAhZiGZyKzXuf1qhXac32PLvOtS6pqI
J/PkshwHdSTGFASeDQVsSQuWkWxcTq4TZF9dGcSBUPDg7xc1PS30I3Gu93xuwJjh
jZAr3P5+y4fy6fmTK99f
=Baa8
-----END PGP SIGNATURE-----

--95nVhCDQCgPWiQqT--

--===============1107935806519214491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1107935806519214491==--
