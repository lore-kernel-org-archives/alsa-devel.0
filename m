From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 17 Apr 2013 16:28:02 +0100
Message-ID: <20130417152802.GZ13687@opensource.wolfsonmicro.com>
References: <1364340938-17175-1-git-send-email-swarren@wwwdotorg.org>
 <20130327011511.GP18316@opensource.wolfsonmicro.com>
 <515377AD.9080704@wwwdotorg.org>
 <20130327230730.GA18316@opensource.wolfsonmicro.com>
 <1121E117AD4ECE49880A389A396215BB8718BB370D@rtitmbs7.realtek.com.tw>
 <516DD0D4.5070409@wwwdotorg.org>
 <20130417140147.GM13687@opensource.wolfsonmicro.com>
 <516EBD46.7020804@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3916510632292084353=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A57762616E1
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 17:28:46 +0200 (CEST)
In-Reply-To: <516EBD46.7020804@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3916510632292084353==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E0GpUEom8qu4+vDz"
Content-Disposition: inline


--E0GpUEom8qu4+vDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2013 at 09:18:30AM -0600, Stephen Warren wrote:
> On 04/17/2013 08:01 AM, Mark Brown wrote:

> > That said if boards generally don't use external supplies and use
> > the built in regulators then it's probably best to at least have
> > the driver assume that by default.

> So the issue here is that regulators aren't supposed to be optional,
> right? So if there's a reasonable chance that regulators would ever be
> needed, we should add them now.

> With board files, we probably could have just added them later, but
> with device tree (which is my use-case for this CODEC at least), the
> DT binding needs to specify which regulator(s) the device requires (if
> any) right from the start, so that all DTs will include the regulator
> definitions.

You can do the same thing with DT as you do with board files - make
those supplies an optional property and then if the property is missing
do the default thing.

--E0GpUEom8qu4+vDz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbr8rAAoJELSic+t+oim9tUcP/0AZZq4ZXmos1E4QZCbL+Dqf
RQGQZYQSA7dJIQ4Q7ZWePsINuevocUF53Q+gkbB12Izn5hUGZs/k86gOEblygJ/Y
NOWwoyzIDoiT9VF69l2b80iaHU9bwCBKuutqqc8913TCw43ExtvBFzeYHgrVITjP
mLC2TBMn54BDjTn9Fuk+OKr1lFp2tUc4N1h0YFbxYsAJN+MJdAn3dAoMfIC/Zz6g
tjrqVrm5k6mq2dxT2WDbJrk0j28QaJ7JsovVjhdJynHXNQr7wGfM5vm4L1LLrcvr
B3Qw4mxCF+psCD9nmhvpslhBlYNId93JmH2ZXJ81+mwPV988/CyiCc2l1Ng72Gtn
ORGyAGSJ3NRJZiB0y05VDnbvMrtEidtaUwvkOr8CKkuJumlrzEJ15Yx2rWIfbmzL
HJKMFBcMxRT4QIwmhddYH/sUQ1O2v0/KbLB/BHpEoRvXSwi+k/tZMkTfaLEeiPk6
bULXYL36bhFSAHsUOp+zGch6tBi4AShzeGCGLoyWqnkWrYkvmAtFopK+qE3v/WYJ
JG3J/oZLscrHXpA86MVvBg5Sf6qmdy0ba79eEQs+jayiePCIFT8Q5w+wd1uQbSZK
rX36j9jn/KonLHrQYip5+szk5xSbYNlCsUcBMIBBWlu3G1Z5CEGZUVYwVKaBoEkq
XZmDKySNSfeuJxtDK88T
=VAZm
-----END PGP SIGNATURE-----

--E0GpUEom8qu4+vDz--

--===============3916510632292084353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3916510632292084353==--
