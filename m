From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch 1/2] ASoC: sst-haswell-ipc: restore IRQs on error
Date: Wed, 26 Feb 2014 08:46:19 +0900
Message-ID: <20140225234619.GB2927@sirena.org.uk>
References: <20140225083250.GA22416@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140225083250.GA22416@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 11:32:50AM +0300, Dan Carpenter wrote:
> This should be spin_unlock_irqrestore() instead of spin_unlock()

Applied both, thanks.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDStHAAoJELSic+t+oim9BHEQAIsC5fPFcvxcAz0GxxD8v++l
zMtmpyAZ6MBq8M0Fz/vGl6VKOmO46adNGz5bmebiILrKwYn7ITiOgbz78jY1K9hj
M+gme2foQNZjagFV+AEmzQ3OzEEyjtZCR+FtPU9Cqe5yZgLqNeLVaW+Z51NlAwsm
pj31IkoobCcbdtWr3DYKPw+GCqz6nAUklcnKdG0/dSjpITrhv6dOwOixV6qpSfIM
P4S9vCYvSpsWFispDOkE2243bsG3bRuFIGX5KzC+6zFUnCYrhTRJtokOmF+hBxpA
gLAb18nzJpW7JZIWdakDoQpxbIbD6GpQnC5shhmm2Sru0rybrXkJ/8JJhX7gkITO
bCS1bc6J7DmyitUWpQ3TBOu9otl8X4GdPVZSeIJchQ5WaYZbNzn9HUw5+D7NmODT
mY8EPSG+hJikZH6JFFOY3Zz2pJPHhbqNKNSB9MQt4vHThKn0/sbrzncj/JCwq7ed
MPfpu0ahgl2f4TFM3wGh/Kv1cq3rWEbm57T4///2f+J4cjHLfskPk/bUBfhOWt8k
KdoXDTOkYBBWddEU4hunmYY8lFeZwJo01Kq/9Ko74giB3RH8Zygjd8k5a+IIsOjj
o1QcBxtJQV/FatalHeNaPbKtDGeitBtN5yXbupqwZHnZmqwbZ9bzLWycf2XA+seM
VxMfUClM9gNhuJk9I9+g
=HdAe
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
