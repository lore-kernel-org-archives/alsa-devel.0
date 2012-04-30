From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv312aic23: unbreak resume
Date: Mon, 30 Apr 2012 10:11:14 +0100
Message-ID: <20120430091114.GA3170@opensource.wolfsonmicro.com>
References: <1335713877-7921-1-git-send-email-eric@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8828748714909612330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3196B243E8
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 11:11:20 +0200 (CEST)
In-Reply-To: <1335713877-7921-1-git-send-email-eric@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, axel.lin@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============8828748714909612330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 29, 2012 at 05:37:57PM +0200, Eric B=E9nard wrote:
> * commit f9dfbf9 "ASoC: tlv320aic23: convert to soc-cache" leads to
> a bug preventing resumeof the codec as regmap expects a 9 bits data
> register but 0xFFFF is passed in tlv320aic23_set_bias_level and this
> values gets cached preventing any write to the TLV320AIC23_PWR
> register as the final value produced by regmap is (register << 9) |=A0val=
ue

Applied, thanks.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPnlcnAAoJEBus8iNuMP3dAn0P/jyWmICshV6v1+VHxdoPWUt0
Wk+tsu05ZQFwpwWZ8vBRaUuqN1zS2Gu5oySUEwmeOlEUtRke7wYMBI2kHtwwctAS
U2kCSOxDVXhFJrNNUrkFWeGxuPgkcwattqVY0jCFPCXIxrznHCehOh8r9fV3K0/X
FFVGdHehR0OXfZXsJUds0vBtBlcAqql00jxIjo8teo1Obe+IDW6C63uUtZ+KNxFH
G7Npm84FYpzzCbmJEBi7D79XzrHv+Ui1l0UdyyFjJJq7m4HedISofgU8dwNv9Og7
egWtVejx8q7M7Px0ENrP/DrJ6VMqLkBm5Mf2XGMetISx/B2V64pyncjjJJCzzbVe
rYaRi1/7rjRGOMegl//DJfLpR5Z418/BjCzUWu9oh7UkWonseRottacr5v8zS5MO
45abmLkeg4SWJ12Ke3rJMwLst2F9pZZEhkIvp9/0r3HCEybqz1Zootp4938kn/88
nR5IEYLrx/D+DWB4NaUfxsCsDlXn/few33uE4pgtNvD0L5yK/+gZzpFmz5oPTSXC
vL7OSoSKOlBJM6D0rVnwt9atZTOcmH6wJ3K88wxJFCYjSU6FZ4Of+bzFJJl7Bjbh
HWtH6S7mYSMDKER8Tu4wKAWZ7A6Na18Ug1sCrDrlDB6q6sFG/MHuhkkKm3AJxNa2
Yi6rnkmwSbjfVPGlNTSw
=rvyp
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============8828748714909612330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8828748714909612330==--
