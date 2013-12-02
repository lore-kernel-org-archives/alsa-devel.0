From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: fix devres parameter in
 devm_snd_soc_register_card()
Date: Mon, 2 Dec 2013 11:51:07 +0000
Message-ID: <20131202115107.GU27568@sirena.org.uk>
References: <20131129140153.GA10843@S2101-09.ap.freescale.net>
 <1385962010-8951-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6280306684914245537=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E606261ABE
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:51:10 +0100 (CET)
In-Reply-To: <1385962010-8951-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============6280306684914245537==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JeoFlc3Bdq4ZaQzA"
Content-Disposition: inline


--JeoFlc3Bdq4ZaQzA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 01:26:50PM +0800, Shawn Guo wrote:
> Since devm_card_release() expects parameter 'res' to be a pointer to
> struct snd_soc_card, devm_snd_soc_register_card() should really pass
> such a pointer rather than the one to struct device.

Applied, thanks.

--JeoFlc3Bdq4ZaQzA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnHQoAAoJELSic+t+oim9RSoP/2e1+naLcfvLsESrWd8FiICX
smHhKkvAB36lhPPtFWSXyukiyhFJdENvv2gha0KPJoFq/ekHJmPfnGsCVU3e6GMV
aUUpvXnp+usf1pyjp/jni3sT8QESTvVDOrBMlxfDFDSLs7qGM8km5NkI/KM/I0ng
DgIOPjfwsHWZLssdlADZvt4Eq/6JxkMpdXNPZcVpTUE9JF+mztKopotF0BbM/AkA
eMk2LMHYlDAlsHdeEgVGMg4/Qd1mah4OEKbiuBGIORVmNMQc+gz9m56rkCKfgmxX
xvu+ZJmp35YvJKNKCBAiqoL3Pl+62IOMhOx5w/Ud0jiO5DZVoCFGPcrEYeVmVz85
OVeP1W9No2f75w2M8l790iFMsrcKz5b6m7d2BHcizwIE9BS1GphT9iLbFYOXM0GA
AKldWXuB6kgmVy3D1ujB5Rj3Hq6ihy86tni0t8Fq4jyQNKfvlvl3+L3/94RzbXo5
isyslaa4oorAfxIdyg/quIZRdvYeSyk880H/ukHM3N5liToSTCAVEJlJkF2siT3u
th56Cto1EZvadAxU7GypZAc+mHCvnppzjQT+PdthRz2WgAQR6z5LKkyw6TqK+k2Z
N6Ol1G0k1y3ZQV6VBD/t/rqYnSKraohV4VRAPC8Cr7+YCSAgL0Hb1TbeV/hgxW7o
zgiacs4uTEV+vCZVumwR
=/JG/
-----END PGP SIGNATURE-----

--JeoFlc3Bdq4ZaQzA--

--===============6280306684914245537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6280306684914245537==--
