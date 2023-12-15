Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D41C35274
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Dec 2023 12:55:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F1D1E75;
	Fri, 15 Dec 2023 13:55:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F1D1E75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702644948;
	bh=GiYX2dByBC38vzkmfO+cvnHpKmaS1UwkM/jOuD6+MsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Mhtkx0K1/ePv57AjAU+mU5h0UCNz82vw5ykEiSaa/7cwb2+BesmjUmsufgaC9UFem
	 zCDToy6YVQQ06jMX1HCGg12j4uqB33TFf3LpQe76AD32AThVQ9latHw77igfrq+NZW
	 B6d5pvyZfKYCGlZS+v3yC6pHE6nRVmaqaC7AEbv0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C38FEF80579; Fri, 15 Dec 2023 13:55:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24240F8016A;
	Fri, 15 Dec 2023 13:55:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2F8DF8016A; Fri, 15 Dec 2023 13:55:11 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3DF2FF800D2
	for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2023 13:55:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3DF2FF800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QCEG2K7I
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id CCBEBB81D96;
	Fri, 15 Dec 2023 12:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C4EC433C7;
	Fri, 15 Dec 2023 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702644906;
	bh=GiYX2dByBC38vzkmfO+cvnHpKmaS1UwkM/jOuD6+MsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCEG2K7IiXiNW0BI/LX22IFcDdFusaB0moxk4gM3tIFE17Vusj49rkITKod49BNzQ
	 OxVv+oG3u0n7o5+DW57hrGNpYug3BGRf6cp3SxPegL+ozSQEOv4K+Ci6/93SRG35Kd
	 vxueSxAxnbKat/x7UDCu3vElVp5A1abi0elOXYrB1mBPR/pQ3oCAOcr1fTdZcnAGTg
	 tqJS3Eci1X+DdZhiSG+dUXr6c3hgEmGpQnlzCPqg2p/lyqjLXVH07YiOluruNjr4e2
	 ll/xiGi5OPW8PNKJ/2ORIQ4Xg/xHTSON/76jxQI3hp0romU3I8wGDHQACqGc3SqF4O
	 kN9Y2xYa6KH0Q==
Date: Fri, 15 Dec 2023 12:55:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 03/16] ASoC: tas2781: disable regmap regcache
Message-ID: <5b2eb7eb-761e-406d-8d55-b7ea8cddefa8@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <21a183b5a08cb23b193af78d4b1114cc59419272.1701906455.git.soyer@irl.hu>
 <0b836c10-b21b-4275-8dd0-254dd5467497@sirena.org.uk>
 <47097f19398808b64f4cc87c2a3c7cc462fb2416.camel@irl.hu>
 <5f3f0306-799f-4f3b-9e05-fbd300c59d5d@sirena.org.uk>
 <b0ab21657f2e4f0825579de97ca012e294d1e743.camel@irl.hu>
 <bf24488f-e4e1-4d3e-a67e-fe74c05acda4@sirena.org.uk>
 <9a2b85a8a19e002093e2471a97850d26e335900f.camel@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="shU18Ze4Jixd/qwv"
Content-Disposition: inline
In-Reply-To: <9a2b85a8a19e002093e2471a97850d26e335900f.camel@irl.hu>
X-Cookie: PARDON me, am I speaking ENGLISH?
Message-ID-Hash: 7TOD6MMSUDPJ3L7BQETJKSMVOJTCKBPF
X-Message-ID-Hash: 7TOD6MMSUDPJ3L7BQETJKSMVOJTCKBPF
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7TOD6MMSUDPJ3L7BQETJKSMVOJTCKBPF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--shU18Ze4Jixd/qwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 15, 2023 at 02:17:01AM +0100, Gergo Koteles wrote:
> On Thu, 2023-12-07 at 22:39 +0000, Mark Brown wrote:
> > On Thu, Dec 07, 2023 at 10:12:13PM +0100, Gergo Koteles wrote:
> > > On Thu, 2023-12-07 at 20:36 +0000, Mark Brown wrote:

> > > > The code creates the impression that writing to one tas2781 writes to
> > > > all of them, is that not the case?

> > > Yes, the tasdevice_* functions, but the regcache_sync doesn't know
> > > this.

> > So this syncing is done in software not hardware?  My understanding was
> > that this was a hardware thing.

> If you mean that the amplifier does not know that there are several
> programs or configurations or profiles, but only runs the current one,
> yes.

No, I mean that the amplifiers don't talk to each other at a hardware
level and the grouping is all in software.

--shU18Ze4Jixd/qwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV8TKQACgkQJNaLcl1U
h9BTCwf+Pa4K2iMEqoqOz+oegGtyQpvdi/qVCmxb4ZTXaxolUdaQy2PaXjRLd8HX
JvKRqh83icW7itxjaoT9Agm9u5YYtIitbHZa0EZgFPu7W7wbssEMC/PJDVde1FcF
roRv64St87ObvZdagd/XFu2ZGqmFkVbRuvwsiDMAL6XImcCmZPixV8rT73+Vef+U
FmJ7f31B6G07xb2nO5MklywF98z97eXc75Rg8QDleMNPe4/H6bDyLbfTDUF5DAnG
vIzC6Qxm5+dXLLa2V5yZhY0xWOCNJDrmwv7bv0c9M74QigdTTtsI/JmOIj0yJjg/
m5ZFOlNVFJgDi9IzWD5gcsxzhvTymA==
=DJ8M
-----END PGP SIGNATURE-----

--shU18Ze4Jixd/qwv--
