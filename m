From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/15] ASoC: wm5100: Update locking around use of DAPM
 pin API
Date: Tue, 18 Feb 2014 09:47:29 +0900
Message-ID: <20140218004729.GK2669@sirena.org.uk>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392655903-24537-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwbb4r/vLufKlfJs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392655903-24537-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--rwbb4r/vLufKlfJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2014 at 04:51:32PM +0000, Charles Keepax wrote:

> +		snd_soc_dapm_force_enable_pin_locked(&codec->dapm, "CP2");
> +		snd_soc_dapm_force_enable_pin_locked(&codec->dapm, "SYSCLK");
> +
> +		mutex_unlock(&codec->dapm.card->dapm_mutex);
> +
>  		snd_soc_dapm_sync(&codec->dapm);

With all these patches it seems weird that we have to drop the lock to
do the sync which will immediately retake it.  It's not broken but it
looks off - it would be better to have a version of _sync() that we can
call within the lock.

Regarding the naming issue that Lars mentioned I think the current
operations are probably fine but calling them _unlocked() meaning they
don't do any locking (as distinct from the existing _locked() which take
locks) might be OK.

--rwbb4r/vLufKlfJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTAq2eAAoJELSic+t+oim9HiQP/2sz66TMg6Ccj16U26xSuj9k
AUvoqERSgUkYX1MNjja4GEJQd3J5ZW+HUZ4bDbDzgksX3SEqHtrDAbGYAE/7s5Os
gfTG2Rkp4iDwHevcLUsbdLvoOdCRzakSqnU15I8kzg1+0UpK7EfLP7RgXtUELl5O
LkXD7aJD+DhrYsflJYd/L6DWwltgJRUpN8k8W28eN9vcx3RHPUY5pTLhrQNGgzwJ
HFV14sAfhdBRHoRa6ZDy/j2AOkbz/Ni9vMWH4kd5N0iBtjhcgniibjm7mRu2yxZq
LeNEz8wh3qPGI2Dh8QmIdqeYA3ZkNDieO6yJw3u63kJ0HO6Oz6gm7iB07xuJ4Snf
PHcGW5Tx0yjT0RgZ8rqVs+muJW3Eq1FQxNgzW7PvwBkJ27I4Wgu0mjSA7qBxO7PY
0UoJMijOdDAUZeWChuw91lcWXPvgcnt/9ETG484YbH8fqJs5/4pITyt6ubhZxQpt
O7k9kRZZEEp90zj6dBnBb5OfF4yDkV0KfKTm5vCR1v567nq/kxzUQqhhSb01wwjH
RFEDDtPYd3I2sNulG3CgXt9S4+ydjX+JmqcvIXuWJ8c69idS8Jry6aNA3du7IhPJ
LuumBKIQWrTg6FfGXg2EuiKhn8i8OIbE2awlRaQl3iFXwbK4FDahwW2ViSLOaf7a
Qz40S43vBBjnjPkyknaZ
=o9sN
-----END PGP SIGNATURE-----

--rwbb4r/vLufKlfJs--
