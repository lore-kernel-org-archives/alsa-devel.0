From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-sgtl5000: Add .remove back
Date: Tue, 1 Oct 2013 11:47:57 +0100
Message-ID: <20131001104757.GK19304@sirena.org.uk>
References: <1380590257-7516-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1478707260394579453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F052261A8D
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 12:48:02 +0200 (CEST)
In-Reply-To: <1380590257-7516-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: olof@lixom.net, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, p.zabel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============1478707260394579453==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nkAIkdqOakIAdIKa"
Content-Disposition: inline


--nkAIkdqOakIAdIKa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2013 at 10:17:37PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Commit e8f00c1b01 (Merge remote-tracking branch 'asoc/fix/fsl' into asoc-=
devm)=20
> fixed a conflict, but missed to add the .remove function back,which cause=
s the=20
> following build warning:

Applied, thanks.

--nkAIkdqOakIAdIKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSqhaAAoJELSic+t+oim9qGcQAJPS548YxfngQ/hB6DLQxecP
gDbgW6vQnPBsgDVqMurVdGY1k0yfUJNeS9M4EWpty2wCWdcyBt7cyDC7sHksL/tN
9bD5vdnBmkcPVG0+wirwS5zPtZ8Lnt+veqY0ZT/IwMTy0JvJmbXSNBm886cOzyAT
AgE4VtwkD6KQxH7IFAtEG6m/90rPTMvBTaRbiCXGsioD5kEbtEi9ZRym5RWSIOeC
6zOrzWYBWtHoLph/fTXimIyaF2PODne8snKAtUs/Y4/cil6fJc0eGraFh//MJ7/x
GF2esHJqvJyfBN+opCoXRANU+5nFXMCAEQ5IcJHX9ofzR5LtQEzl7lPF3cS7eggu
/c5lTTafjaOjHs86aMH1VZhMl+s/qUzKVP/Axn+IfMY7E+Z2Mhna81FY1CQIjEch
/TDPVvGgON7Y+/ReVTGQ/5A81D823gAgur7v+XnTdlc19Go1EwUY59pFbP2+5aAj
D1FVaOWj6lQDrHtIoeJkmLWUE6qYmUCx9CgxrrBaXpvdLnfoDNTT9QnommFstd8y
r3xs1BgN7vCM1lvrrnZcBDwVTEgV4wp4x1ekaI9QyaIR84ahgB//ANFyArtiq/Kv
QsHTZZkiBtJDexaO0GwZ409YIQvwVAWnKUrBWW+oW1SHNhp0nhmBGjebMHncJ4ub
ZBNBEYmMyvrFlXvTptJV
=CWnY
-----END PGP SIGNATURE-----

--nkAIkdqOakIAdIKa--

--===============1478707260394579453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1478707260394579453==--
