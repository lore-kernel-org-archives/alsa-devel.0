From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add mt6351 codec driver
Date: Thu, 26 Apr 2018 12:43:59 +0100
Message-ID: <20180426114359.GE21755@sirena.org.uk>
References: <20180426024144.13974-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7774280905658869072=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA4D92676AB
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:44:00 +0200 (CEST)
In-Reply-To: <20180426024144.13974-1-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============7774280905658869072==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 10:41:44AM +0800, KaiChieh Chuang wrote:
> --- /dev/null
> +++ b/sound/soc/codecs/mt6351.c
> @@ -0,0 +1,1506 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mt6351.c  --  mt6351 ALSA SoC audio codec driver
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
> + */

Please send a followup patch which just converts the entire header to a
C++ one so it looks more intentional - otherwise this looks great so
I'll apply it!

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhu34ACgkQJNaLcl1U
h9Ba2gf+Ohwc+K0SZJsqwOkOmj/1cEipBhN0VICxilStGAdT0kYJEiBY2BcPmIh6
T+KWBvMPaXSRFRiAneusAEG5NHJN63siQtmedDedwFrFXaO7ivKKXyesZalDKSIS
BAw+tRWjqk1dLufxwqeqTBAZ3sEcmEWl1drSjWQUU/mKGyLQlQTnknUCB9cz3ESW
y4jh1ZRKKDwGsdxpGqhwKmJbJbIyeWqERamRCy558Tmo3C/Sczo7Bfhmi43W75nP
sUtUFrPqNAdPdZnWNWDt6JL+EbpmKjAF97ZGySlsweYF4iJMp+k8S4Ef4orxhxXn
eqkv5YzQW2WEl7rXANIhdB0vVy/OFw==
=rObB
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

--===============7774280905658869072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7774280905658869072==--
