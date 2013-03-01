From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: snd-core: tidyup
	snd_soc_register_codec() fail case
Date: Fri, 1 Mar 2013 18:59:06 +0800
Message-ID: <20130301105904.GW25302@opensource.wolfsonmicro.com>
References: <87d2vog522.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1701019596639648881=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4BB27265DF0
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2013 11:59:37 +0100 (CET)
In-Reply-To: <87d2vog522.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1701019596639648881==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mu6rDKe19l+MneQx"
Content-Disposition: inline


--mu6rDKe19l+MneQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 25, 2013 at 12:40:09AM -0800, Kuninori Morimoto wrote:
> kfree() on snd_soc_register_codec() was summarized to one place.

Applied, thanks.

--mu6rDKe19l+MneQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMIntAAoJELSic+t+oim9HwYP/jeVek8Zs3/WKb01tLETQqed
kr1D6P6y/jY3mvL+ONx6IqvNchGFiAXJBaEuTEgc08FOuS0/+6mEaOzDlsqsIQMC
aFADDIgTc5KyTCJ2NUISjVVvYWSic2G6AW88k+bRlvUhudTV1Fnus3/35YNWGdaq
IhMR1SJ/fOggesKUb4qPo4mQZdQ9RmEq9yaPI3FHxc441AbafrF790QMQBbOBfaz
O0RZIY2jnrSUTjZEhpbA8+N91YTII871rfu57a/W6dvudk0RiNmz0j88VLJLFDcx
9F9eteMVqrM6kJOkM5rD0Eu5LXpUcfeYBCjH1rPEVb0HH6A/hrWiuzVhBwCdQqOW
wG8c0Ptfor6Q1lu6TgtoI2TbcyjNuk4R+UU8UhfK5J5to9QaoZ99HJPT4JVQguLp
Hs/CvheF2Hs++djWx5FITDGokym9b8jEqz+rzsjhae/cq1MSE6mSf9JJH1HihrAy
CeJDXH4VS/OJGDNaOuLVarVO98CO6FDl/K7qBY+UtDYYSF5Ikz0s9AiC3xMssJzN
dSu7wuvftnz8h/T407RdZRSxjgZ5O9vWC0NgOE3RO3eVMxZXyTAq31Ramw1G/CcB
49hqJc2EnRr+xxP3Lw3upOgbKv9ZTDRnftxuyMMwj/ixONIf31ao2F8wJw4cJSqw
RFrMfK+XIZfjy+r0+OxJ
=Cc6Q
-----END PGP SIGNATURE-----

--mu6rDKe19l+MneQx--

--===============1701019596639648881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1701019596639648881==--
