From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] ASoC: pxa: magician: Convert to table
 based DAPM and control setup
Date: Mon, 3 Mar 2014 11:02:12 +0900
Message-ID: <20140303020212.GQ2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6504289150913069761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 97EBD2654D5
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 04:35:35 +0100 (CET)
In-Reply-To: <1393685300-5307-5-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6504289150913069761==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CVXKxAdNG2kQIXaJ"
Content-Disposition: inline


--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:17PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes. This
> on one hand makes the code a bit shorter and cleaner and on the other hand the
> board level DAPM elements get registered in the card's DAPM context rather than
> in the CODEC's DAPM context.

This doesn't apply, please check and resend.

--CVXKxAdNG2kQIXaJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+KgAAoJELSic+t+oim9vEcP/2BzqiIAdmu8pPAiKdwECCOp
KLmBZnhFPsBwbfnqXVPgGs6AXxc/g6Oj+BdkatzRKPe5LWQwg6T4HxiFpAqD3UPr
dOiL9muYUYzGWVIfFWcpdUnPEkOxCvCsntqMJ/4E2OKYzpwbwaVyR/S8u4fDMo4H
k0yYN3gbfKcAhUOFbAQb/JUCHwJ2VMTWOvvBi1+zM42MQMZnhMSZRfQm1hVT6TsI
6sPV6fhr+zqvLytuf4rTNa8TLCl5C1GsO8h+Ad7wXQk1jrwkv4F9jE4OQDiS0Fvz
KzD0I28dcn7tZuYUpDUq8mRw/ZVBWNO4VlcSySUzWr4uyVJ3slKKpIWG8bCsw+XE
9rAIrLeqLniiL7O1EGy/ZVIQvFbByx/oviROtxNip5khSmR0rOafXPb9/qob+TId
VxkhyVYwuqYAY305Or7cpEU9zZ7VwPUFxGzyhPzlSqKBDVR5te0zqRrPCk6LXxtj
HgmMrBZ4H1zznsblA1rTvBbBfzR3/eMFLEJe18wNuYwN+uBaeUduq8mtbjOxeIHj
RWpidLGMPvp5ieLTwcnIASOthEtaEFIXAwJeKw5+flIai4gAZYCyoDZOtpyaR4hl
nAovURNDZGDgCfyvk4dVhyghzdL8Ge5+3ubT3E5L28gTrHTgjj2c4KeeokuBg0B7
gledZ4Ka9PSdbbZeu+gw
=qL2q
-----END PGP SIGNATURE-----

--CVXKxAdNG2kQIXaJ--

--===============6504289150913069761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6504289150913069761==--
