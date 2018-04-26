From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mt6797: switch to SPDX license tag
Date: Thu, 26 Apr 2018 12:42:44 +0100
Message-ID: <20180426114244.GD21755@sirena.org.uk>
References: <20180426025605.31874-1-kaichieh.chuang@mediatek.com>
 <7071d4e1-daf1-4847-1dbd-e5c77c709724@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4402261964019201192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0592C2676AB
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 13:42:46 +0200 (CEST)
In-Reply-To: <7071d4e1-daf1-4847-1dbd-e5c77c709724@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, KaiChieh Chuang <kaichieh.chuang@mediatek.com>
List-Id: alsa-devel@alsa-project.org


--===============4402261964019201192==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 12:46:54PM +0200, Matthias Brugger wrote:
> On 04/26/2018 04:56 AM, KaiChieh Chuang wrote:
> > diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> > index d42a9d9fbf3e..c3f58bac0960 100644
> > --- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> > +++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
> > @@ -1,17 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
> >   *

Please convert the entire header block to a C++ comment so it looks more
intentional that it's this way.

> > - * Author: Ryder Lee <ryder.lee@mediatek.com>
> > + * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>

> I think you don't want to delete the first author but add you as a second one.
> I've seen this in other parts of the patch as well. Please check.

Yeah, looks like an over eager removal of the license text boiler
plate.

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhuzQACgkQJNaLcl1U
h9DkEQf+InpRLVWfKBz6VTL9BOhOP3/37Zfv1QN7AXFVXKkvxBDKLLkppdUg5676
+Xue89XYIDQ8USWxMJElBBZQVJN79yFR5Ed8Wclg6/9m/xQ393vkgZBzezQIe7ms
Jx5X3vja2ex+6R5rT6ZFM4iuvHArowLn6ppndR9TgMjuO5Jq2bwbWck1O/GkXacj
Ond9n4J3PFMQURf7n0LL1fJ3zCbemFiywdIQ9TXI338pgGoyC7YGVsKkthtF9T/y
vMbVl/lmOwtJzRuUXddk4E0jluUWrQYMLAdjsRAoN43FasrzcHFAs2F0jftKkR2I
35MPtjIUNBbWFQBjYYiaKHLUJXvcZQ==
=k2S6
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--

--===============4402261964019201192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4402261964019201192==--
