From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC/RFT] ASoC: rt5677: Convert to use
	rl6231_pll_calc
Date: Mon, 30 Jun 2014 19:42:59 +0100
Message-ID: <20140630184259.GD23300@sirena.org.uk>
References: <1402980091.13607.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7044234405462889587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C029265572
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 20:43:16 +0200 (CEST)
In-Reply-To: <1402980091.13607.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7044234405462889587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V1U121k6BDnjVM6n"
Content-Disposition: inline


--V1U121k6BDnjVM6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 12:41:31PM +0800, Axel Lin wrote:
> The implementation of rt5677_pll_calc() has the same logic of rl6231_pll_=
calc().
> The only difference is the lower boundary checking for freq_in.
>=20
> This patch calls rl6231_pll_calc() instead of open-coded.
> The k_bp of struct rt5677_pll_code is always false, thus also remove the
> code to check pll_code.k_bp.

Applied, thanks.

--V1U121k6BDnjVM6n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsa+wAAoJELSic+t+oim9WHoP/1Fu3e053Q3GXeePPqlzxoDP
zco45VJj32039uN28mzV1Fl58O7jfnYCc32bIanfuYRSMgHOboedEJ0MH6uEDAk0
cS2p0mdu0o4pm1daQvO0taPVZJgnWzE0oqtWX78tcfzBQIN4qHty73ycV/JGN8Z0
sH1rYujg0RFZdvabGzA46q3++6gZ3Wr10zmBUW+XQejSayst+0gUJ/DwjS9nc/Vi
BFse8DFEGr0VRpvUYqytZokPwqYwf5PYVfllcfkmUi+gTetrWFtSlULSCx/xm41n
ZFskykcsx9ezhIaXsfmLaijH6QlE+IPWAZDyHOcOqQCKNkU1vXnAqjrHSFTMOH6h
vMZ0z66EKMCduQBhYMRWXa81++tfSbESRNm/HmUDSuE/MkTMhfWA/6fKyKs+wKOx
XvdfMA6d9c5GjDO95PyDU2GEzgFr5TZAAnt6NzHLFo/iJoc8JK2mRM5wX+8LoLuK
prffC0mVVu9nw+km2HRcRuayOBE0KB3/fQzGX/MpBCIVJTUbxIwgCgxW1e7sx8L6
fxmmMmCeoB/Q2qVdapUOsRpFyaxVFddU8HhW/PmS49V0M6Jq13LopnFLXao8Kr9J
o9H6tfhCU9OKhI5sODVAA5pK0ZLLW5fp1EBDhLDLZAm7nsszZMViCQAn4kDMOvMW
CZuubM77PY6yS4XUTY7+
=BLKD
-----END PGP SIGNATURE-----

--V1U121k6BDnjVM6n--

--===============7044234405462889587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7044234405462889587==--
