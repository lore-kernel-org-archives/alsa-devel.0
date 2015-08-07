From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: Add imx7d platform
	support
Date: Fri, 7 Aug 2015 14:18:12 +0100
Message-ID: <20150807131812.GC10301@sirena.org.uk>
References: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
 <f269bace628dd8ebac7c1833b743d4d5e5d528db.1438928571.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2006044007849909909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B942260418
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 15:18:28 +0200 (CEST)
In-Reply-To: <f269bace628dd8ebac7c1833b743d4d5e5d528db.1438928571.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, tiwai@suse.com, nicoleotsuka@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2006044007849909909==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 02:23:52PM +0800, Zidan Wang wrote:
> i.MX7d SoC contains SAI module, so add imx7d platform support.
>=20
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 4 ++++
>  1 file changed, 4 insertions(+)

This needs a binding document update too.

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxLAUAAoJECTWi3JdVIfQoToH/02AWhSh4YT7EP0xPte5DX0X
Kq8SlucLMVxNcgUS+w8/WqGKf7Xznlo3MCAU+YyGq8d88L4ImoQ/Ohq54Y6LCDH0
XT46upHsLVIpv6v4PZmKKcaBlf85Hqvjegn0UyHBvEDrvMTMntAUJgEBXBlaX1VQ
s5LjMDwRti2iN/8PRfv9S17Z65UX2cPw0YgUq+2nf49CLp8u4NL1ynTzIfDE2I/c
qJhRaPlzT8tyZl+pOpppXQ4NY1sANosAU+CcsHa3KZ79CsFoBCF9gDqSQWAgZ8iK
eXcyjR0l9HjokVrgotjX2ySLQj0DfdmemRb7aUM4/gbXasR/CWzJ1pfsMaDtuhU=
=RmzK
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--

--===============2006044007849909909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2006044007849909909==--
