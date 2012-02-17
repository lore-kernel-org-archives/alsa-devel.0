From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Usage of jack_status_check in ASoC GPIO
Date: Thu, 16 Feb 2012 23:07:50 -0800
Message-ID: <20120217070749.GA11464@opensource.wolfsonmicro.com>
References: <4F3DF909.8020602@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5569054999008170242=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 269CC2450D
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 08:07:54 +0100 (CET)
In-Reply-To: <4F3DF909.8020602@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Cc: alsa-devel@alsa-project.org, jy0922.shim@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============5569054999008170242==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2012 at 12:21:53PM +0530, Omair Mohammed Abdullah wrote:
> If I need to call a codec driver function whenever Headset status
> changes (to set various registers, turn off micbias etc.). In such a
> case, can the jack_status_check callback in snd_soc_jack_gpio
> structure be used? If I use it, I would need to modify the callback
> to pass certain parameters (codec pointer, status). Is this the
> intended use of the callback?

I rather suspect you shouldn't be doing that and should be doing
something else instead (probably using the notifiers) but without seeing
what you're trying to accomplish it's hard to comment in detail.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPfy+AAoJEBus8iNuMP3dEMsP/A8DeaqDKOp6uNYDWtg7bACQ
vXNsXOsLNzZtXNhVce75wt0xhLfchFmIp8PBAcEcYTEdzWpagPczrxn2kGJN6QkB
Dz5JbM+nhh5VHIZfr2pN0wFebjoE3Ce0VNRrEZcHPVNLJB6NKY/BjgSndb7i4saY
rC2aIEF4oZrqJlmSzg3h2PXCVLVQSxISXVK/j/Nc/iH6UeYzOravMnNAyP69w6pV
BqTVxSo3hiQS6i3+mOenyvgukVZgJsA4jxaLf1wP628BM0pZLoD06UEHfPjHbXUH
4QO3SBeuzqhVmH7DkevU54e5hyl0ATtMt4Bn7boiUNd1g4acleMTXkOrGJKDmTAJ
LGegwOOZo5jjYrB4Vfn0+NpUN7hI4dyDqlnopV2kxW9yGfkzdHDc0aGMDeQpMlGO
znPipq7YqPPGPh0XOFzAkfr0iy2bJtAsKz53DhK7RTts3hy+3SfLXOoYMoh8TBBN
8n6jIpzlrvKFzWiVU4APm4vEChEbznQMOJuihoRg/Iyyry/qms8iWGrFyKQ6YGPa
jH7JfaOof7IKMyW2BZDS5e9xp1/nPKggIRjDvUwomi72jeL2kaTe9u6zGGXz/B9+
rhbqV+PWgj/7uTv+9GrX4i3nDEy1QX8EHJpIdaEuoOjUIVUn6VnP3ToRlte1wN8p
ytU5CE+TkDlWR6eA5e02
=2Pzq
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

--===============5569054999008170242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5569054999008170242==--
