From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: arizona: Check clocking during
 hw_params rather than startup
Date: Fri, 24 Jan 2014 17:37:54 +0000
Message-ID: <20140124173754.GD11727@sirena.org.uk>
References: <1390582753-1026-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <52E2A1F2.6070707@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7165723655562260652=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF471265467
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 18:38:04 +0100 (CET)
In-Reply-To: <52E2A1F2.6070707@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7165723655562260652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bnBIwIKtMHAVL+3z"
Content-Disposition: inline


--bnBIwIKtMHAVL+3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 06:25:06PM +0100, Lars-Peter Clausen wrote:

> The problem with this approach is that if the sysclk is fixed instead to
> e.g. falling back to rate conversion you'll get an error instead when
> calling hw_params. The typical idiom here is to only apply the rate
> constraints in the CODEC driver if the sysclk is non zero. This driver
> already seems to do this. The problem that you probably see is that if the
> machine driver changes the sysclk value in hw_params the constraints that

Thanks, that's about what I was going to write.  The current theory is
that setting the sysclk to zero is the equivalent of a dynamic SYSCLK
flag - with the extensive use of charge pumps and so on in modern
devices on the fly reclocking is normally difficult to do safely so the
idea is that if the machine driver is in a position to reclock it should
set the clock to zero.

> are setup are still setup with the previous sysclk in mind. I think instead
> of removing the constraints support altogether from the driver a better
> solution is to introduce a dynamic_sysclk or similar attribute to the DAI
> link and not constrain the supported rates if this attribute is set to true.

It would be useful to have this more in the core rather than open coded,
as with the sample size stuff.

--bnBIwIKtMHAVL+3z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4qTvAAoJELSic+t+oim9OtkP+gK3imP7/8LDR9YSqF/9MT2K
SWRRKSkEI9UZrLolTCbVIDrUwBxt9rcQ+hnrkTU6WGUYvsfi0OsEB18z6uVlq0vi
hpWavkjZ+vKP0fuOfC7a/xi7DjtBbUHPzcXj3eKJXVDmquqrNZqu9s9s1W64f/6E
JMEkytF4eYYi6GjfY7ijvkWcusGU3C11lSePrNZaaejg7ooeKEBE19kh/1wt+nnR
BiugcqYcIY840g+WRK2zevw/xaswI8gF2OYWXrmwMCE9SNDQiIeBIeZyug1wrOsq
vueXZmALz5xMhkZ/JYn8MQUHTsrm7LOYpDe8oxqZ+FIZGjp34Wu7InYzryssif9L
DPnhQgpR/+AYdINO5N9Co8+hnkWPTZr1O8viP0vhv3m9NOA08A07WCfYC7iDM4C7
sCW4sz3Ut0IxIIF33nfC3BesTiW1HCdKCEmxdKZxU/04rqA2cR9zbT/SImpmvSq6
CsaQFLaJsj/vz2I8/9x9mk/VYY03Yhfh6xPpyKh8dlI88KHZ12hYMfUO7cpsIl42
sE/XhPaqS1I0aoGt7zlwYnZDAD5oA/EsVyYWC1VAUcMf05bP7ah01NoUxRh2Jn2p
XHiOPUDvwHcGym7UnZqGU2CPfxvf+ZfyCaYVsXdELsXKDqC38p6gQwQX6PTDkBJm
QCkL3uXTxCxutypsvFZp
=OT0v
-----END PGP SIGNATURE-----

--bnBIwIKtMHAVL+3z--

--===============7165723655562260652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7165723655562260652==--
