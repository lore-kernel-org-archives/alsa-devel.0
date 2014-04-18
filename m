From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix wrong OFFSET of
	STC_SYSCLK_DIV
Date: Fri, 18 Apr 2014 15:05:46 +0100
Message-ID: <20140418140546.GK12304@sirena.org.uk>
References: <1397813528-3083-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0074400712549228644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4331F26089A
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 16:06:03 +0200 (CEST)
In-Reply-To: <1397813528-3083-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0074400712549228644==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B2qqeP0Q02yiX6Uc"
Content-Disposition: inline


--B2qqeP0Q02yiX6Uc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 18, 2014 at 05:32:08PM +0800, Nicolin Chen wrote:
> It should use STC_SYSCLK_DIV_OFFSET. Thus fix it.

Applied, thanks.

--B2qqeP0Q02yiX6Uc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUTE3AAoJELSic+t+oim9YLMP/AjMGfchgVY9QiYwjtxx+lCL
7S7OTbxUCEN1aC2dn4PlG2HKgK9JXeP95QKR7Cnh9rIKX9T/XM/DFTn4NAIvqfma
4RMOKOnDy6xZWI4sFUTpSp03x/ipM8XOmubR48f3OIrMbsUd74MIOwQVtA5zJ3N2
q4yzGDDi/5AS1LIhrz3/1fggUBv/Pbm4qOWb3vAlVoqcfphqp5797uLAJbTZ9iCX
DH6NddN7cmy6XxzHkONRmKanI/7dVcQFW0InYEXzf/lOkXKXNH1Ovvb+gsVIKEBT
Tk3Vv7ZJWBSwTvqFjwmVtfU8E8DUtiXiuodK6rP0twqa2xrT0yPxy4Jt8iJTjGAj
hlxs05OW82dW6esycPVKbsns2SjePpEWNSPuuFXYx8iyKBL7ZSfKBskJ+jU+RTg3
JH0ODPN1drbLzANoft+2QIF1dYiElgpRHmTiyoVpj+JXucER5AdsbkXEDOIQp3eI
HhD9amQTsoTR4ygewDCynfq2l5OYca0ENKp7budMQjx6yFyIivqHedndhRJ732Zu
CG4ocRs0R/qL3PHalm9NWC0NVF4LLVmHM1e9/lhb8vvdkSqFA6MvsBtzjopVUixQ
5F8Kln9gqlFs7Icw6Z0kLQhKOxivbQttAX67LMUEv3tAY1XCTswhS8lLMUeP4ejM
igHEq56j0A+zmzuq2CuP
=wF+A
-----END PGP SIGNATURE-----

--B2qqeP0Q02yiX6Uc--

--===============0074400712549228644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0074400712549228644==--
