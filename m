From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] sound/sgtl5000: fix codec register
 initial values and mask
Date: Wed, 12 Jun 2013 17:08:05 +0100
Message-ID: <20130612160805.GL1403@sirena.org.uk>
References: <51B71608.3000302@freescale.com>
 <1370964151-6728-1-git-send-email-oskar@scara.com>
 <51B749F5.3010907@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0271897732298772451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DCF12610CA
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 18:08:19 +0200 (CEST)
In-Reply-To: <51B749F5.3010907@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Zeng Zhaoming <zengzm.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <oskar@scara.com>
List-Id: alsa-devel@alsa-project.org


--===============0271897732298772451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LIxvNfiQb+4m9exP"
Content-Disposition: inline


--LIxvNfiQb+4m9exP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 01:01:57PM -0300, Fabio Estevam wrote:
> On 06/11/2013 12:22 PM, Oskar Schirmer wrote:
> >According to documentation bit 3:2 in register SSS_CTRL are
> >reserved and zero, so initially setting the register to 0x0008
> >does not make much sense. Instead, bit 4 should be marked set,
> >as this is the power up default.
> >
> >Further, mask computation in declarative part is obviously wrong:
> >Fix FRAC DIVISOR to provide an 11 bit mask correctly.
> >
> >Signed-off-by: Oskar Schirmer <oskar@scara.com>
> >Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

> Looks good, but please copy Mark Brown. Just added him in Cc now.

Please also use subject lines matching the normal style for the
subsystem.  I can't apply this unless someone sends me a copy properly
(not quoted and so on).

--LIxvNfiQb+4m9exP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuJziAAoJELSic+t+oim9MrUP+QERA+7zk0FbFa95mKR7ucqB
4p5XUWKYDaCXhw2+ykqpd3dCSsSVZhbVvsC2Upx6uZAlPX79YaFP85eEf20Y1zk/
JAI8V82k2qBMzrMc9iYPKrkfN+MBmeADDy1/3d+BTfmB0t4ts/r3MFukQJ/w07oI
DQAClwRP01qn2xuicYOZTJYPaU3EZw7/gOMZiu/rT5UyFbnwlVsBtZOGZomfELXA
s6rCIMhypt/y98diYHR2gj3y4l3MnYrKojZV9xyr2PBuwlne75T0ujZbjgVIXI8p
4BAZPuWJH0qPQGS05mMUWvLOFah3qJr/wOuPrbR0ICNujJMhC4WLSGjy1r5u2VVz
tigMK6aJYLzTUyDPfHSPaprbsJ1DDdYVlG9pb6RkqKVCpFDUdDsuxhX2vuH9d/g1
E3R2p/ZAaowpPwaTkdiS1nugiwt2BdlYCz8PHJK7+/UjFDSeRNa/smaPmZRp7lMW
TvqPXGTNVhKSm7AcbIVrwvrh+by5y578hPkjWqR6IWbi2wt1bjflx1K/lfGrkVjv
y696R9Y4jOBhnK3bin9wKFBgH2i3zbQw3BKgnSTbQfITl7O1YfOlcXTx1tENVfLN
+E9kZnPmBNTlM36sHU6tGU6KSoUpqis/byE1za5erYXDDyJcZZX/RqCCz9yEzQYy
YEJZu0V96xjyQdCOPdeX
=qlZ2
-----END PGP SIGNATURE-----

--LIxvNfiQb+4m9exP--

--===============0271897732298772451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0271897732298772451==--
