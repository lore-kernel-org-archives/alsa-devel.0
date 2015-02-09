From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: Set use_single_rw flag for
	regmap
Date: Mon, 9 Feb 2015 15:08:50 +0800
Message-ID: <20150209070850.GE23228@finisterre.sirena.org.uk>
References: <1423464110-20483-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6685759283594107823=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F2BA626055E
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 08:09:19 +0100 (CET)
In-Reply-To: <1423464110-20483-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6685759283594107823==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2015 at 02:41:50PM +0800, Bard Liao wrote:
> RT5670 doesn't support auto incrementing writes so driver should
> set the use_single_rw flag for regmap.

Applied, thanks.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2F0CAAoJECTWi3JdVIfQVd4H/RT9/yWDWt4k/vpOxX096F9n
kGZ1opLdwjWdiUB0oYuhlTvkwtZfyo21npotGxwVxS/D1KSiwxuFEBKqEdnxXDpY
uXh3oSBfxopdta9uC1p99/EO6s29IzMs75/tpPiRpmU4zVLoZn57q3MeVegl8aak
TdWrp7euNIHKFgAhSNHqnsCzpJsVzNAk3Nmpy5E+lmt9PnySxKwBjJHUrCLYiWhn
LM3TSF7XaAgXmVmzC2uzTotDIGpv8O4fB2DxkPv6tA84zRXZa52m0r0H1UzqwhRr
+GZ5muUy1tfNFs6kM0r5fi0AMygjdj63cYkSrqbwtJX7QTfybD9zzekQWB8Q/ls=
=cVYp
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--

--===============6685759283594107823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6685759283594107823==--
