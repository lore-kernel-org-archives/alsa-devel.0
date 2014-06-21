From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4 v2] mfd: arizona: Export function to
 control subsystem DVFS
Date: Sat, 21 Jun 2014 21:45:49 +0100
Message-ID: <20140621204549.GA24291@sirena.org.uk>
References: <1403275273-22713-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1403275273-22713-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0020833045481665571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4F3E2619E5
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:46:11 +0200 (CEST)
In-Reply-To: <1403275273-22713-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============0020833045481665571==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2014 at 03:41:10PM +0100, Charles Keepax wrote:

> +	int ret = 0;

> +			ret = regulator_set_voltage(arizona->dcvdd,
> +						    1800000, 1800000);
> +			if (ret != 0) {
> +				dev_err(arizona->dev,
> +					"Failed to raise dcvdd (%u)\n", ret);
> +				goto err;
> +			}

I'm really nitpicking here but the error code is a signed integer being
printed for some reason with %u and while I'm at it DCVDD would normally
be written in all caps for human consumption.

> +int arizona_dvfs_down(struct arizona *arizona, unsigned int flags)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&arizona->subsys_max_lock);
> +
> +	arizona->subsys_max_rq &= ~flags;

Is it worth checking to see if the request was asserted and logging a
warning if it wasn't?  The lack of refcounting suggests that a bit of
defensiveness might be in order.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpe75AAoJELSic+t+oim9+4AP/3TdGUJfrvuVHgW/tSWRoIlp
GqcsMILAO8Be3DYI91SmV5yF7xN4pTec9NO3EpimcC87jWJZzJ1k3oVN9mcRzKxx
OXeVz0Ur/ChlJof6G4cf8+jHwgbH72lByQpleovPUrXUmEnvKZveJsSkVkDvkGbe
SV5AmONl5qcoMp4crpF2UKnp1FI8+VFk/+XycFlbpnUkazW5MjBQeHnR7sJ4nAhl
vzwRvuxGR35/BjRT9mSQomfuZFv+RZuFX3puWRxboWZcoUqKhzyBeiuh7aJoNCqB
TOnv1hDXSRQrIvReEhrSWK1RUqPHAvnkRI1LRaM8vhPbg+5Faevc4ZWMSaD79B1P
DhGkGBk/UlW/34k2boAaCqHrIn49lZdkNVQ84ZEai0MElhJ4izfKm39LVs80XA2c
PhhUBr3b/PHbcPTBHYXVKx8aK47dimg39LsWWdG0ox+DHDmlzZZYvOmV62R3M4vU
blODjcgUzfEfo66sETR+WgXkAFEY4DOVP70U8osuHDVN0u++tDR3n4n9a7VSZKI+
dJXzowF0vkhWzrU1BqiJjXzmrB4OA39rP1ZtNptw/hMNYxCkuUPFILr7zsyWvsSs
sy/UHvtbmmJLwe1cCWm/WtjHWog1mvEZlNaGUKfPVpDKwjpIncX/zQZMfA4BorZJ
Ndmwt3QEjaaaTSjX+xKr
=0wvA
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============0020833045481665571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0020833045481665571==--
