From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 06/10] ARM: soc-audio phycore-ac97: fix
	driver init order
Date: Mon, 11 Mar 2013 11:10:11 +0000
Message-ID: <20130311111011.GA10617@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-7-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3069874486960665535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8015F265290
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 12:10:13 +0100 (CET)
In-Reply-To: <1362940391-8338-7-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Timur Tabi <timur@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3069874486960665535==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 10, 2013 at 07:33:07PM +0100, Markus Pargmann wrote:
> Adding a soc-audio sound driver internally uses snd_soc_register_device,
> which tries to bind it with the codec. The adding of the driver is
> deferred because the codec driver is not loaded.

> This patch changes the order of registration. The codec driver is there
> before the ac97 driver, so the snd_soc_register_device call is
> successfull.

You shouldn't be using soc-audio in the first place...

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRPbtDAAoJELSic+t+oim9aK0P/1mBmdSE+K1b8zRPhhAgvBA2
fSlPcXyJsJTfFC3oDKCGCASOHQ0AnWloSOtf+D2RoTWXoW24ZAXJTPgqw8z5WOzF
0cVTVMhYB6KtE7wb82KBXZwhy6Ia6hV+zlVAzQshRYF9czV+JX3qMuKKTK5iErwK
9movDaKDoErqSOri4BXQlV46oq+PAXeOvays+WzodzDz5NoTLzJKcSq9SpLK6K4Q
wGMG4Y6jg6Ny7pbTvLiePkTCB9hflummkjbb/ZRphKV9pKJVWfswz2N+z5PgFjnb
LcycVzxNQZ4ITXiM4BQSXxN0DHdpDN1wuHKOLtUEAN/gFQhhGkGOxcNPYAlxU3mn
Rlesnt68Z/UkI+klP+EtgzHUxahzgqZtWh9yrVmWdW/mpeniuRn0pxQMGpJaNTPv
C1ImaRiNU3BVsGtFeYL8Y4y7XKjdTRjdBK6HYztI9TK6kfyyslCvpF/prw63XHfo
4kSPgdIaUVdPvsBgucXL3puw7YVxxOHxZFn9eE6B9H41/33AFwnJVfhbXJw3RD/Y
nQUWMfO3zdkTYjkX+YSa7nf1Z8MZelXjzfLzdxoUh6vu9bQtcGyfxHbbV95IwkDW
v3xso7vd/yYhBHRqdQlGfV1YB3yupxgZ1cFBd9rWvSC3Kh1JNqmvPt16laOfiJd8
AzSI1cBihc6RSap7P2wK
=XizF
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--

--===============3069874486960665535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3069874486960665535==--
