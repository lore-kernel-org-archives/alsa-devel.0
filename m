From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] sound/soc/lapis: add platform driver
 for ML7213
Date: Wed, 13 Jun 2012 13:11:40 +0100
Message-ID: <20120613121140.GL4545@opensource.wolfsonmicro.com>
References: <20120527221956.GB25019@opensource.wolfsonmicro.com>
	<CANKRQnhwkhGUHi6WQhw-sRJuKari3SLcipCJXVp27OZ29=Vxkw@mail.gmail.com>
	<20120530121449.GI9947@opensource.wolfsonmicro.com>
	<CANKRQni4uqQJ99ycOScHmn-g1kz2_XH7ePL+n1taG5jAbDSubw@mail.gmail.com>
	<20120531104538.GA2666@opensource.wolfsonmicro.com>
	<CANKRQnjdiV+e=N+n_ZP04jmCAhxKjgZ+wab+anbgO+VJPNo=PQ@mail.gmail.com>
	<20120601083018.GH24139@opensource.wolfsonmicro.com>
	<CANKRQnjeYtBucmGoDUg7oTK82rvnkakWRB0Siezyz-kbhyPC+g@mail.gmail.com>
	<20120611085404.GB11439@opensource.wolfsonmicro.com>
	<CANKRQngP3e3U+VZDgA7fQfxBti9vri-AEAR8iTmhLYiqXP_kiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2091052176854401854=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7E4D6104517
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 14:11:42 +0200 (CEST)
In-Reply-To: <CANKRQngP3e3U+VZDgA7fQfxBti9vri-AEAR8iTmhLYiqXP_kiw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2091052176854401854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2012 at 07:41:57PM +0900, Tomoya MORINAGA wrote:
> On Mon, Jun 11, 2012 at 5:54 PM, Mark Brown

> > There are some drivers that predate the availibility of the dmaengine
> > framework.

> In case, you develop a new ASoC framework,  all previous ASoC drivers
> should be adopted to the framework by yourself, don't you ?
> Because a new developer must be confused by this.

This is exactly what Lars-Peter did, he updated all the drivers that
used cyclic mode to use the framework.  Drivers using non-cyclic mode
weren't updated as there is some additional work needed in the
framework.

That said, you don't always want to do this - depending on the change
involved it's sometimes simpler and easier to move things over piecemeal
unless there's an actual issue being created by the lack of the new
firmware.

--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2IN1AAoJEBus8iNuMP3dpW0P/2FLeH2rXM/kE5wWCqg7cnjv
fNuZ1C9c6cgSkdJZaod12mdXt/yzZLr1udUKnI1hURGavb8pIQRMZGqD9t3CJEyN
Smc75DWaBu33bYdyW3PMhZRtHatW7RyhjtJx0NCfPw/fESR8BnfttwEIDefUCr/U
+Hgav+Zn4ZxdbkAx/5zEkLnqoNc4XRhkSEq4uLrZHYnWGxHM1dEOFSrjKf3KjWNb
B57jKp7tP58lWF3o7gkHlwBl4+Nfcmqa5ziF95iGxWibzvzZQOr4SIpuhMFK25mQ
rj0xfDQMBTjMCriD8TCatgV/5sFYBHzoGK0JpJwpatl/HyjSXJ90ahiH5gCu/VNT
5acsGxGoSI+FdlCRBCzP/UTMMWDM5GHaDhXb/8o/xbRXhicw7aa4QDdi5H+2S2ax
fdAqbyjWPXP9/k2zsF+Uqrod3RpgIHYuCW5O7TaCBevk5Vz9c8AQKFnvrQV6REk7
iEamBUAwfW6TNyGQ+XEkOPTR+gHM3T9KIrY9OAYyEEE+f8DL5x54ZcKR7IoTaBwI
efZQfRZDqITicOZKddj7r/nd3G0ROEWKAtyfl120SvEh2aLoBnG1imiluLoozhVY
y73E2DUcDB2ZiI0/xHagwBxsPI6xl05AP3jcV8EB9yOTzM5sXKwf8iEkxSGBE5eR
QV4htJ6k51wTWvyRYY9R
=/BpO
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--

--===============2091052176854401854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2091052176854401854==--
