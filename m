From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] sound: soc: fsl: Fix memory leak in imx-audmux.c
Date: Mon, 14 Oct 2013 13:27:49 +0100
Message-ID: <20131014122749.GT2443@sirena.org.uk>
References: <1381617306-18764-1-git-send-email-felipensp@gmail.com>
 <20131014115937.GR2443@sirena.org.uk>
 <CA+5g0SJGMy+XJw91uE6doidbjiPJrwXdgSkidZHCfP4L=Xx7dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hUen2UJD5eWDKlb+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+5g0SJGMy+XJw91uE6doidbjiPJrwXdgSkidZHCfP4L=Xx7dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Pena <felipensp@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Bill Pemberton <wfp5p@virginia.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--hUen2UJD5eWDKlb+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2013 at 09:05:44AM -0300, Felipe Pena wrote:

> About the CC list I just use the one that I get from scripts/get_maintainer.pl.

Yeah, that's the most common reason - get_maintianer tends to pick up
extra people.  You really need to look at the list of people it
generates and why they're there, if they're there due to git commits
they might just have been doing some generic work.

--hUen2UJD5eWDKlb+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSW+NCAAoJELSic+t+oim9L1UP/jcuKWRIdjedFeuRv5TI2clO
3/8skzqSD1AEJ4/nOdB3Xua1AJHADB+e4BWYqsaKmb5uzDfL38S4CnUQ9sM70XeI
O0K/0mH6Uivc/NZke/9IVfBIU59FuaCtwsWugltj0AYGCFYb/8ujC94bozWCgG8M
SOGnc3toDU8xvq88dDmja0Zhm1Our47vavmSix+at26agFAsbX/gCFS+ifhMmzR2
UEJmwnarJGt+x+pA63MspmQErWzZQkKS0VXB9zwB+lukevWPdCb8pM/jOnvaTuia
xtQkp3wX1Os1lieGcQLFUd5sUmzau2yIgwNaZH/s6nIJEv6y0y7uwRRyUJyhKSVT
4khEKne3ZRSeS8Y+7OHPGbbd+YbYU+uAoUuB8/G7Zfenvu1X77CP3wcTBV/fIDNx
XlVAxMZ10QYR6F/Vq5zx6CvzDTJ5DkcRVwjqtytiXMMVViokXg+Rbo460opn2GsD
hUwDmdguBv/Jatt4B+rtD1z4lUJT6X0DhnJX0aCPaubIFH6adirG/LoGN/qcrR+O
YFPwUngXWEioOg5CgsCKWMwexo3sSbJIQn30ol2/wwFtey2+r53e2034ecluTnzD
zAvHAEDrpWxM5qmk9tOEp2mxN6XIT4NPBrYKFlYf8NKznwzm8BTbN6kNSn/c4kWP
YfC1xAOUuaZvc0jAPCwN
=rGg7
-----END PGP SIGNATURE-----

--hUen2UJD5eWDKlb+--
