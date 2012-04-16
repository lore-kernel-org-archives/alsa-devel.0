From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for PLL and SRM
Date: Mon, 16 Apr 2012 15:07:20 +0100
Message-ID: <20120416140719.GC3219@opensource.wolfsonmicro.com>
References: <1334122120.3991.13.camel@matrix>
	<20120413093012.GK3168@opensource.wolfsonmicro.com>
	<1334578993.26734.6.camel@matrix>
	<20120416125930.GB3219@opensource.wolfsonmicro.com>
	<1334583750.26734.15.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0491917312993100680=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 68ABF2442D
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 16:07:25 +0200 (CEST)
In-Reply-To: <1334583750.26734.15.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============0491917312993100680==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2012 at 07:12:30PM +0530, Ashish Chavan wrote:

> Thanks for bearing with me Mark. But the only other way I can think is
> to make the *extra* info like master/slave and fs a part of array itself
> and then search through the array to get required divisors. In this
> case, every time I need to search through entire array to pick up
> correct divisors. Wouldn't that be inefficient, especially when the
> array indexes are fixed? Or the readability/maintainability of that
> would outweigh slight performance overhead?

If there is a genuine performance concern there's plenty of other ways
to do it which would make it run faster.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPjCM0AAoJEBus8iNuMP3d3fsQAI7pOEe3MQwi3PlBg4K6ghWs
xYljmOAQ7vw/nQNG52TNzv9evD8ajNdzamppTr55fdFUS/dFP8ve6gSQ7vLjZSTe
xplQujy4d1p+5oMbavcZDwp+R8XmeoTm0/rSEhSpWxd4N3Id4qEVOE+/uJH1YJIb
v+FV7r+w42b0HvS1zW/bfWIumGhgp9p8HQgTYhwc3QFcqa/gIE0MKchVwGGMEf7/
a/7QFDEsrrP3f0YUJST7KHos5huFq5JRbrxtauk1+0G3bNCbq+z5NMqYsPCUgF0N
Mu3YykzM6N7ublwONlO1ESTM/j81g6bVg6cxj0RgUMbEf4kjcORce2vSCRIkx15V
G+7E92Gv4OTjMYrvej2SzS7AxHWl3tWlEDD1KiQjrr2mmIpgwJvdmAPN9el8Jjsu
b4yFS1N2GoWgRtnqGokrt1lcFizKHiGAsCFScUl/FkHlBJTdFUQO9aHkUonWtT7K
1YQs7pDGEYE/maoDI8y8xLGu2/eCPRDcRRA5CAHHygb5CMaLpjpONPPpceF5YVTL
e5+ttYPdPByHVfewn8Q4QnKcCMfqh8s5Q/ZK160isHxAfL6AQon+0VfTB3G3Dwyy
EAuHHXjUkrF9NM2CWrjcYOhDi9KpnPXqa01XRPvpzA6ChIdDfmOiV78Nmc+DGEm5
iW/CA/khMl90/yxX0L/r
=M34x
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

--===============0491917312993100680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0491917312993100680==--
