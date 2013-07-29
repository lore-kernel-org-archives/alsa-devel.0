From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: core: Add
	snd_soc_card_get_kcontrol()
Date: Mon, 29 Jul 2013 15:40:10 +0100
Message-ID: <20130729144010.GY9858@sirena.org.uk>
References: <1375102319-10645-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7869573237218460780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 90CB5261AE7
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 16:40:12 +0200 (CEST)
In-Reply-To: <1375102319-10645-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7869573237218460780==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U/CusvTiRNwX8wvP"
Content-Disposition: inline


--U/CusvTiRNwX8wvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2013 at 01:51:58PM +0100, Dimitris Papastamos wrote:
> This is useful for drivers who want to grab a pointer to
> snd_kcontrol outside of the kcontrol callbacks.

Applied both, thanks.

--U/CusvTiRNwX8wvP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9n7HAAoJELSic+t+oim9eRcP/RgyV7NumEtpWpmxR+ONtpvm
kSe6k1bua64IYcsv17nOO7sBmelfq8h8/oTmnYm4+hbwGHv5Z5gYO855B+M/UjZL
dltpn/EoYKYGFZFRlmUJWEwXayR2mwUxzSkMrv1wfIAp0nx8lMmxSsMh24NYi6MN
O9IMjg8zxbwEeEMUmpqZfXlJWIS+bxasZZ7j+lZ9Dw1+DQbDX+OPqj0FKkq45q7d
aMkkgiGHbKztAAB3HvheHyR82deYriRiovQ+HH5mNpd0DFehW7IXCu4XcQRRMnkT
Yukf54kTAZzfPYnROtNv93X5Mp0Z6KLGoCUQ29c+VGSK7UUnIRDhv49p/RU88TbG
o4g1qMv5kFRXTzdvNyxF5YkJAXFNeoM+pJmtn9bhPg8lL8SihoQ3XBzR6wsUm0Ex
OVufPZmraWo673oF2OCiQwBR/FlHTDi9gHryEDYCqETNWkjdDsQpmtU2mx1k4PM7
OZl3C8NsnIfIKzxGf50x9kuFElmm32eZOGkebaPl1D+1TI/jrHllcaE/p2d8BokR
mCC0ySEkaVCyfW+TPyOczp6mu6lz2XO+ik8NQT1CfRqxztcogTFnv9/mmp1XVtk1
hV3yfgMOgqN9Oe4/RlmVnPrb6ayc3bh5McMsyp6n68RlqB8mUyIoXosaoX5yrpnE
NRhdzhq+kBuv6JrsCRyr
=zOZW
-----END PGP SIGNATURE-----

--U/CusvTiRNwX8wvP--

--===============7869573237218460780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7869573237218460780==--
