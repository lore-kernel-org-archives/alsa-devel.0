From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8995: Remove unused pointer in
	hp_supply_event()
Date: Tue, 11 Feb 2014 12:28:49 +0000
Message-ID: <20140211122849.GL13533@sirena.org.uk>
References: <20140207233716.394de04b@spike>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1774614675542012096=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4473264F19
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 13:28:59 +0100 (CET)
In-Reply-To: <20140207233716.394de04b@spike>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1774614675542012096==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 11:37:16PM +0100, Christian Engelmayer wrote:
> Remove unused driver data pointer 'wm8995' in function hp_supply_event().
>=20
> Detected by Coverity: CID 141181.

Applied, thanks.

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+hd9AAoJELSic+t+oim9xW4P/Aykj8lHEzi/Aqubr8UULSGw
kEgwUJNANRh9ozKpkm+w6MtguDNN9qnr5W+H31DqYfbSOcHdLLTsrsvi3kxpoLAQ
ZqX5VPa5X6IAgQnhFdEYgNjgMbrrHULfOGel6D97OocT+N96txnKE3yQV3+y68vC
tr8i4OOEgTaGAscUKIvnrRKZS4a7wSb98OyaPJ9H2TDyopXHZeiw6KBtGqa3u81r
AnbmGwMIxIbTulI73AjfuIl1Md2S1NqXdnktpLNuh0TQge8IKzFCSMF6y6j77M8M
HU0MjXF4GDRuM/PAK3tMgBMa5l0I14zPgWOmFU0WpDN1fl8FqUp71C5lSGJ6dzPq
PkuU9GUBGWxqYxGVPn9YV0UnL35ETc3w9k0JU8NLAgp9mOGFhIwx0TGv+jq4XD8p
Rynoh34hWM8HxCwHQSwRJ9tjqKjdWqhirE3H9yANkzQRXRBIvBGMV17pFEE09yGV
5AVeNaf2XIDxswCdq2t266R1Yoy6sn5IsNQ/InKhp79H8LVIhvH4DjdeOzkAtY7s
7yaXJtB2djJ4OINtULR44hQNFzx+Glfn77jHHXQlx/aQuT7RazLj6i/RKbsZLwfA
wTk0qdTG2tZkKavUaqowXZpQRQHez9c8HssSKeycNvVN8LnaaNfdckvbx+167MTM
NjYZfiC61Oe2FXtpStzY
=ikw9
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--

--===============1774614675542012096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1774614675542012096==--
