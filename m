From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix mono
Date: Sun, 27 Jan 2013 10:58:47 +0800
Message-ID: <20130127025844.GC4650@opensource.wolfsonmicro.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
 <20130126085512.GC30594@opensource.wolfsonmicro.com>
 <1343658253.242147.1359209821129.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3667029944539542381=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2EEB4260314
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2013 03:59:04 +0100 (CET)
In-Reply-To: <1343658253.242147.1359209821129.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3667029944539542381==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2013 at 03:17:01PM +0100, Beno=EEt Th=E9baudeau wrote:
> On Saturday, January 26, 2013 9:55:14 AM, Mark Brown wrote:

> > So, this doesn't actually fix mono - it removes support for it.

> Yes, for this driver, but this fixes mono for the whole system, meaning t=
hat
> e.g. it fixes mono playback support with players like MPlayer. I will rew=
ord if
> you prefer.

Yes, please.

> I've only tested with I=B2S (imx-ssi). But for all the available DAI mode=
s, the
> data sheet gives the encoding for both stereo channels (from p. 21), and =
nowhere
> it says that mono is an option for DAI:

I2S isn't really relevant here, it's not possible to clock I2S as a mono
interface.

> I will retest with DSP modes if you prefer.

Yes, please.

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBJfRAAoJELSic+t+oim9i+IP/jGUMGmL75UtbrBiyMXSIZIm
cj+k/K4Ws/lYN52DWzhZAZ0dAA3j2B2ueKxBmGk6JnE6icBHMJfu6ExIUFy0zkPC
3Bs6k+MUlG5xyESbgwR64xtXVFoPU0/4Wqk9yk5bl/73IUR2V+mP+2sGBf0s3Gku
bkQibcttTmeTbYFpLRZOx2b6UHAwJnMSgEJYPrRI2o+n1nfnKn8M1kRglS3KN/VO
DdZ8GGfc3XzkgJ3PSxN9v7FS0ibRW/px95rvZv8EtY7hoXHNMAwcoS61Q+IdiuJI
mmySjUIUmkc7+8++2VzyrF7/9pSsph8f8UIgfcDL5VzUt3sHhR8ohfmtSJTxRlnm
UIYeI8jg42Vv327MGbOrepOUEsLOQTbquq6EXl7p9uxCacCiB209k6ZMx4R4Zt6T
gfQKHR8FG0ATlNS44r0usbYH3KSbk3KsBqGHgtWGc1u18+yi3+fshzwM9NWgXSF+
/611xoB10e2X2ZHvV7EaQL2dGfv5wbpqH4vmMfXhRYQFnVewEIfZxBn4UD6ja1hS
N65ROxQMabe2K6VStLmImgjxy79WjvVb4LV9FkWJJrxIWKWKcxXVw8zHIMPsC3SF
dKB1PVj5Z7wr/JZWYXaJx4AuTvv0OGyHZds8s6uhrNHKSkHn5YU9gWta3nUyUa7W
W0REPgPxukZJelp4qWM7
=o2p+
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

--===============3667029944539542381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3667029944539542381==--
