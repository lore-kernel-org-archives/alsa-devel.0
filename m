From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/17 v2] ASoC: dapm: Add locking to
 snd_soc_dapm_xxxx_pin functions
Date: Thu, 20 Feb 2014 18:40:38 +0900
Message-ID: <20140220094038.GC2669@sirena.org.uk>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1392736948-26623-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5077718182013367605=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEA99261A6C
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 11:06:02 +0100 (CET)
In-Reply-To: <1392736948-26623-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org


--===============5077718182013367605==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/LzB6MLpuRxEY5S"
Content-Disposition: inline


--K/LzB6MLpuRxEY5S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 03:22:14PM +0000, Charles Keepax wrote:
> The snd_soc_dapm_xxxx_pin all require the dapm_mutex to be held when
> they are called as they edit the dirty list, however very few of the
> callers do so.

Applied, thanks.

--K/LzB6MLpuRxEY5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBc2SAAoJELSic+t+oim9CeIP/1GYQUTE7lufeZxzveEPiAGH
H6tsYp1T+PHXYb2mvB43xKLvvIOwLForMEHLulloWUjIKiGkTC8xo39kfpz5pfam
ap9vTHYSwXaBjSXYVPiXZPG63/FSFc1s2eB+ed+g9uw7886jzC/ItX4zdUR0816B
9Gz7ZVfo+NbqmQbsTen0z8LOMXnL0t24PIFGbbczugbYpGP+w6lso53xafmrrIi9
sNyw1dxCsSwaGhsAgiQ5S1ON2xBsYDQd4ww33EfOSNl1WFpqDTiH/ba9neu+S07D
kfIxJlr6a24VNIbF9iuH2E3oPnS0OFralmtfoe0StrQMDH0cyxcJJ9AQj3Z+yj3S
Vms8YdAT0/8b8W1EIlPfUGO6dnRDUho9i+y/sp/8+kA+aMk8k0bR37UEyd+QoYBk
K0z93sJTQjZO94b80fV9oq6k+EroS/OxcnqFZUb+owAam9A92eT2KVljcZCVONOv
aKIZX4nZ6/plOvlK8os7N9sL9zGETI9wfqrexQFyOSsVi3hvbGyvzdQ2Tg5TQBLp
WMjrUl6tFhmDfB5DMzGeRfnBRo6OEd5cPxqooHi2zrGDTLiCFj8tiIXAwb80CU0l
Co6Qdq6deLXHTYaFAK+RnPkeKdHjywvUdDlbTdwIlhu74dk0Ka5Y0AOS6oEJsRNY
ymTF4hxIxPoti+oDZcQb
=5/sj
-----END PGP SIGNATURE-----

--K/LzB6MLpuRxEY5S--

--===============5077718182013367605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5077718182013367605==--
