Return-Path: <SRS0=KPAB=BG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E7FC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:08:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AA92074F
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gm74MPgy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu31vcAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AA92074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3865A1683;
	Mon, 27 Jul 2020 15:08:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3865A1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595855330;
	bh=AMi2gLfyvz4Pzyz9YDmdVT9VjepzkPLuNlEIsAaH8BI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gm74MPgyL3VR6u5MH5tcASgNHkDfvSSTt7UVmVqdsSDY/geB1kTmqpETHcHGiAR75
	 iEVDCG1//Kjya8TNPa0RzVKIXoj3bcwjTYklTlM8UUk8nyu7z/4NKP48cb/WB0FbV8
	 1HgMptcHxYkwWBu106X0N8xTBV4KQ4D93VNsGvfw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADC3AF80158;
	Mon, 27 Jul 2020 15:07:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6BC2FF80171; Mon, 27 Jul 2020 15:07:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5412FF800DE
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2020 15:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5412FF800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Bu31vcAT"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E0363206D8;
 Mon, 27 Jul 2020 13:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595855271;
 bh=AMi2gLfyvz4Pzyz9YDmdVT9VjepzkPLuNlEIsAaH8BI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bu31vcATjTnv0NP8lHz08cxLsQPSaYLW4iYAv6mxr3RFeDNSNGfxWDyJX7piWPIzN
 ih6hB3pWOjzdlrbaL5J+qnSY+sMc28wF38/pShr+R7K9evW1IlBIVnZJoWao+ue2Ld
 /117aEdG7Xeh8NKJxF3cw9Q8RYnh8J5CBsbTOnHc=
Date: Mon, 27 Jul 2020 14:07:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Steve Lee <SteveS.Lee@maximintegrated.com>
Subject: Re: [PATCH 3/3] ASoC: max98390: update dsm param bin max size
Message-ID: <20200727130734.GD6275@sirena.org.uk>
References: <20200724085644.9837-1-steves.lee@maximintegrated.com>
 <20200724105059.GA5664@sirena.org.uk>
 <MWHPR11MB204753BF80DED8923AD3BEA292720@MWHPR11MB2047.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <MWHPR11MB204753BF80DED8923AD3BEA292720@MWHPR11MB2047.namprd11.prod.outlook.com>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "jack.yu@realtek.com" <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
 "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
 Ryan Lee <RyanS.Lee@maximintegrated.com>,
 "steves.lee.maxim@gmail.com" <steves.lee.maxim@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "krzk@kernel.org" <krzk@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>,
 "geert@linux-m68k.org" <geert@linux-m68k.org>,
 "dmurphy@ti.com" <dmurphy@ti.com>,
 "shumingf@realtek.com" <shumingf@realtek.com>,
 "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
 "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 02:00:09AM +0000, Steve Lee wrote:

> > I'm missing patches 1-2 and have no cover letter - what's the story with
> > dependencies?

>  I will re-send patch ang please ignore this patch.=20
> DSM init param is extended to cover more register so that DSM MAX PARAM S=
IZE value is changed.

I applied these on Friday having found the other two patches (you're not
sending things as a thread so they get lost, for example if someone
sends a big series at a similar time like what happened on Friday) so
your new version won't apply, please resend whatever change you want to
make as an incremental patch against current code.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8e0ZUACgkQJNaLcl1U
h9Aqawf9HopZUMhCAwGV7wiVa1eQ8XQk/OPZHjlLzQJWkumo48KLX9suSNS9hLM7
jiovx41l0JOBC1VXNa9PvWE+rl52Ugry0xNmYeGYTtk5aPj+7ugIA2qxtrKfXjen
QM1UrXRJjLv6LX7m+fF/YLa7ltOm81D6WJs6qt+vgBQJz0GjAx9ctk6Hx8ZqBylV
0IiGhsxIEzuPxipTKhu/F9KNRuCKcewTAZCOY9eATGIapp8JTx5YjelS6D6+Nd1G
366Zi9knBZBdZOrgM0wl19mw35BNG4RKhp1IrKjNzagiG19EMDnaGXuaX7awFyYH
lg2Y6n9jSDhN2VDYH9qdObYl+iZCtA==
=bS9e
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
