From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 05/12] ASoC: alc5632: Remove unexisting
 route from Phone Mix to Mono Mix
Date: Sat, 11 Feb 2012 23:02:24 +0000
Message-ID: <20120211230223.GF3745@opensource.wolfsonmicro.com>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
	<1328995598-8788-6-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7025374932387537059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 158FC103AC7
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 00:02:26 +0100 (CET)
In-Reply-To: <1328995598-8788-6-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============7025374932387537059==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O98KdSgI27dgYlM5"
Content-Disposition: inline


--O98KdSgI27dgYlM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 11, 2012 at 11:26:31PM +0200, Leon Romanovsky wrote:
> From: Andrey Danin <danindrey@mail.ru>
>=20
> There is no Phone Mix<->Mono Mix route in datasheet.

I'll apply anyway as looking at the subsequent patches it appears that
the changelog is just misleading here and actually a path does exist,
it's just not the one currently routed out.  In general quite a few of
the patches here are confusingly changelogged like this.

I've applied all the rest too.

--O98KdSgI27dgYlM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNvN5AAoJEBus8iNuMP3dK/YP/37Xfaij/ehomNLorhlGAQHu
eVxy5BDCt86VlmnQtQT8e8948gr1YJAj8B66heUk+AyC8G6paAt3H8aff074aKgb
Kquha3Ik+dI7oH7AczpXRPE5obMNah2oIr+bMUF047np1O+ryopXJbHyljKXmmam
+j0xWcR+K+yGImLL/QB9F/NBofdNInRQoNkhAymg+YauKrxqMFqaA1fbSN9i40oI
qTG3U0cDAceqp/g9KtJjnIC0OfF4bfvHdK4gVIe8KA4t3TEJQbmITvoP+O7vzLfn
2+hUkhF4uhcVyb6XnO8u9BEVZhmbYHe/NUyKhoR3vv9NcBh6ae4okKKPV6u1HdHw
GNbi/n8nQ7isfgvkqkqrAOkPoCPJIf+BI6NAWYkGvyuuDuW+iF9rqDbiqpYv4noA
lhkxgGjCIqNuBEiDf4U4i/u53KDrSXVP4WkEPFmrBQNAp/pieoYkG66qbSug/Goo
QIyHA5/XyAYg8i6cdjFIfpQKC40LdWvWhS1bTClHXNnu/+2j1qbgnNqxJS3dwvxX
2MvDmDDf+xZmt4lDJk5ubnL7Z0G56/bTzVN76PzSgV3U+fizU92Z2miUq4vwJQpa
O5t06Efuhx2VkzA5nBjF3HKh1mXUYC86j0/bEL5PWZJEDO4Jzh5Auo/Knuf56pB5
IQLDeDuwqxJqvav9F1Uh
=LXM7
-----END PGP SIGNATURE-----

--O98KdSgI27dgYlM5--

--===============7025374932387537059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7025374932387537059==--
