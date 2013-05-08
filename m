From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: ux500: Update tx tdm slots
	configuration
Date: Wed, 8 May 2013 13:28:54 +0100
Message-ID: <20130508122854.GI7478@sirena.org.uk>
References: <1367997261-32048-1-git-send-email-fabio.baltieri@linaro.org>
 <1367997261-32048-5-git-send-email-fabio.baltieri@linaro.org>
 <20130508110149.GF7478@sirena.org.uk>
 <20130508111110.GD3459@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6543593675295449969=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6237626109F
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 14:29:07 +0200 (CEST)
In-Reply-To: <20130508111110.GD3459@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Fabio Baltieri <fabio.baltieri@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6543593675295449969==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCBbHYs95wY/7dOt"
Content-Disposition: inline


--KCBbHYs95wY/7dOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2013 at 12:11:10PM +0100, Lee Jones wrote:
> On Wed, 08 May 2013, Mark Brown wrote:

> > On Wed, May 08, 2013 at 09:14:19AM +0200, Fabio Baltieri wrote:
> > > Update ab8500-codec and mop500_ab8500 tx slot configuration to reflect
> > > the actual one used by STE.  Also update a wrong comment in the process.

> > This seems wrong, the individual chip drivers should just be doing
> > whatever they're being told by the machine driver.  Sounds like there's
> > two fixes needed here - one is to change the TDM API so that the chip
> > drivers are just implementing configuration supplied by the machine
> > driver and the other is to change the configuration being done to
> > whatever is desired.

> Do you mean that the original implementation is incorrect, or that
> this patch is doing the wrong thing? I think this patch is a bugfix
> rather than a opportunity to refactor the driver.

I mean that the original implementation is incorrect and this is just
continuing the problem - the reason that we don't want to have this
stuff hard coded in the device drivers is that we should be doing this
sort of configuration in the machine drivers so only the relevant
systems are affected by configuration updates.  Putting this in the
drivers tends to lead to a series of configuration changes like this.

--KCBbHYs95wY/7dOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRikUDAAoJELSic+t+oim95FoP/jV2Uye2IXWcPyVxswowul26
66agqrFgjMpIewaIZiwwMQB4zNSs/g17WUrIBYoUSF25lPePoisJ2FWYoqyssA8Q
T4g5agv8VcBAb3vHXF81TiuPr5ixn0t2hf4Heeo9xpZjAUItrE+6VNX4itzZcNkQ
CoDszaM1u1MXH88Wqx6E5rqdYfOH0dHwb1tryIPrhvqPNLJCFSEGjRGoprGi4u3+
Vyt4p0mxfBU8iXtWoDbkO5kKuOY0yH5Z7QjI0bq9DTl0pFZ6bbU9om6uXncBROZw
mBlybUyd9sJUd6mrofoQa99YkpZS1rxUp89f8UUhVhq+k1fmr2pJCAMYpZlrpQ1Y
tbaOQcgNHypo6tv1zIbmRSknsMDQ+ckU/9LCXC5yxndMVvjDrV5aoGt2kRp5AkCc
22N/WlthZ2Ls2EbZJ39i1p+FeufcAHGXzjOYtSW6FoHNnKlCBx8XaeeqA3Lvep9h
d8VfuToltl9QeLo+W3fC90+0P8wYjF7AJcxQXQa6UcC+yZWzDQPOeLgi+I9+wcGM
qgz7yvqC2VI0TF+9w6w052gScqbQaDPnTO8zhwIiGaoIF41ZMc+t9vx0UMbrWFTQ
yJckS5roV6bqiXZyaIOxwVe2u3DMKco3CTMHQVwdYFEGh0L7WftFW+2XTRwgfIlj
rr/5DceMMf8YUR8z/S4g
=F7As
-----END PGP SIGNATURE-----

--KCBbHYs95wY/7dOt--

--===============6543593675295449969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6543593675295449969==--
