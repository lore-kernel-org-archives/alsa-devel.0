Return-Path: <SRS0=hmI4=ZT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC630C432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:42:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752BA2073F
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c5xJceWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752BA2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAEED16FE;
	Wed, 27 Nov 2019 17:41:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAEED16FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574872934;
	bh=K0sknIIgZMudziZeTOAA2/lgDqY4pujmnzPn2qKKiR4=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5xJceWfPP0UhKkVaMtQ9xYkwonMk3UjaX/0Aa7aklFnPhW+TWSUe4lQdtK7/K9i3
	 V0nuDr58gPhZb/DaDLOyphqobWVuyJmTXFYK4bU8MefXL2QGOvm0qAwnEmdLni78Z0
	 7fYrQ8iaLxn4i1HvN0J2lgjwflLY9aq6aeeEQqjM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A32BF8013B;
	Wed, 27 Nov 2019 17:41:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCF45F8014D; Wed, 27 Nov 2019 17:41:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 8A9DCF800E9
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2019 17:41:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A9DCF800E9
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B6B30E;
 Wed, 27 Nov 2019 08:41:18 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 201213F68E;
 Wed, 27 Nov 2019 08:41:17 -0800 (PST)
Date: Wed, 27 Nov 2019 16:41:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Message-ID: <20191127164116.GE4879@sirena.org.uk>
References: <AM5PR1001MB0994720A0D615339A978E35C804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126170841.GC4205@sirena.org.uk>
 <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126175040.GD4205@sirena.org.uk>
 <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127123317.GA4879@sirena.org.uk>
 <AM5PR1001MB0994D842A2D7051F81A7765B80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127154030.GD4879@sirena.org.uk>
 <AM5PR1001MB099467ACADA4F7B6DDA5087480440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
In-Reply-To: <AM5PR1001MB099467ACADA4F7B6DDA5087480440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: In the war of wits, he's unarmed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "kernel@collabora.com" <kernel@collabora.com>,
 Support Opensource <Support.Opensource@diasemi.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [alsa-devel] [PATCHv2 6/6] ASoC: da7213: Add default clock
	handling
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
Content-Type: multipart/mixed; boundary="===============8972454939037878004=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8972454939037878004==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idY8LE8SD6/8DnRI"
Content-Disposition: inline


--idY8LE8SD6/8DnRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 04:33:12PM +0000, Adam Thomson wrote:
> On 27 November 2019 15:41, Mark Brown wrote:

> > Not sure I follow here - if we're configuring the PLL explicitly then
> > I'd expect the PLL to be configured first, then the SYSCLK, so I'd
> > expect that the automatic PLL configuration wouldn't kick in.

> The PLL in the codec relies on MCLK. The MCLK rate can be specified/configured
> by a machine driver using the relevant codec sysclk function, as is done in a
> number of drivers. Surely that has to happen first before we configure the PLL
> as the PLL functions needs to know what rate is coming in so the correct
> dividers can be applied for the required internal clocking to match up with the
> desired sample rates. I guess I'm still missing something regarding your
> discussion around SYSCLK?

The PLL configuration specifies both input and output clock rates (as
well as an input clock source) so if it's got to configure the MCLK I'd
expect the driver to figure that out without needing the caller to
separately set the MCLK rate.

--idY8LE8SD6/8DnRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3epysACgkQJNaLcl1U
h9Ah8Af+Jkfk+6DCF4lg0qjlDTkm9J28Cp9C51qea8Lkj15D3QYxiCSIngIkcLDK
84eJfTaOnIjDYOj8bMovS/ZNY/JlsT46Vq8tJ2fPnyy/ihAM9CwKeGjprpv6voik
JZZ3pStVuiu3l7tVBLoaDLGCITJPuV1pqeq+bZtbHs8Axdx9xyG2MF1iAWo9lgDw
YpiNzRe6AESbGV8Pun6PTdBa8rktnOiTyixjLaiUC/WnUAxqXkHw/dHMWjOtYfwk
PMc6a5y4lCHqvEM+x4g3gE2Z0B+wCjpDd71c6qWIxyyzYLNL0geN6ogF91EVVyVO
xoBoNjYno2poQcDELx6VE77/8mFKWw==
=g6G7
-----END PGP SIGNATURE-----

--idY8LE8SD6/8DnRI--

--===============8972454939037878004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8972454939037878004==--
