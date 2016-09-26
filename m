From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Mon, 26 Sep 2016 14:03:48 -0700
Message-ID: <20160926210348.fnbjknhrx655d5y4@sirena.org.uk>
References: <57E2B53C.6080708@maciej.szmigiero.name>
 <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
 <57E3074E.4070601@maciej.szmigiero.name>
 <8d5ad78b-3850-93bd-e299-215f001da9c2@denx.de>
 <57E318DB.3040600@maciej.szmigiero.name>
 <20160922104530.GL7994@sirena.org.uk>
 <0ae54910-0712-006c-0afa-a59b63a904be@maciej.szmigiero.name>
 <5506d5e4-4480-3a7d-9455-b314070bda7c@denx.de>
 <20160926191338.cxqqqq5eybxqxqss@sirena.org.uk>
 <4f47f4e7-2d13-93b0-52bd-c9aadc492cf8@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5972217730157352340=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2D3E265598
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 23:04:05 +0200 (CEST)
In-Reply-To: <4f47f4e7-2d13-93b0-52bd-c9aadc492cf8@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============5972217730157352340==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7x4pktop7fchocqx"
Content-Disposition: inline


--7x4pktop7fchocqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 26, 2016 at 09:25:51PM +0200, Marek Vasut wrote:

> commit 1bc8da4e143c0fd8807e061a66d91d5972601ab1
> Author: Lars-Peter Clausen <lars@metafoo.de>
> Date:   Thu Aug 4 17:22:16 2016 +0200

>     regmap: rbtree: Avoid overlapping nodes

This one is aimed for stable but we want to let it cook for a longer
than normal time (I was thinking just after the merge window) as it
feels unusually risky given that we keep uncovering unintended
consequences in this area.

--7x4pktop7fchocqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6Y0wAAoJECTWi3JdVIfQtDoH/2ZCsQ0EiWfB/lDvAEmpJjrD
k7Hv5qvz+QbbYFX+1JnhEJeuGq3LJJWDw8frvO9NygAcHAHYpGKWIpUAHwfaZVAA
qcwulkgg/t8leH/Azy5C9vmq7BY/rM75nwyhPMbPkhfdyazcu+Lp9xAkp/RDwl1z
bQvkKZjhcsDM3M4HsX7OOILXWxiXb2DPGVtglvOEEOL/NqK2oLg7QOMfzFXpKIVg
e72t7IKLP2UXD9Zo503A7boEneyGdGcl8VS5SIt8bQdXK7BvBoJekyKcN59+ujnx
RmLR3aEFozjrHXdKB2hgfDik4q481/lxLD4QGbkLenUUkPTZMkI0GGXJhEOwPGo=
=/jvt
-----END PGP SIGNATURE-----

--7x4pktop7fchocqx--

--===============5972217730157352340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5972217730157352340==--
