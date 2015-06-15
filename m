From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: rt5640: Constify ACPI device ids
 and register map
Date: Mon, 15 Jun 2015 11:19:40 +0100
Message-ID: <20150615101940.GH18309@sirena.org.uk>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
 <1434198316-8400-3-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5718350220284841128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8654260870
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 12:19:57 +0200 (CEST)
In-Reply-To: <1434198316-8400-3-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathias Krause <minipli@googlemail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============5718350220284841128==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SdvjNjn6lL3tIsv0"
Content-Disposition: inline


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2015 at 02:25:14PM +0200, Mathias Krause wrote:
> Constify the ACPI device ID array and the register map, no need to have
> them writable at runtime. Also drop the unneeded RT5640_INIT_REG_LEN
> define.
>=20
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Cc: Bard Liao <bardliao@realtek.com
> Cc: Oder Chiou <oder_chiou@realtek.com>

Please don't include stuff like this in the commit log if you're not
using it - you've CCed Oder but not Bard here (you should be CCing him).

--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfqa7AAoJECTWi3JdVIfQclUH/j8tZNdcf7GIcQ9gmHAh9jD2
5I8MxAQ98vz4Ujq5dNOY0ZCADwk9kivoQeLdk+gej/ZwtVa3BgECgO67V4vT5JvG
T9EcuEg1fMh4n2tvrO3wffsI6bIS+0e3rWsCsKhrPmXxzQxZ4LYgqablHnYqDIGr
txH525wVz45SoouRFP4ElyU44Gksmc5gXp6jm5fyBVrdjpMiEUmvBFfBSvgG7eeB
TDmH1KqoSqc/z5ZmIPVYJOYJwK2J8BW+1mbmhKUzGBXVXLdZBYTRme4YUpA2E0Vw
GopK/p3upM9QE+T9JpWMvDSTnKeqEuaISoMxiH3/Yc1XB33ksjwfrMnxXIKA9IQ=
=XvQw
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--

--===============5718350220284841128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5718350220284841128==--
