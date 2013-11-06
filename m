From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Wed, 6 Nov 2013 11:24:21 +0000
Message-ID: <20131106112421.GI11602@sirena.org.uk>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8525835727743186941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E61A2619DA
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 12:24:25 +0100 (CET)
In-Reply-To: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, trinity.qiao.zhou@gmail.com, chao.xie@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============8525835727743186941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x7gJcYyRf5ZnuMVj"
Content-Disposition: inline


--x7gJcYyRf5ZnuMVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2013 at 04:30:08PM +0800, Qiao Zhou wrote:
> add TISSP mode support. with this mode enabled, ssp controller
> works in TI-ssp protocol automatically and doesn't need to
> configure sspsp register to set the timing for tx/rx.

What is TISSP mode in an audio context?

> +	/*
> +	 * add TISSP protocol support. setting to this mode, ssp controller
> +	 * works in TI-ssp mode, and need not set psp register to conf
> +	 * detailed timing.
> +	 */
> +	case SND_SOC_DAIFMT_SSP:
> +		sscr0 |=3D SSCR0_TISSP;
> +		sscr1 |=3D SSCR1_RWOT;
> =20
>  	default:
>  		return -EINVAL;

I don't think this code has been tested...

--x7gJcYyRf5ZnuMVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSeibiAAoJELSic+t+oim95NUP/i7piUElCO6O59ipGndQtF0b
Vtjsvn7jpsZMvBmK0oOJMNJrIsYGEnhs4wYACGxFtX++ojyRevOHHYlWK2SZs9bC
E9Dp68tvNnDyyOXBhf00I0iM8gt7LB1sch9ns2yCfQw+w0uVH9RinzeoLF1Dkz8s
wkvpAu5fPsICPWjUOp8WWlosuqQU4xhfdzHfsbps0YtOwdqsE50Vu9YRzig6fkky
6qPCK948yeICf/WIVcnW9AVGt89ziUH54y3kLZCE2Yz52TDuk24oWkl9rAFEAlv3
e4H5Gi9adqXNGr3vlTe43Utf7tbMkbOtvpDmuR0tlNLZRnyDO+pgT77zKTSBJuau
+CV9wtMVzCOBa4iybzOzKo206wwGch+KXVS0nKR9mFHJKnNn7lg/Vkl+uraXMT2F
9n4yAfay5yWt5mhhgr7QGv4hoztydmQxKAy2Qcz/70er+ffYDtFoNUvRWv4qyAQQ
wqpYysFMIRt2mUDxKLn0Xl1eGIjcaKJ4bQrxky5k07HXVnnD/lYk+c/k36Nw6QDQ
YBilH3QRil2SoFNhnSiqxuKOVcIfWktg7HqzpmmoA08m9JOoSH2lIJHxyWRT3rUC
mbzoQRLmwoftYYBSH3jvyn9ZOZ5m5oIEM6zNE7yMcMkuQKplKTunAgmdZHfrcz84
CrIe8zqsdAiIQFQa7yzh
=bFU2
-----END PGP SIGNATURE-----

--x7gJcYyRf5ZnuMVj--

--===============8525835727743186941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8525835727743186941==--
