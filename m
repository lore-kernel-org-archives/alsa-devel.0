From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Modify the default value and
 add it to patch table
Date: Fri, 14 Nov 2014 10:46:14 +0000
Message-ID: <20141114104614.GV3815@sirena.org.uk>
References: <1415954853-2768-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2914007620097836339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E21DF266626
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 15:03:39 +0100 (CET)
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net
 ([94.175.94.161] helo=debutante)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1XpHTE-00026E-TE
 for alsa-devel@alsa-project.org; Fri, 14 Nov 2014 14:03:38 +0000
In-Reply-To: <1415954853-2768-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2914007620097836339==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UuQTlc5aGtyxLAxZ"
Content-Disposition: inline


--UuQTlc5aGtyxLAxZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 04:47:33PM +0800, Oder Chiou wrote:
> Modify the default value and add it to patch table

>  static const struct reg_default init_list[] = {
> -	{RT5677_PR_BASE + 0x3d,	0x364d},
> +	{RT5677_ASRC_12, 0x0018},
> +	{RT5677_PR_BASE + 0x3d, 0x364d},

These are named registers, you really need to provide some more clear
description of what is being changed and why (especially given that you
are changing the patch table as well so it's clear that this isn't just
the register default being wrong in the table).

--UuQTlc5aGtyxLAxZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZd11AAoJECTWi3JdVIfQ98sH/inLeyl30eLcqotrpAnp8JdJ
4gDOXF+6IjR4E1KNBwgHjVtSbSNfYFC+EvDww6dMJp4RHqt3g6wIKqWy1Lt8gLCb
M7uGsoOlbh3b47jd021z/Gr6LvPv2XiCuF5Y4EFk2xpgEhrYnxTsBA94VGnur9I8
Siev5/Xez1SdoRGGgVnjd8oPyqptF4HDf84gacjLgFQcAXReeKdm0dJrOmfuqM7w
C/r+QnZPDoHSAOscC4COLK4aKTEQVC8L4pVs56lJVDmEPunfuybqFGTQkyUtj9Wa
OuEEA+36AiFVlglqMWcvGHUuYfpPMeAvbn8AWUAZpfZZCyEoy7vmPYhf+08wlSw=
=rYfr
-----END PGP SIGNATURE-----

--UuQTlc5aGtyxLAxZ--

--===============2914007620097836339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2914007620097836339==--
